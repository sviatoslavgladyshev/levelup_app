//
//  SignUp.swift
//  problem_solving
//
//  Created by Britt Bauer Burney on 12/19/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

@MainActor
final class SignUpViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn()  {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Success")
                print(returnedUserData)
            } catch let error as NSError {
                print("Error: \(error.localizedDescription)")
                print("Error Details: \(error.userInfo)")
            }
        }
    }
}

struct SignUp: View {
    @StateObject private var viewModel = SignUpViewModel()
    @State private var isSliderViewActive = false // New state variable for navigation

    var body: some View {
        ScrollView {
            VStack {
                CustomHeightSpacer(height: 80)

                TextField("Email", text: $viewModel.email)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)

                CustomHeightSpacer(height: 1)

                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)

                CustomHeightSpacer(height: 1)

                Button {
                    viewModel.signIn()
                    // Set the state variable to trigger navigation to SliderView
                    isSliderViewActive = true
                } label: {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(width: 320)
                        .background(Color(.purple))
                        .font(.title2)
                        .cornerRadius(20)
                }
                .background(
                    NavigationLink(
                        destination: SliderView(),
                        isActive: $isSliderViewActive
                    ) {
                        EmptyView()
                    }
                    .hidden()
                )

                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea(.keyboard)
    }
}



struct CustomHeightSpacer: View {
    let height: CGFloat

    var body: some View {
        Color.clear
            .frame(height: height)
    }
}

#Preview {
    SignUp()
}
