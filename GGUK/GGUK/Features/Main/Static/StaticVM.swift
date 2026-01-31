//
//  StaticVM.swift
//  GGUK
//
//  Created by VnPaz on 1/30/26.
//
import Foundation
import RealmSwift
import RxSwift
import RxCocoa



final class StaticVM {
   
    func fetchTotalText() -> String {
        let total = RealmFunc.fetchTotal()
        return "\(total)번의 인내"
    }
    
    func resetAll() -> String {
        RealmFunc.resetAll()
        return "0번의 인내"
    }
}
