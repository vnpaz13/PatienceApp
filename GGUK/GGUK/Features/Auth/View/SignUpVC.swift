//
//  SignUpVC.swift
//  GGUK
//
//  Created by VnPaz on 1/27/26.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

@MainActor
class SignUpVC: UIViewController {
    
    private var viewModel = SignUpVM()
    
    // MARK: - SignUp Activation Property (Invent Duplicate)
    private var isUserIDAvailable: Bool = false
    private var lastCheckedUserID : String = ""
    
    // MARK: - ViewProperty
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        scrollView.keyboardDismissMode = .interactive
        return scrollView
    }()
    
    private let contentView = UIView()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "회원가입 하세요!"
        titleLabel.textColor = .label
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        return titleLabel
    }()
    
    private let idLabel: UILabel = {
        let idLabel = UILabel()
        idLabel.text = "아이디"
        idLabel.textColor = .secondaryLabel
        idLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        return idLabel
    }()
    
    private let idView: UIView = {
        let idView = UIView()
        idView.backgroundColor = .secondarySystemBackground
        idView.layer.cornerRadius = 8
        idView.layer.borderWidth = 1
        idView.layer.borderColor = UIColor.opaqueSeparator.cgColor
        return idView
    }()
    
    private lazy var idTF: UITextField = {
        let idTF = UITextField()
        idTF.placeholder = "example@email.com"
        idTF.font = .systemFont(ofSize: 16)
        idTF.tintColor = .systemRed
        idTF.keyboardType = .emailAddress
        idTF.addTarget(self, action: #selector(idChanged), for: .editingChanged)
        idTF.keyboardType = .emailAddress
        return idTF
    }()
    
    private let idIcon: UIImageView = {
        let idIcon = UIImageView()
        idIcon.tintColor = UIColor.secondaryLabel
        idIcon.image = UIImage(systemName: "person")
        idIcon.contentMode = .scaleAspectFill
        return idIcon
    }()
    
    private let pwLabel: UILabel = {
        let pwLabel = UILabel()
        pwLabel.text = "비밀번호"
        pwLabel.textColor = .secondaryLabel
        pwLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        return pwLabel
    }()
    
    private var showPassword: Bool = false
    
    private let pwView: UIView = {
        let pwView = UIView()
        pwView.backgroundColor = .secondarySystemBackground
        pwView.layer.cornerRadius = 8
        pwView.layer.borderWidth = 1
        pwView.layer.borderColor = UIColor.opaqueSeparator.cgColor
        return pwView
    }()
    
    private let pwIcon: UIImageView = {
        let pwIcon = UIImageView()
        pwIcon.image = UIImage(systemName: "lock")
        pwIcon.tintColor = .secondaryLabel
        pwIcon.contentMode = .scaleAspectFit
        return pwIcon
    }()
    
    private lazy var pwTF: UITextField = {
        let pwTF = UITextField()
        pwTF.placeholder = "비밀번호를 입력하세요"
        pwTF.font = .systemFont(ofSize: 16)
        pwTF.tintColor = .systemRed
        pwTF.keyboardType = .default
        pwTF.isSecureTextEntry = true
        pwTF.textContentType = .password
        pwTF.addTarget(self, action: #selector(pwChanged), for: .editingChanged)
        return pwTF
    }()
    
    private lazy var pwTB: UIButton = {
        let pwTB = UIButton(type: .system)
        pwTB.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        pwTB.tintColor = .secondaryLabel
        pwTB.addTarget(self, action: #selector(pwVisible), for: .touchUpInside)
        return pwTB
    }()
    
    private lazy var dupBT: UIButton = {
        let dupBT = UIButton()
        dupBT.setTitle("중복", for: .normal)
        dupBT.setTitleColor(.label, for: .normal)
        dupBT.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        dupBT.backgroundColor = .systemRed
        dupBT.layer.cornerRadius = 8
        dupBT.addTarget(self, action: #selector(dupTapped), for: .touchUpInside)
        return dupBT
    }()
    
    private lazy var signUpBT: UIButton = {
        let upBT = UIButton()
        upBT.setTitle("가입하기", for: .normal)
        upBT.setTitleColor(.label, for: .normal)
        upBT.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        upBT.backgroundColor = .systemRed
        upBT.layer.cornerRadius = 8
        upBT.isEnabled = false
        upBT.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return upBT
    }()
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        self.navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        loadBackButton()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        keyboardDismissGesture()
        keyboardSetUp()
        updateSignUpButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    // MARK: - UI
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(idLabel)
        contentView.addSubview(idView)
        idView.addSubview(idIcon)
        idView.addSubview(idTF)
        contentView.addSubview(pwLabel)
        contentView.addSubview(pwView)
        pwView.addSubview(pwIcon)
        pwView.addSubview(pwTF)
        pwView.addSubview(pwTB)
        contentView.addSubview(dupBT)
        contentView.addSubview(signUpBT)
        
        
        // scrollView Setting
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // contentView Setting
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            
        }
        
        // titleLabel Setting
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(140)
            make.leading.equalToSuperview().offset(25)
            make.height.equalTo(18)
        }
        
        // MARK: - ID Setting
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(25)
            make.height.equalTo(12)
        }
        
        idView.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(75)
            make.height.equalTo(52)
        }
        
        idIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        idTF.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(idIcon.snp.trailing).offset(12)
            make.trailing.equalTo(idView.snp.trailing).inset(12)
            make.top.bottom.equalTo(idView).inset(5)
        }
        
        // MARK: - PW Setting
        pwLabel.snp.makeConstraints { make in
            make.top.equalTo(idView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(25)
            make.height.equalTo(16)
        }
        
        pwView.snp.makeConstraints { make in
            make.top.equalTo(pwLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        pwIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        pwTF.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(pwIcon.snp.trailing).offset(12)
            make.trailing.equalTo(pwView.snp.trailing).inset(42)
            make.top.bottom.equalTo(pwView).inset(5)
        }
        
        pwTB.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(pwView.snp.trailing).inset(12)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        // MARK: - Duplicate Button & SignUp Button
        dupBT.snp.makeConstraints { make in
            make.leading.equalTo(idView.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalTo(idView)
            make.height.equalTo(52)
        }
        
        signUpBT.snp.makeConstraints { make in
            make.top.equalTo(pwView.snp.bottom).offset(200)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
            make.bottom.equalTo(contentView.snp.bottom).inset(20)
        }
        
    }
    
    // MARK: - Keyboard Notification
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let curveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
                
        else { return }
        
        let bottomInset = keyboardFrame.height - view.safeAreaInsets.bottom
        scrollView.contentInset.bottom = bottomInset
        scrollView.scrollIndicatorInsets.bottom = bottomInset
        
        let options = UIView.AnimationOptions(rawValue: curveRaw << 16)
        UIView.animate(withDuration: duration, delay: 0, options: options) {
            self.view.layoutIfNeeded()
            self.signUpVisible(animated: false)
        }
        
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.scrollIndicatorInsets.bottom = 0
    }
    
    // MARK: - Keyboard & ScrollView
    private func signUpVisible(animated:Bool = true) {
        let buttonRect = signUpBT.convert(signUpBT.bounds, to: scrollView)
        
        var visibleRect = scrollView.bounds
        visibleRect.origin = scrollView.contentOffset
        visibleRect = visibleRect.inset(by: scrollView.adjustedContentInset)
        
        let padding: CGFloat = 12
        let paddedButtonRect = buttonRect.insetBy(dx: 0, dy: -padding)
        
        guard !visibleRect.contains(paddedButtonRect) else { return }
        scrollView.scrollRectToVisible(paddedButtonRect, animated: animated)
    }
    
    
    // MARK: - Action
    @objc func pwVisible() {
        showPassword.toggle()
        
        let wasFirstResponder = pwTF.isFirstResponder
        pwTF.isSecureTextEntry = !showPassword
        
        if wasFirstResponder {
            pwTF.becomeFirstResponder()
        }
        
        let toggleIcon = showPassword ? "eye" : "eye.slash"
        pwTB.setImage(UIImage(systemName: toggleIcon), for: .normal)
        
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        
    }
    
    @objc func idChanged() {
        let current = (idTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)

         if isUserIDAvailable && current == lastCheckedUserID && !current.isEmpty {
             dupButtonVerified(dupBT)
         } else {
             resetDupButton(dupBT)
         }
        updateSignUpButton()
    }
    
    @objc func pwChanged() {
        updateSignUpButton()
    }
    
    @objc func dupTapped() {
        let userID = (idTF.text ?? "").trimmingCharacters(in:
                .whitespacesAndNewlines)
        guard !userID.isEmpty else { return }
        
        Task {
            do {
                let isDup = try await self.viewModel.checkUserIDDuplicate(userID)
                
                if isDup {
                    self.isUserIDAvailable = false
                    self.lastCheckedUserID = ""
                    self.resetDupButton(self.dupBT)
                    self.showSimpleAlert(title: "이미 사용중", message: "다른 ID(Email)을 입력해 주세요.")
                } else {
                    self.isUserIDAvailable = true
                    self.lastCheckedUserID = userID
                    self.dupButtonVerified(self.dupBT)
                    self.showSimpleAlert(title: "사용 가능", message: "사용 가능한 이메일(ID) 입니다.")
                }
                self.updateSignUpButton()
            } catch {
                print("dup check error: ", error)
                self.showSimpleAlert(title: "실패", message: "\(error)")
            }
        }
    }
    
    // MARK: - 회원가입 버튼
    private func updateSignUpButton() {
        let id = (idTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let pw = (pwTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        
        let accountValid = viewModel.isLoginEnabled(email: id, password: pw)
        
        let isDupVerified = isUserIDAvailable && lastCheckedUserID == id
        
        let enabled = accountValid && isDupVerified
        
        
        signUpBT.isEnabled = enabled
        signUpBT.alpha = enabled ? 1.0 : 0.5
    }
    
    @objc func signUpTapped() {
        let id = (idTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let pw = (pwTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard signUpBT.isEnabled else { return }
        
        Task {
            do {
                try await viewModel.signUp(email: id, password: pw)
                self.signUpAfterAlert(title: "회원가입 완료", message: "로그인 후 이용해 주세요.") {
                    self.navigationController?.popViewController(animated: true)
                }
            } catch {
                self.showSimpleAlert(title: "회원가입 실패",message: error.localizedDescription)
            }
        }
    }
}

// MARK: - Extension UITextFieldDelegate
extension SignUpVC: UITextFieldDelegate {
    
    private func keyboardSetUp() {
        idTF.delegate = self
        idTF.returnKeyType = .next
        idTF.disableSuggestions()
        
        pwTF.delegate = self
        pwTF.returnKeyType = .done
        pwTF.disableSuggestions()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idTF {
            pwTF.becomeFirstResponder()
        } else if textField == pwTF {
            view.endEditing(true)
        }
        return true
    }
    
}


private extension SignUpVC {
    
    func resetDupButton(_ button: UIButton) {
        button.isEnabled = true
        button.setTitle("중복", for: .normal)
        button.backgroundColor = .systemRed
    }
    
    func dupButtonVerified(_ button: UIButton) {
        button.isEnabled = false
        button.setTitle("확인됨", for: .normal)
        button.backgroundColor = .secondaryLabel
        button.alpha = 0.9
    }

    
}
