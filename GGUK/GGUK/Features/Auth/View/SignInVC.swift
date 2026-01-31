//
//  SignInVC.swift
//  GGUK
//
//  Created by VnPaz on 1/27/26.
//

import UIKit
import SnapKit
import AuthenticationServices


class SignInVC: UIViewController {
    
    // VM
    private let viewModel = SignInVM()
    
    // View Property
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        scrollView.keyboardDismissMode = .interactive
        return scrollView
    }()
    
    private let contentView = UIView()
    
    // Component Property
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "꾹 참지 말고, 꾹 누르세요"
        titleLabel.textColor = .label
        titleLabel.font = .systemFont(ofSize: 32, weight: .semibold)
        return titleLabel
    }()
    
    private let idLabel : UILabel = {
        let idLabel = UILabel()
        idLabel.text = "아이디"
        idLabel.textColor = .secondaryLabel
        idLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        return idLabel
    }()
    
    private let idView : UIView = {
        let idView = UIView()
        idView.backgroundColor = .secondarySystemBackground
        idView.layer.cornerRadius = 8
        idView.layer.borderWidth = 1
        idView.layer.borderColor = UIColor.opaqueSeparator.cgColor
        return idView
    }()
    
    private let idIcon : UIImageView = {
        let idIcon = UIImageView()
        idIcon.image = UIImage(systemName: "person")
        idIcon.tintColor = .secondaryLabel
        idIcon.contentMode = .scaleAspectFit
        return idIcon
    }()
    
    private lazy var idTF : UITextField = {
        let idTF = UITextField()
        idTF.placeholder = "example@email.com"
        idTF.font = .systemFont(ofSize: 16)
        idTF.tintColor = .systemRed
        idTF.keyboardType = .emailAddress
        idTF.addTarget(self, action: #selector(idChanged), for: .editingChanged)
        return idTF
    }()
    
    private let pwLabel : UILabel = {
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
    
    private let pwIcon : UIImageView = {
        let pwIcon = UIImageView()
        pwIcon.image = UIImage(systemName: "lock")
        pwIcon.tintColor = .secondaryLabel
        pwIcon.contentMode = .scaleAspectFit
        return pwIcon
    }()
    
    private lazy var pwTF : UITextField = {
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
    
    private lazy var pwTB : UIButton = {
        let pwTB = UIButton(type: .system)
        pwTB.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        pwTB.tintColor = .secondaryLabel
        pwTB.addTarget(self, action: #selector(pwVisible), for: .touchUpInside)
        return pwTB
    }()
    
    private lazy var loginBT: UIButton = {
        let loginBT = UIButton()
        loginBT.setTitle("로그인", for: .normal)
        loginBT.titleLabel?.font = .systemFont(ofSize: 16)
        loginBT.tintColor = .systemBackground
        loginBT.backgroundColor = .red
        loginBT.layer.cornerRadius = 8
        loginBT.isEnabled = false
        loginBT.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return loginBT
    }()
    
    private lazy var signUpBT: UIButton = {
        let signUpBT = UIButton()
        signUpBT.setTitle("회원가입", for: .normal)
        signUpBT.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        signUpBT.setTitleColor(.secondaryLabel, for: .normal)
        signUpBT.addTarget(self, action: #selector(signUpTapped), for:. touchUpInside)
        return signUpBT
    }()
    
    private lazy var appleBT: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.separator.cgColor
        button.addTarget(self, action: #selector(appleTapped), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupKeyboard()
        keyboardDismissGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(animated)
        
        idTF.text = ""
        pwTF.text = ""
        idTF.placeholder = "example@email.com"
        pwTF.placeholder = "비밀번호를 입력하세요"
        updateLoginButton()
    }
    
    
    // MARK: - UI Setting
    private func setupUI() {
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
        contentView.addSubview(signUpBT)
        contentView.addSubview(loginBT)
        contentView.addSubview(appleBT)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(1100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(120)
            make.height.equalTo(32)
        }
        
        // MARK: - ID
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(25)
            make.height.equalTo(16)
        }
        
        idView.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
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
        
        // MARK: - PW
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
        
        // MARK: - LogIn Button
        loginBT.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pwView.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        // MARK: - SignUp Button
        signUpBT.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginBT.snp.bottom).offset(60)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        
        appleBT.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signUpBT.snp.bottom).offset(30)
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        updateLoginButton()
    }
    
    // MARK: - LogInButton Option
    private func updateLoginButton() {
        let id = (idTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let pw = (pwTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        
        let enabled = viewModel.isLoginEnabled(email: id, password: pw)
        loginBT.isEnabled = enabled
        loginBT.alpha = enabled ? 1.0 : 0.5
    }
    
    // MARK: - Action
    @objc private func idChanged(_ idTF: UITextField) {
        updateLoginButton()
    }
    
    @objc private func pwChanged(_ pwTF: UITextField) {
        updateLoginButton()
    }
    
    @objc private func pwVisible() {
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
    
    @objc private func loginTapped() {
        let id = (idTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let pw = (pwTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard loginBT.isEnabled else { return }
        
        loginBT.isEnabled = false
        loginBT.alpha = 0.7
        
        Task { [weak self] in
            guard let self else { return }
            do {
                try await viewModel.signIn(email: id, password: pw)
                
                // 로그인 성공 → 루트 교체 (TabBar로)
                AppRouter.setRoot(.main, animated: true)
                
            } catch {
                //  실패 → 다시 활성화
                self.loginBT.isEnabled = true
                self.updateLoginButton()
                self.showSimpleAlert(title: "로그인", message: error.localizedDescription)
            }
        }
        
    }
    
    @objc private func signUpTapped() {
        let signUpVC = SignUpVC()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc private func appleTapped() {
        Task { [weak self] in
            guard let self else { return }
            
            do {
                try await SupabaseManager.shared.startAppleOAuth()
                let loggedIn = await SupabaseManager.shared.hasValidSession()
                if loggedIn { AppRouter.setRoot(.main, animated: true) }
            } catch {
                // 사용자가 로그인 중 취소한 경우 (에러 알림 표시하지 않음)
                let nsError = error as NSError
                if nsError.domain == ASWebAuthenticationSessionError.errorDomain,
                   nsError.code == ASWebAuthenticationSessionError.canceledLogin.rawValue {
                    return
                }
                // 그 외 오류 발생 시 에러 메시지 표시
                self.showSimpleAlert(title: "실패", message: error.localizedDescription)
                
            }
        }
    }
}


extension SignInVC: UITextFieldDelegate {
    
    private func setupKeyboard() {
        idTF.delegate = self
        idTF.returnKeyType = .next
        idTF.disableSuggestions()
        
        pwTF.delegate = self
        pwTF.returnKeyType = .done
        pwTF.disableSuggestions()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == idTF {
            idTF.placeholder = nil
        }
        
        if textField == pwTF {
            pwTF.placeholder = nil
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == idTF {
            let text = (idTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            if text.isEmpty {
                idTF.placeholder = "example@gmail.com"
                idTF.textColor = .label
            }
        }
        
        if textField == pwTF {
            let text = (pwTF.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            if text.isEmpty {
                pwTF.placeholder = "비밀번호를 입력하세요"
                pwTF.text = ""
                pwTF.isSecureTextEntry = true
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == idTF {
            pwTF.becomeFirstResponder()
            return true
        }
        
        if textField == pwTF {
            view.endEditing(true)
            // 활성하된 상태일때만 로그인 시도
            guard loginBT.isEnabled else {
                return true
            }
            loginTapped()
            return true
        }
        return true
    }
}
