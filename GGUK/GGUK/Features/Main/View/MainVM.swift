//
//  MainVM.swift
//  GGUK
//
//  Created by VnPaz on 1/27/26.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa


struct Quote {
    let text: String
    let speaker: String
}

enum QuoteList {
    static let quote: [Quote] = [
        Quote(text: "분노는 무모함으로 시작해 후회로 끝난다", speaker: "피타고라스"),
        Quote(text: "인내심은 마음의 힘을 키우는 것이다", speaker: "롱펠로"),
        Quote(text: "깊은 강물은 돌을 던져도 흐리지 않는다", speaker: "채근담"),
        Quote(text: "분노는 바보들의 가슴속에서만 살아간다", speaker: "아인슈타인"),
        Quote(text: "감정의 폭발은 곧 이성의 결함을 보여준다", speaker: "아리스토텔레스"),
        Quote(text: "분노는 지성의 빛을 끄는 바람이다", speaker: "간디"),
        Quote(text: "분노는 스스로를 소모하는 불꽃이다", speaker: "괴테"),
        Quote(text: "분노는 우리 삶의 모든 면을 파괴하는 병이다", speaker: "도스토옙스키"),
    ]
    
    static func random() -> Quote {
        guard let quote = quote.randomElement() else {
            fatalError("quotes 배열이 없습니다")
        }
        return quote
    }
}


final class MainVM {
    
    func recordTap() {
        RealmFunc.incrementTotal()
    }
    
}
