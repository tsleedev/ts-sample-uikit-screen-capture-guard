//
//  UIView+Secure.swift
//  TSScreenCaptureGuardUIKitSample
//
//  Created by TAE SU LEE on 7/11/24.
//  Copyright © 2024 https://github.com/tsleedev/. All rights reserved.
//

import UIKit

private var AssociatedObjectHandle: UInt8 = 0

extension UIView {
    private var secureTextField: UITextField {
        if let textField = objc_getAssociatedObject(self, &AssociatedObjectHandle) as? UITextField {
            return textField
        } else {
            let textField = UITextField()
            setupSecureTextField(textField)
            objc_setAssociatedObject(self, &AssociatedObjectHandle, textField, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return textField
        }
    }
    
    private func setupSecureTextField(_ textField: UITextField) {
        DispatchQueue.main.async {
            // 텍스트 필드를 추가하고 프레임을 설정합니다.
            textField.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
            self.addSubview(textField)
            
            // 텍스트 필드의 레이어를 제거하여 참조 사이클을 방지합니다.
            textField.layer.removeFromSuperlayer()
            
            if let superlayer = self.layer.superlayer {
                // 현재 뷰의 슈퍼 레이어에 텍스트 필드의 레이어를 추가합니다.
                superlayer.addSublayer(textField.layer)
                // 텍스트 필드의 첫 번째 서브 레이어에 현재 뷰의 레이어를 추가하여,
                // 텍스트 필드가 보안 텍스트로 표시될 때 해당 뷰의 콘텐츠도 스크린샷에서 숨겨지게 합니다.
                textField.layer.sublayers?.first?.addSublayer(self.layer)
            }
        }
    }
    
    var secureMode: Bool {
        get {
            return secureTextField.isSecureTextEntry
        }
        set {
            secureTextField.isSecureTextEntry = newValue
        }
    }
    
    // deinit시 호출해서 메모리에서 해제합니다.
    func disableSecureMode() {
        if let textField = objc_getAssociatedObject(self, &AssociatedObjectHandle) as? UITextField {
            textField.removeFromSuperview()
            objc_setAssociatedObject(self, &AssociatedObjectHandle, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
