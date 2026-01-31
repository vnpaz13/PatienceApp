//
//  UIViewController+DisableSuggestions.swift
//  GGUK
//
//  Created by VnPaz on 1/27/26.
//

import UIKit

// MARK: -  키보드 추천 바 없애기
extension UITextField {
    func disableSuggestions() {
        autocorrectionType = .no
        spellCheckingType = .no
        autocapitalizationType = .none
        textContentType = .none
        smartDashesType = .no
        smartQuotesType = .no
        smartInsertDeleteType = .no
        inputAssistantItem.leadingBarButtonGroups = []
        inputAssistantItem.trailingBarButtonGroups = []
    }
}

