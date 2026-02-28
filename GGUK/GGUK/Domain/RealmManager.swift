//
//  RealmManager.swift
//  GGUK
//
//  Created by VnPaz on 2/28/26.
//

import Foundation
import RealmSwift

final class RealmManager {

    static let shared = RealmManager()
    private init() {}

    private var realm: Realm?

    func current() throws -> Realm {
        if let realm { return realm }

        guard let userId = SessionStore.shared.currentUserId else {
            fatalError("No logged-in user")
        }

        let config = makeConfiguration(for: userId)
        let realm = try Realm(configuration: config)
        self.realm = realm
        return realm
    }

    func switchUser(userId: String) throws {
        SessionStore.shared.currentUserId = userId
        realm = try Realm(configuration: makeConfiguration(for: userId))
    }

    func clearSession() {
        SessionStore.shared.currentUserId = nil
        realm = nil
    }

    private func makeConfiguration(for userId: String) -> Realm.Configuration {
        var config = Realm.Configuration.defaultConfiguration

        let baseURL = FileManager.default.urls(
            for: .applicationSupportDirectory,
            in: .userDomainMask
        ).first!

        try? FileManager.default.createDirectory(
            at: baseURL,
            withIntermediateDirectories: true
        )

        config.fileURL = baseURL.appendingPathComponent("realm_\(userId).realm")
        return config
    }
}
