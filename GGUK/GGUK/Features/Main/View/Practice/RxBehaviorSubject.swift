//
//  RxBehaviorSubject.swift
//  GGUK
//
//  Created by VnPaz on 1/30/26.
//

//import UIKit
//import SnapKit
//import RxSwift
//import RxCocoa
//
//enum MyError : Error {
//    case someErr
//}
//
//
//class MainVC: UIViewController {
//    
//    // Rx
//    private let disposeBag = DisposeBag()
//    private let countSubject = BehaviorSubject<Int>(value: 0)
//
//    // UI-Property
//    private let scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.alwaysBounceVertical = false
//        return scrollView
//    }()
//    
//    private let contentView = UIView()
//    
//    private let dateLabel = UILabel()
//    private let randomQuote = QuoteList.random()
//    private let quoteLabel = UILabel()
//    private let speakerLabel = UILabel()
//    private let countLabel = UILabel()
//    private let touchButton = UIButton()
//    private let guideLabel = UILabel()
//    
//    // buttonSize
//    private let maxButtonSize: CGFloat = 240
//    
//    private var someObservable : Observable<String> = Observable<String>.empty()
//    private var titleObservable : Observable<String> = Observable<String>.empty()
//    
//    // Life-Cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setupUI()
//        bind()
//        
//    }
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        // Make Button Circle
//        touchButton.layer.cornerRadius = maxButtonSize / 2
//    }
//    
//    // UI-Setup
//    private func setupUI() {
//        
//        // dateLabel Setting
//        dateLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
//        dateLabel.textColor = UIColor.label
//        dateLabel.textAlignment = .center
//        dateLabel.text = dateToString()
//        
//        // quoteLabel Setting
//        quoteLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
//        quoteLabel.textColor = UIColor.secondaryLabel
//        quoteLabel.numberOfLines = 1
//        quoteLabel.textAlignment = .center
//        quoteLabel.text = "\"\(randomQuote.text)\""
//        
//        // speakerLabel Setting
//        speakerLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
//        speakerLabel.textColor = UIColor.secondaryLabel
//        speakerLabel.text = "- \(randomQuote.speaker) -"
//        
//        // countLabel Setting
//        countLabel.font = UIFont.systemFont(ofSize: 40, weight: .medium)
//        countLabel.textColor = UIColor.systemRed
//        countLabel.textAlignment = .center
//        
//        // touchButton Setting
//        touchButton.backgroundColor = UIColor.systemRed
//        touchButton.layer.borderWidth = 1
//        touchButton.layer.borderColor = UIColor.systemGray4.cgColor
//        touchButton.clipsToBounds = true
//        touchButton.setTitle("忍", for: .normal)
//        touchButton.setTitleColor(.systemBackground, for: .normal)
//        touchButton.titleLabel?.font = .systemFont(ofSize: 60, weight: .semibold)
//        
//        
//        // guideLabel Setting
//        guideLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
//        guideLabel.textColor = UIColor.secondaryLabel
//        guideLabel.textAlignment = .center
//        guideLabel.text = "빡칠 때마다, 버튼을 눌러주세요"
//        
//        // Attach On View
//        self.view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//        
//        contentView.addSubview(dateLabel)
//        contentView.addSubview(quoteLabel)
//        contentView.addSubview(speakerLabel)
//        contentView.addSubview(countLabel)
//        contentView.addSubview(touchButton)
//        contentView.addSubview(guideLabel)
//        
//        // instead of NSLayoutConstraint.activate([ ])
//        
//        scrollView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//        }
//        
//        contentView.snp.makeConstraints { make in
//            make.edges.equalTo(scrollView.contentLayoutGuide)
//            make.width.equalTo(scrollView.frameLayoutGuide)
//        }
//        
//        dateLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(40)
//            //            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
//            //            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
//            //            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
//            make.leading.trailing.equalToSuperview().inset(20)
//            make.height.equalTo(50)
//        }
//        
//        quoteLabel.snp.makeConstraints { make in
//            make.top.equalTo(dateLabel.snp.bottom).offset(20)
//            make.leading.trailing.equalToSuperview().inset(20)
//            make.height.equalTo(20)
//        }
//        
//        speakerLabel.snp.makeConstraints { make in
//            make.top.equalTo(quoteLabel.snp.bottom).offset(5)
//            make.centerX.equalToSuperview()
//            make.height.equalTo(20)
//        }
//        
//        countLabel.snp.makeConstraints { make in
//            make.top.equalTo(speakerLabel.snp.bottom).offset(30)
//            make.leading.trailing.equalToSuperview().inset(20)
//            make.height.equalTo(40)
//        }
//        
//        touchButton.snp.makeConstraints { make in
//            make.top.equalTo(countLabel.snp.bottom).offset(30)
//            make.centerX.equalToSuperview()
//            make.size.equalTo(maxButtonSize)
//        }
//        
//        guideLabel.snp.makeConstraints { make in
//            make.top.equalTo(touchButton.snp.bottom).offset(20)
//            make.bottom.equalToSuperview().inset(40)
//            make.centerX.equalToSuperview()
//            make.height.equalTo(20)
//        }
//        
//    }
//
//
//    private func bind() {
//        touchButton.rx.tap
//            .subscribe(onNext: { [weak self] in
//                guard let self else { return }
//                
//                // BehaviorSubject에서 현재 값 꺼내기 (throw 가능)
//                let current = (try? self.countSubject.value()) ?? 0
//                let updated = current + 1
//                
//                // 저장 (방출)
//                self.countSubject.onNext(updated)
//            })
//            .disposed(by: disposeBag)
//        
//        countSubject
//            .subscribe(onNext: { [weak self] value in
//                guard let self else { return }
//                self.countLabel.text = "\(value)번의 인내"
//            })
//            .disposed(by: disposeBag)
//    }
//
//}
//
//extension MainVC {
//    
//    func dateToString() -> String {
//        let currentDate = Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "ko")
//        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
//        return dateFormatter.string(from:currentDate)
//    }
//    
//}
