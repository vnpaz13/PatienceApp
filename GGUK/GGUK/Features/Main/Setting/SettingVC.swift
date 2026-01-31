//
//  SettingVC.swift
//  GGUK
//
//  Created by VnPaz on 1/27/26.
//

import UIKit
import SnapKit

class SettingVC: UIViewController {

    
    private let viewModel = SettingVM()
    
    private lazy var logOutBT : UIButton = {
       let logOutBT = UIButton()
        logOutBT.setTitle("로그아웃", for: .normal)
        logOutBT.titleLabel?.font = .systemFont(ofSize: 16)
        logOutBT.backgroundColor = .systemRed
        logOutBT.layer.cornerRadius = 8
        logOutBT.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
        return logOutBT
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupUI()
    }

    
    private func setupUI() {
        view.addSubview(logOutBT)
        
        logOutBT.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
    
    @objc func logOutTapped() {
        Task { [weak self] in
            guard let self else { return }
            do {
                try await self.viewModel.logOut()
                AppRouter.setRoot(.signIn, animated: true)
            } catch {
                self.showSimpleAlert(title: "로그아웃 실패", message: error.localizedDescription)
            }
        }
    }
}
