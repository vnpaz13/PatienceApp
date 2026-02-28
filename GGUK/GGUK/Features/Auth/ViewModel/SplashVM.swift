//
//  SplashVM.swift
//  GGUK
//
//  Created by VnPaz on 1/27/26.
//

import Foundation

final class SplashVM {
    func checkSession() async -> AppRoot {
        let loggedIn = await SupabaseManager.shared.hasValidSession()
        
        if loggedIn {
            if let userId = try? await SupabaseManager.shared.currentUserId() {
                try? RealmManager.shared.switchUser(userId: userId)
            }
            return .main
        } else {
            return .signIn
        }
    }
}
