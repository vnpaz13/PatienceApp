//
//  Realm.swift
//  GGUK
//
//  Created by VnPaz on 1/31/26.
//

import Foundation
import RealmSwift

final class CountState: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var totalCount: Int = 0
}


final class RealmFunc {

    private static func fetchCounter(realm: Realm) -> CountState {
        if let counter = realm.objects(CountState.self).first {
            return counter
        }

        let counter = CountState()

        try! realm.write {
            realm.add(counter)
        }

        return counter
    }

    static func incrementTotal() {
        let realm = try! RealmManager.shared.current()
        let counter = fetchCounter(realm: realm)

        try! realm.write {
            counter.totalCount += 1
        }
    }

    static func fetchTotal() -> Int {
        let realm = try! RealmManager.shared.current()
        let counter = fetchCounter(realm: realm)
        return counter.totalCount
    }

    static func resetAll() {
        let realm = try! RealmManager.shared.current()

        try! realm.write {
            realm.deleteAll()
        }
    }
}
