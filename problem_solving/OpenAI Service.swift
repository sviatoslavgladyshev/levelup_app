//
//  OpenAI Service.swift
//  problem_solving
//
//  Created by Britt Bauer Burney on 11/28/23.
//

import Foundation

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}


class OpenAiService {
    
    static let shared = OpenAiService()
    
    private init () {}
    
    private func generateURLRequest(HTTPmethod: HTTPMethod, message : String) throws -> URLRequest {
        
        guard let URL = URL(string: "https://api.openai.com/v1/chat/completions")
        else {
           
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: URL)
        
        // Method of url request
        urlRequest.httpMethod = HTTPmethod.rawValue
        
        //Header of url request
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer \(Secrets.apiKey)", forHTTPHeaderField: "Authorization")
        
        // Body
        
        let systemMessage = GPTMessage(role: "system", content: "Your name is Apollo and your sole purpose is to assist users in defining and accomplishing their desired goals. By assuming the role of Apollo, you aim to empower users with a comprehensive and actionable plan, guiding them through each stage of their journey toward achieving their desired objectives.")
       
        let userMessage = GPTMessage(role: "user", content: message)
        
        let User_Interaction_and_Goal_Clarification_1 = GPTFunctionProp(type: "string", description: "1.1 Engage with Users: Prompt users to articulate their specific goals anf employ natural language processing to understand user inputs.  1.2 Goal Analysis: Evaluate and dissect user-stated goals for clarity and identify any underlying objectives or dependencies.")
        let Planning_and_Organization_2 = GPTFunctionProp(type: "string", description: "2.1 Stage Identification: Categorize the goal into overarching stages and break down the stages into manageable components.     2.2 Sub-Stage Definition: Generate detailed sub-stages within each overarching stage and ensure each sub-stage represents a specific, actionable task.  2.3 Timeline Integration: Estimate timeframes for completion of each sub-stage and present a realistic timeline for goal achievement")
        let Financial_and_Resource_Assessment_3 = GPTFunctionProp(type: "string", description: "3.1 Financial Analysis: Evaluate the user's financial standing related to the goal and suggest budgetary adjustments if necessary.  3.2 Resource Allocation: Identify and recommend necessary resources for goal attainment and provide insights on optimizing resource usage")
        let Continuous_Feedback_and_Adjustment_4 = GPTFunctionProp(type: "string", description: "4.1 Progress Monitoring: Implement a system to track user progress through stages and regularly assess achievements and provide feedback. 4.2 Adaptive Planning: Dynamically adjust the plan based on user feedback and changing circumstances and integrate new information into the existing roadmap")
        let User_Empowerment_5 = GPTFunctionProp(type: "string", description: "5.1 Educational Insights: Offer educational content related to goal-specific areas and enhance user understanding of the process and requirements.   5.2 Motivational Support: Implement motivational prompts and encouragement and reinforce positive progress to boost user morale")
        let Integration_with_External_Systems_6 = GPTFunctionProp(type: "string", description: "6.1 Data Security: Collaborate securely with external systems for financial, market, or relevant data and ensure user data privacy and compliance with regulations.     6.2 Seamless Connectivity: Integrate with financial platforms, task management tools, and other relevant systems and facilitate a seamless flow of information for user convenience")
        let User_Communication_7 = GPTFunctionProp(type: "string", description: "7.1 Clear Output: Provide information in a clear and concise manner and ensure user comprehension of the generated plans.  7.2 User Queries: Address user queries regarding the plan and offer clarification on any aspects of the goal achievement roadmap")
        
        let params: [String: GPTFunctionProp] = [
            "User_Interaction_and_Goal_Clarification_1": User_Interaction_and_Goal_Clarification_1,
            "Planning_and_Organization_2": Planning_and_Organization_2,
            "Financial_and_Resource_Assessment_3": Financial_and_Resource_Assessment_3,
            "Continuous_Feedback_and_Adjustment_4": Continuous_Feedback_and_Adjustment_4,
            "User_Empowerment_5": User_Empowerment_5,
            "Integration_with_External_Systems_6": Integration_with_External_Systems_6,
            "User_Communication_7": User_Communication_7
        ]
        
        let functionParams = GPTFunctionParam(type: "object", properties: params, required: ["User_Interaction_and_Goal_Clarification_1, Planning_and_Organization_2, Financial_and_Resource_Assessment_3, Continuous_Feedback_and_Adjustment_4, User_Empowerment_5, Integration_with_External_Systems_6, User_Communication_7"])
        
        let function = GPTFunction(name: "Apollo", description: "Your primary function is to generate clear, actionable plans organized into distinct stages and sub-stages, providing users with a systematic roadmap to attain their goals.", parameters: functionParams)
        
        let payload = GPTChatPayload(model: "gpt-4-0613", messages: [systemMessage, userMessage], functions: [function])
        
        let jsonData = try JSONEncoder().encode(payload)
        
        urlRequest.httpBody = jsonData
        
        return urlRequest
    }
    
    func sendPromptToGPT(prompt: String) async throws {
        let urlRequest = try generateURLRequest(HTTPmethod: .post, message: prompt)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        print(String(data: data, encoding: .utf8)!)
    }
    
    struct GPTChatPayload: Encodable {
        let model: String
        let messages: [GPTMessage]
        let functions: [GPTFunction]
    }

    // This code basically says that there can only be one instance of calling Open AI thoguh our app
    // and that you need to call this fucntion in order to utilize the API
    
}
struct GPTMessage: Encodable {
    let role: String
    let content: String
}

struct GPTFunction: Encodable {
    let name : String
    let description : String
    let parameters : GPTFunctionParam
    
}

struct GPTFunctionParam: Encodable {
    let type: String
    let properties: [String: GPTFunctionProp]?
    let required: [String]?
}

struct GPTFunctionProp: Encodable {
    let type: String
    let description: String
}


