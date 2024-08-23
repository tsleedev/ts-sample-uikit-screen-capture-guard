//
//  WebViewController.swift
//  TSScreenCaptureGuardUIKitSample
//
//  Created by TAE SU LEE on 7/11/24.
//  Copyright © 2024 https://github.com/tsleedev/. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = true
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.uiDelegate = webViewUIDelegate
        webView.secureMode = true
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
    
    deinit {
        webView.disableSecureMode()
        print("\(type(of: self)) \(#function)")
    }
}

// MARK: - Setup
private extension WebViewController {
    /// Initialize and add subviews
    func setupViews() {
        view.addSubview(webView)
        view.addSubview(toolbar)
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
    
    func webLoad() {
        let url = URL(string: "https://www.google.com")!
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

// MARK: - Actions
private extension WebViewController {
    @objc func backButtonTapped() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
