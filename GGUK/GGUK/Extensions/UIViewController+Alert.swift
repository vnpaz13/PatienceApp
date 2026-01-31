//
//  UIViewController+Alert.swift
//  GGUK
//
//  Created by VnPaz on 1/27/26.
//
import UIKit

extension UIViewController {
    
    // 경고 문구
    func showSimpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    
    func signUpAfterAlert(title: String, message: String, onOK: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            onOK?()
        })
        present(alert, animated: true)
    }
    
}

