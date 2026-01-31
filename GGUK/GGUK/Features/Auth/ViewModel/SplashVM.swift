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
        return loggedIn ? .main : .signIn
    }
    
}
