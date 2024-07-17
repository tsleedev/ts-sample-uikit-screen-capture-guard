//
//  SecureWebViewController.swift
//  TSScreenCaptureGuardUIKitSample
//
//  Created by TAE SU LEE on 7/17/24.
//

import UIKit
import WebKit

/// UIView를 확장해서 구현한 secureMode 사용시 메모리 해제 어려움 및 다른 알 수 없는 버그 발생하는 경우가 다수 존재,
/// 안정성을 위해서 캡쳐가 불가능한 웹뷰컨 하나를 만들어서 복잡한 웹 화면 전환 없이 사용하면 좋을거 같아서 예시 만들어 봤습니다.

class SecureWebViewController: UIViewController {
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = true
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.uiDelegate = webViewUIDelegate
        return webView
    }()
    private lazy var toolbar: UIToolbar = {
        let backButtonImage = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))

        let toolbar = UIToolbar()
        toolbar.setItems([backButton], animated: false)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        return toolbar
    }()
    private lazy var webViewUIDelegate = WebViewUIDelegate(parentViewController: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        configureUI()
        webLoad()
    }
}

// MARK: - Setup
private extension SecureWebViewController {
    /// Initialize and add subviews
    func setupViews() {
        view.addSubview(webView)
        view.addSubview(toolbar)
        makeSecure(webView)
    }
    
    /// Set up Auto Layout constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: toolbar.topAnchor),
            
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    /// Initialize UI elements and localization
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func makeSecure(_ view: UIView) {
        DispatchQueue.main.async {
            let textField = UITextField()
            textField.isSecureTextEntry = true
            textField.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
            view.addSubview(textField)
            
            textField.layer.removeFromSuperlayer()
            if let superlayer = view.layer.superlayer {
                superlayer.addSublayer(textField.layer)
                textField.layer.sublayers?.first?.addSublayer(view.layer)
            }
            // 특정화면에서 뒤로가기시 키보드가 노출되는 상황이 있어서 추가
            textField.isUserInteractionEnabled = false
        }
    }

    func webLoad() {
        let url = URL(string: "https://www.google.com")!
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

// MARK: - Actions
private extension SecureWebViewController {
    @objc func backButtonTapped() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
