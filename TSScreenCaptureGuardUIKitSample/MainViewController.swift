//
//  MainViewController.swift
//  TSScreenCaptureGuardUIKitSample
//
//  Created by TAE SU LEE on 7/11/24.
//  Copyright © 2024 https://github.com/tsleedev/. All rights reserved.
//

import UIKit

private struct Item {
    let id: String
    let title: String
}

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - Views
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.secureMode = true
        return tableView
    }()
    
    // MARK: - Properties
    private let items: [Item] = [
        .init(id: "1", title: "네이티브"),
        .init(id: "2", title: "웹뷰"),
        .init(id: "3", title: "웹뷰(스크린 방지 코드 자체 포함)")
    ]
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "캡처 방지 예시"
        
        setupViews()
        setupConstraints()
        configureUI()
    }
    
    deinit {
        tableView.disableSecureMode()
    }
}

// MARK: - Setup
private extension MainViewController {
    /// Initialize and add subviews
    func setupViews() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    /// Set up Auto Layout constraints
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    /// Initialize UI elements and localization
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
}

// MARK: - UITableViewDataSource
extension MainViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedItem = items[indexPath.row]
        if selectedItem.id == "1" {
            let viewController = NativeViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        } else if selectedItem.id == "2" {
            let viewController = WebViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        } else if selectedItem.id == "3" {
            let viewController = SecureWebViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
