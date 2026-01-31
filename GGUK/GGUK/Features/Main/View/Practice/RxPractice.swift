////
////  MainVC.swift
////  GGUK
////
////  Created by VnPaz on 1/27/26.
////
//
//import UIKit
//import SnapKit
//import RxSwift
//import RxCocoa
//
//// 옵저버블 -> 발사 -> 000 -> [연산자] -> 구독처리 |
//
//// Observable - 데이터 이벤트
//// 구독을 할 수 있다
//// 기본 성질은 발사되고 끝
//
//// 10개 쏴라 Observable.just(10).map({$0})
//// 옵저버블은 구독이 가능하다
//
//// 연산자 3종류
//// 변형 - 옵저버블은 중간에 연산자를 끼워넣어서 상태 변형이 가능 트랜스폼 map
//// 필터링 - 거르기, 필터, 스킵,
//// 합치기 -
//
//
//// 1. Observable : 총알
//// onNext, onCompleted, onError, onDisposed
//// just, of, create - 일반적인 형태로는 끝난다.
//// API 요청 응답처리 : 클로저 응답 -> Rx로 변경 가능
//
//// 2. Subject
//// 이벤트를 계속 받는 상황 => Subject (연결이 안 끊김)
//// BehaviorSubject, PublishSubject
//// PublishSubject -> 버튼, 팝업, 토스트
//// BehaviorSubject -> 변수 역할
//// Subject는 연결을 끊을 수 있음
//
//// 2.1 Relay
//// Subject의 연결이 끊기지 않기 위해
//
//// Subject의 연산처리를 묶어 줄 수가 있다.
//// Event가 한번 발생 시 정리하기 위해 Observable을 중간에 넣어서 처리
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
//    private let countRelay = BehaviorRelay(value: 0)
//    
//    // just event
//    private let publishSubject = PublishSubject<Int>()
//    private let behaviorSubject = BehaviorSubject<Int>(value: 10)
//    
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
//        // Observable<String>
//        someObservable = publishSubject.map({ $0 + 1 }).map({ "string : \($0)"})
//        
//        titleObservable = publishSubject.map({ $0 + 1 }).map({ "ui logic : \($0)"})
//        
//        titleObservable.bind(to: self.countLabel.rx.text).disposed(by: disposeBag)
//        
//        behaviorSubject
//            .skip(1)
//            .subscribe(onNext: { [weak self] value in
//                print("behaviorSubject : \(value)")
//            })
//            .disposed(by: disposeBag)
//        
//        
//        someObservable // String
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { [weak self] in
//                let test = $0
//                self?.countLabel.text = "\($0)"
//            })
//            .disposed(by: disposeBag)
//        
//        
//        someObservable.subscribe(onNext: {
//            print("someOB int \($0)")
//        }, onError: { err in
//            print("someOB err: \(err)")
//        }, onCompleted: {
//            print("someOB completed")
//        }, onDisposed: {
//            print("someOB onDisposed")
//        })
//        .disposed(by: disposeBag)
//        
//        publishSubject.subscribe(onNext: {
//            print("s int \($0)")
//        }, onError: { err in
//            print("s err: \(err)")
//        }, onCompleted: {
//            print("s completed")
//        }, onDisposed: {
//            print("s onDisposed")
//        })
//        .disposed(by: disposeBag)
//        
//        publishSubject
//            .map({$0 + 1})
//            .subscribe(onNext: {
//            print("s1 int \($0)")
//        }, onError: { err in
//            print("s1 err: \(err)")
//        }, onCompleted: {
//            print("s1 completed")
//        }, onDisposed: {
//            print("s1 onDisposed")
//        })
//        .disposed(by: disposeBag)
//        
//        publishSubject
//            .map({$0 + 10})
//            .subscribe(onNext: {
//            print("s2 int \($0)")
//        }, onError: { err in
//            print("s2 err: \(err)")
//        }, onCompleted: {
//            print("s2 completed")
//        }, onDisposed: {
//            print("s2 onDisposed")
//        })
//        .disposed(by: disposeBag)
//        
//        // int 10
//        // int 10
//        // int 10
//        // completed
//        // just, of, create -> 한번 하면 끝, 종료가 된다
//        Observable<Int>.create { observer in
//            
//            observer.on(.next(10))
//            observer.on(.error(MyError.someErr))
//            observer.on(.completed)
//            
//            observer.on(.next(10))
//            observer.on(.next(10))
//            
////
//            observer.on(.error(MyError.someErr))
//            
//            return Disposables.create()
//        }
//            .subscribe(onNext: {
//                print("int \($0)")
//            }, onError: { err in
//                print("err: \(err)")
//            }, onCompleted: {
//                print("completed")
//            }, onDisposed: {
//                print("onDisposed")
//            })
//            .disposed(by: disposeBag)
//        
//        //oneSubscription.dispose()
////
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
//    // 입력 -> 데이터
//    
//    // 데이터 변경 -> 그림
//    
//    private func bind() {
//        // button tapped -> count +1
//        // 입력
//        //        touchButton.rx.tap
//        //            .withLatestFrom(countRelay)
//        //            .map { $0 + 1 }
//        //            .bind(to: countRelay)
//        //            .disposed(by: disposeBag)
//        
//        touchButton.rx.tap
//            
//        //            .withUnretained(self)
//        //            .bind(onNext: { (self, _) in
//        //                let updatedValue = self.countRelay.value + 1
//        //                self.countRelay.accept(updatedValue)
//        //            })
//            .bind(onNext: { [weak self] in
//                guard let self = self else { return }
//                self.publishSubject.onNext(10)
//                let currentValue : Int = try! self.behaviorSubject.value() ?? 0
//                self.behaviorSubject.onNext(currentValue + 1)
//                let updatedValue = countRelay.value + 1
//                
////                if updatedValue == 3 {
////                    self.publishSubject.onCompleted()
////                }
//                
//                // 이베
//                countRelay.accept(updatedValue)
//            })
//            .disposed(by: disposeBag)
//        
//        // 버튼을 눌렀다 - 사용자 입력
//        
//        // 데이터 변경에 대한 구독
//        // 숫자 변수 값을 1 증가
//        // 숫자 -> 한글로 바꾼다
//        // 한글 - 라벨
//        
//        // 데이터 변경 감지
//        // count -> convert Text
////        countRelay
////            .map { "\($0)번의 인내" }
////            .bind(to: countLabel.rx.text)
////            .disposed(by: disposeBag)
//        
//  
//    }
//    
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
