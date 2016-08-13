//
//  SpeakView.swift
//  SwiftiOS
//
//  Created by 黄穆斌 on 16/8/13.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit

/**
 必须加入 AutoLayout.swift
 */
// MARK: - Enum

enum SpeakViewType {
    case Simple
    case Button(String?)
    case Image(UIImage?)
}

// MARK: - Delegate

@objc protocol SpeakViewDelegate: NSObjectProtocol {
    func speakViewTextFieldEnd(text: String)
    optional func speakViewSuperViewTap()
}


class SpeakView: UIView, UITextFieldDelegate {

    // MARK: - Views
    
    /// 输入框
    let textField: UITextField = UITextField()
    /// 触发按钮
    var showButton: UIButton = UIButton()
    
    // MARK: - layouts
    
    /// 底部距离父视图高度
    var bottomSpace: CGFloat = 0
    
    /// 输入框高度
    var textFieldHeightLayout: NSLayoutConstraint!
    /// 相对父视图的高度
    var bottomLayout: NSLayoutConstraint?
    
    // MARK: - Values
    
    /// 回调代理
    weak var delegate: SpeakViewDelegate?
    /// 类型
    var type: SpeakViewType = SpeakViewType.Simple
    
    // MARK: - Methods
    
    /// 将 view 设置为自己的父视图并自动添加约束，并给 superView 新增一个 tap 事件。space > 0 等于提高高度
    func autoLayoutToSuperView(view: UIView, space: CGFloat = 0) {
        view.addSubview(self)
        bottomLayout = AutoLayout(view, self).LeadingTrailing().Height(self, 40).clearConstrants().Bottom(-space)._constrants[0]
        bottomSpace = -space
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Init
    
    init(type: SpeakViewType = SpeakViewType.Simple) {
        super.init(frame: CGRectZero)
        self.type = type
        load()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
    }

    private func load() {
        self.backgroundColor = UIColor.darkGrayColor()
        
        //
        textField.borderStyle = .RoundedRect
        textField.delegate = self
        textFieldHeightLayout = AutoLayout(self, textField).Height(textField, 30)._constrants[0]
        
        //
        showButton.addTarget(self, action: #selector(showAction), forControlEvents: .TouchUpInside)
        showButton.addTarget(self, action: #selector(showButtonTouchDown), forControlEvents: .TouchDown)
        showButton.addTarget(self, action: #selector(showButtonTouchUp), forControlEvents: .TouchUpOutside)
        
        showButton.backgroundColor = self.backgroundColor
        
        //
        deploy()
        addKeyboard()
    }
    
    deinit {
        removeKeyboard()
    }
    
    // MARK: - Deploy
    
    /// 重新配置 AutoLayout
    func deploy() {
        textField.removeFromSuperview()
        showButton.removeFromSuperview()
        
        switch type {
        case .Simple:
            addSubview(textField)
            AutoLayout(self, textField).Center().Leading(10)
        case .Button(let text):
            if text != nil {
                showButton.setTitle(text, forState: .Normal)
                showButton.setImage(nil, forState: .Normal)
            }
            addSubview(textField)
            addSubview(showButton)
            AutoLayout(self, textField).Center().Leading(10)
            AutoLayout(self, showButton).Center().Size()
        case .Image(let image):
            if image != nil {
                showButton.setTitle(nil, forState: .Normal)
                showButton.setImage(image, forState: .Normal)
            }
            addSubview(textField)
            addSubview(showButton)
            AutoLayout(self, textField).Center().Leading(10)
            AutoLayout(self, showButton).Center().Size()
        }
    }
    
    // MARK: - Views Actions
    
    // MARK: SuperView
    
    func tapAction() {
        if let layout = bottomLayout {
            if bottomSpace != layout.constant {
                self.textField.resignFirstResponder()
                showButton.hidden = false
            }
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch type {
        case .Simple:
            textField.resignFirstResponder()
        case .Button(_), .Image(_):
            textField.resignFirstResponder()
            showButton.hidden = false
        }
        if textField.text?.isEmpty == false {
            delegate?.speakViewTextFieldEnd(textField.text!)
            textField.text = nil
        }
        return true
    }
    
    // MARK: Show Button
    
    func showAction() {
        self.showButton.hidden = true
        self.alpha = 1
        self.textField.becomeFirstResponder()
    }
    
    func showButtonTouchDown() {
        UIView.animateWithDuration(0.2) { 
            self.alpha = 0.7
        }
    }
    
    func showButtonTouchUp() {
        UIView.animateWithDuration(0.2) { 
            self.alpha = 1
        }
    }
    
    // MARK: - KeyBoard
    
    func addKeyboard() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillChange), name: UIKeyboardWillChangeFrameNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboard() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notify: NSNotification) {
        if let time = notify.userInfo![UIKeyboardAnimationDurationUserInfoKey] as? NSNumber, let rect = notify.userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue {
            UIView.animateWithDuration(time.doubleValue) {
                self.bottomLayout?.constant = -(UIScreen.mainScreen().bounds.height - rect.CGRectValue().origin.y)
                self.superview?.layoutIfNeeded()
            }
        }
    }
    func keyboardWillChange(notify: NSNotification) {
        if let time = notify.userInfo![UIKeyboardAnimationDurationUserInfoKey] as? NSNumber, let rect = notify.userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue {
            UIView.animateWithDuration(time.doubleValue) {
                self.bottomLayout?.constant = -(UIScreen.mainScreen().bounds.height - rect.CGRectValue().origin.y)
                self.superview?.layoutIfNeeded()
            }
        }
    }
    func keyboardWillHide(notify: NSNotification) {
        if let time = notify.userInfo![UIKeyboardAnimationDurationUserInfoKey] as? NSNumber {
            UIView.animateWithDuration(time.doubleValue) {
                self.bottomLayout?.constant = self.bottomSpace
                self.superview?.layoutIfNeeded()
            }
        }
    }
}
