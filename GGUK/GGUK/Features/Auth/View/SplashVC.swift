//
//  SplashVC.swift
//  GGUK
//
//  Created by VnPaz on 1/27/26.
//


import UIKit
import SnapKit

class SplashVC: UIViewController {
    
    private let viewModel = SplashVM()
    
    private let logoView: UIImageView = {
        let logoView = UIImageView()
        logoView.image = UIImage(named: "AppSymbol")
        logoView.contentMode = .scaleAspectFit
        logoView.translatesAutoresizingMaskIntoConstraints = false
        return logoView
    }()
    
    private let subLabel : UILabel = {
        let subLabel = UILabel()
        subLabel.text = "꾹 참지말고, 꾹 누르세요"
        subLabel.textColor = UIColor.secondaryLabel
        subLabel.font = UIFont.systemFont(ofSize: CGFloat(20), weight: .semibold)
        return subLabel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moveToMain()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#CB2B1F")
    }
    
    private func setupLayout() {
        view.addSubview(logoView)
        view.addSubview(subLabel)
        
        logoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 240, height: 240))
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(logoView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
    }
    
    private func moveToMain() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            Task {  [weak self] in
                guard let self else { return }
                let root = await self.viewModel.checkSession()
                AppRouter.setRoot(root, animated: true)
            }
        }
    }
    
}
