//
//  UIView+Remind.swift
//  Remind
//
//  Created by LC on 2023/9/18.
//

import UIKit

private var UIViewNoticeHudViewKey = "UIViewNoticeHudViewKey"

extension UIView {
    public var rmd: RemindWrapper {
        get { RemindWrapper(self) }
        set {}
    }
}

public struct RemindWrapper {
    let base: UIView
    init(_ base: UIView) {
        self.base = base
    }
    
    private var remindHudView: UIView? {
        get { objc_getAssociatedObject(base, &UIViewNoticeHudViewKey) as? UIView }
        set { objc_setAssociatedObject(base, &UIViewNoticeHudViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    public mutating func show(_ text: String, stay time: TimeInterval = 0){
        dismiss()
        remindHudView = RemindManager.show(text: text, stay: time, in: self.base)
    }

    public mutating func showSuccess(_ text: String, stay time: TimeInterval = 0) {
        dismiss()
        remindHudView = RemindManager.show(type: .success, text: text, stay: time, in: self.base)
    }
    
    public mutating func showError(_ text: String, stay time: TimeInterval = 0){
        dismiss()
        remindHudView = RemindManager.show(type: .error, text: text, stay: time, in: self.base)
    }
    
    public mutating func showInfo(_ text: String, stay time: TimeInterval = 0) {
        dismiss()
        remindHudView = RemindManager.show(type: .info, text: text, stay: time, in: self.base)
    }
    
    public mutating func showWaiting(_ text: String? = nil){
        dismiss()
        remindHudView = RemindManager.wait(text: text, in: self.base)
    }
    
    public mutating func dismiss() {
        remindHudView?.removeFromSuperview()
        remindHudView = nil
    }
    
}
