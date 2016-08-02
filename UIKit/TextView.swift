//
//  TextView.swift
//  
//
//  Created by 黄穆斌 on 16/8/2.
//
//

import UIKit

class TextView: UITextView, UITextViewDelegate {

    weak var textViewDelegate: UITextViewDelegate?
    var transformDelegate: Bool = true
    override var delegate: UITextViewDelegate? {
        didSet {
            if transformDelegate {
                print("set Delegate")
                transformDelegate = false
                textViewDelegate = delegate
                delegate = self
            } else {
                transformDelegate = true
            }
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        deploy()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        deploy()
    }
    
    func deploy() {
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = textColor?.colorWithAlphaComponent(0.7)
        
        placeholderLabel.sizeToFit()
        placeholderLabel.frame.origin = CGPoint(x: 5, y: 6)
        addSubview(placeholderLabel)
    }
    
    // MARK: - Plance Holder
    
    /// 占位文本
    private var placeholderLabel: UILabel = UILabel()
    
    /// 占位符
    @IBInspectable var placeholder: String? = "" {
        didSet {
            placeholderLabel.text = placeholder
            placeholderLabel.sizeToFit()
        }
    }
    // MARK: - UITextViewDelegate
    
//    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
//        return textViewDelegate?.textViewShouldBeginEditing?(textView) ?? true
//    }
//    
//    func textViewShouldEndEditing(textView: UITextView) -> Bool {
//        
//    }
//    
//    func textViewDidBeginEditing(textView: UITextView) {
//        
//    }
//    
//    func textViewDidEndEditing(textView: UITextView) {
//        
//    }
//    
//    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
//        
//    }
//    
    func textViewDidChange(textView: UITextView) {
        textViewDelegate?.textViewDidChange?(textView)
        
    }
//
//    func textViewDidChangeSelection(textView: UITextView) {
//        
//    }
//    
//    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
//        
//    }
//    
//    func textView(textView: UITextView, shouldInteractWithTextAttachment textAttachment: NSTextAttachment, inRange characterRange: NSRange) -> Bool {
//        
//    }

}
