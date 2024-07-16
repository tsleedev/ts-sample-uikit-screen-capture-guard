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
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.secureMode = true
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        configureUI()
        webLoad()
    }
    
    deinit {
        webView.disableSecureMode()
    }
}

// MARK: - Setup
private extension WebViewController {
    /// Initialize and add subviews
    func setupViews() {
        view.addSubview(webView)
    }
    
    /// Set up Auto Layout constraints
    func setupConstraints() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
