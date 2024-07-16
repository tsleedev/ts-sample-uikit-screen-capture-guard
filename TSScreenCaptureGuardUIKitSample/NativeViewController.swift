//
//  NativeViewController.swift
//  TSScreenCaptureGuardUIKitSample
//
//  Created by TAE SU LEE on 7/11/24.
//  Copyright © 2024 https://github.com/tsleedev/. All rights reserved.
//

import UIKit

class NativeViewController: UIViewController {
    private let containerView: UIView = {
        let view = UIView()
        view.secureMode = true
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "캡처 금지"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        configureUI()
    }
    
    deinit {
        containerView.disableSecureMode()
    }
}

// MARK: - Setup
private extension NativeViewController {
    /// Initialize and add subviews
    func setupViews() {
        view.addSubview(containerView)
        containerView.addSubview(label)
    }
    
    /// Set up Auto Layout constraints
    func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    /// Initialize UI elements and localization
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
}
