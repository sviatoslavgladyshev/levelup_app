//
//  AuthenticationManager.swift
//  problem_solving
//
//  Created by Britt Bauer Burney on 12/19/23.
//

import Foundation
import FirebaseAuth
import Firebase


struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
        
    }
}

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() {  }
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
       
        return AuthDataResultModel(user: authDataResult.user)
      
    }
    
}
