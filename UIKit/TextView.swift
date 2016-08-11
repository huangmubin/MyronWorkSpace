//
//  TextView.swift
//  
//
//  Created by 黄穆斌 on 16/8/2.
//
//

import UIKit

class TextView: UITextView, UITextViewDelegate {
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
        delegate = self
        
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = placeColor
        placeholderLabel.sizeToFit()
        placeholderLabel.frame.origin = CGPoint(x: 5, y: 8)
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
    
    @IBInspectable var placeColor: UIColor = UIColor.grayColor() {
        didSet {
            placeholderLabel.textColor = placeColor
        }
    }
    
    override var font: UIFont? {
        didSet {
            placeholderLabel.font = font
        }
    }
    
    // MARK: - UITextViewDelegate
    
    // MARK: Delegate
    
    weak var textViewDelegate: UITextViewDelegate?
    
    private var transformDelegate: Bool = true
    
    override var delegate: UITextViewDelegate? {
        didSet {
            guard self.superview != nil else { return }
            if transformDelegate && delegate !== self {
                transformDelegate = false
                textViewDelegate = delegate
                delegate = self
            } else {
                transformDelegate = true
            }
        }
    }
    
    func textViewDidChange(textView: UITextView) {
        placeholderLabel.hidden = (text.isEmpty == false)
        textViewDelegate?.textViewDidChange?(textView)
    }
    
    /*
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        return textViewDelegate?.textViewShouldBeginEditing?(textView) ?? true
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        return textViewDelegate?.textViewShouldEndEditing?(textView) ?? true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        textViewDelegate?.textViewDidBeginEditing?(textView)
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        textViewDelegate?.textViewDidEndEditing?(textView)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        return textViewDelegate?.textView?(textView, shouldChangeTextInRange: range, replacementText: text) ?? true
    }
    
    func textViewDidChangeSelection(textView: UITextView) {
        textViewDelegate?.textViewDidChangeSelection?(textView)
    }
    
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        return textViewDelegate?.textView?(textView, shouldInteractWithURL: URL, inRange: characterRange) ?? true
    }
    
    func textView(textView: UITextView, shouldInteractWithTextAttachment textAttachment: NSTextAttachment, inRange characterRange: NSRange) -> Bool {
        return textViewDelegate?.textView?(textView, shouldInteractWithTextAttachment: textAttachment, inRange: characterRange) ?? true
    }
    */

}
