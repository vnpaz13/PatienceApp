//
//  SignUpVM.swift
//  GGUK
//
//  Created by VnPaz on 1/27/26.
//

import Foundation

struct UserInfoDup: Decodable {
    let id: UUID
}

class SignUpVM {
    
    func isLoginEnabled(email: String, password: String) -> Bool {
        let id = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let pw = password.trimmingCharacters(in: .whitespacesAndNewlines)
        return !id.isEmpty && !pw.isEmpty
    }
 
    
    func checkUserIDDuplicate(_ userEmail: String) async throws -> Bool {
        return try await SupabaseManager.shared.checkUserIDDuplicate(userEmail)
    }
  
    func signUp(email: String, password: String) async throws {
        try await SupabaseManager.shared.signUp(
          email: email,
          password: password
        )
    }
    
    
}
