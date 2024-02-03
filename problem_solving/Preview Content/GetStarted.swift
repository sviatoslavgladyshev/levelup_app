import SwiftUI
import Firebase

struct GetStarted: View {
    @State private var name: String = ""

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
      
                Image("Text Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
                
                NavigationLink(destination: SignUp()) {
                    Text("Get Started")
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(width: 320)
                        .background(Color(.purple))
                        .font(.title2)
                        .cornerRadius(20)
                }
                .padding(.bottom, 20)
            }
            .padding()
        }
    }
}
        //OpenAI Call
//        .task {
//            do {
//                try await OpenAiService.shared.sendPromptToGPT(prompt: "I want to fix my blackjack problem")
//            } catch {
//                print(error.localizedDescription)}
//        }

struct GetStarted_Previews: PreviewProvider {
    static var previews: some View {
        GetStarted()
    }
}
