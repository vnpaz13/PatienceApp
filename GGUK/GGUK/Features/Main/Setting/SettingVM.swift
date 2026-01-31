//
//  SettingVM.swift
//  GGUK
//
//  Created by VnPaz on 1/27/26.
//

import UIKit

final class SettingVM {
    
    func logOut() async throws {
        try await SupabaseManager.shared.logOut()
    }
    
}

