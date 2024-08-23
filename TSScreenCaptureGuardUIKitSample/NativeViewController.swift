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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "캡처 금지"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("클릭 테스트", for: .normal)
        button.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        configureUI()
    }
    
    deinit {
        containerView.disableSecureMode()
        print("\(type(of: self)) \(#function)")
    }
}

// MARK: - Setup
private extension NativeViewController {
    /// Initialize and add subviews
    func setupViews() {
        view.addSubview(containerView)
        containerView.addSubview(label)
        containerView.addSubview(button)
    }
    
    /// Set up Auto Layout constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
            button.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    /// Initialize UI elements and localization
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
}

// MARK: - Actions
private extension NativeViewController {
    @objc func click(_ sender: UIButton) {
        print("\(type(of: self)) \(#function)")
    }
}
