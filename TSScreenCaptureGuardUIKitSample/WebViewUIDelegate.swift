//
//  WebViewUIDelegate.swift
//  TSScreenCaptureGuardUIKitSample
//
//  Created by TAE SU LEE on 7/17/24.
//  Copyright © 2024 https://github.com/tsleedev/. All rights reserved.
//

import UIKit
import WebKit

// MARK: - WKUIDelegate
class WebViewUIDelegate: NSObject, WKUIDelegate {
    let parentViewController: UIViewController
    
    init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler()
        }
        alert.addAction(confirmAction)
        parentViewController.present(alert, animated: true)
    }
}
