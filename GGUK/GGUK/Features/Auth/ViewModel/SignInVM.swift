//
//  SignInVM.swift
//  GGUK
//
//  Created by VnPaz on 1/27/26.
//

import Foundation

class SignInVM {
    
    func isLoginEnabled(email: String, password: String) -> Bool {
        let id = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let pw = password.trimmingCharacters(in: .whitespacesAndNewlines)
        return !id.isEmpty && !pw.isEmpty
    }
    
    func signIn(email: String, password: String) async throws {
        try await SupabaseManager.shared.signIn(
          email: email,
          password: password
        )
    }
    
}
