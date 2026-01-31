//
//  StaticVC.swift
//  GGUK
//
//  Created by VnPaz on 1/27/26.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class StaticVC: UIViewController {
    private let viewModel = StaticVM()
    private let disposeBag = DisposeBag()
    
    
    private let totalLabel = UILabel()
    private let resetBT = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        totalLabel.text = viewModel.fetchTotalText()
    }
    
    private func bind() {
        resetBT.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                self.totalLabel.text = self.viewModel.resetAll()
            })
            .disposed(by: disposeBag)
    }
    
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(totalLabel)
        view.addSubview(resetBT)
        
        totalLabel.font = .systemFont(ofSize: 32, weight: .semibold)
        totalLabel.textColor = .label
        totalLabel.numberOfLines = 1

        resetBT.setTitle("전체기록 삭제", for: .normal)
        resetBT.titleLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
        resetBT.titleLabel?.textColor = .secondaryLabel
        resetBT.backgroundColor = .systemRed
        resetBT.layer.cornerRadius = 8
        
        totalLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(40)
        }
        
        resetBT.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.trailing.equalToSuperview().inset(10)
            make.leading.equalToSuperview().offset(10)
        }
    }
  
}
