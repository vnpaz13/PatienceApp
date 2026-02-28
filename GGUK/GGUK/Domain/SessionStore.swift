//
//  SessionStore.swift
//  GGUK
//
//  Created by VnPaz on 2/28/26.
//

import Foundation

final class SessionStore {
    static let shared = SessionStore()
    private init() {}

    private let key = "currentUserId"

    var currentUserId: String? {
        get { UserDefaults.standard.string(forKey: key) }
        set {
            if let newValue {
                UserDefaults.standard.set(newValue, forKey: key)
            } else {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
}
