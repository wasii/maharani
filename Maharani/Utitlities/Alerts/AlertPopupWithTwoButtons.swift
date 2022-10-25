//
//  CongratulationPopup.swift
//  FORALL
//
//  Created by Mac User on 22/10/19.
//  Copyright © 2019 Mac User. All rights reserved.
//

import UIKit

class AlertPopupWithTwoButtons: UIView {
    
    
    @IBAction func okayButtonAction(_ sender: Any) {
        dismiss()
        if let _ = okayAction {
            okayAction!()
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss()
       
    }
    
    var okayAction: (()->())?
    
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var dialogueBoxView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var okayButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var isMultipleChoice = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tag = 999
        
        if isMultipleChoice {
            okayButton.backgroundColor = Color.green.color()
            cancelButton.backgroundColor = Color.dark.color()
        }
        
        let tapGeture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        overlayView.addGestureRecognizer(tapGeture)
        
        messageLabel.textColor = UIColor.black
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    @objc func backgroundTapped() {
       // dismiss()
    }
    
    class func instanceFromNib() -> AlertPopupWithTwoButtons {
        return UINib(nibName: "AlertPopupWithTwoButtons", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! AlertPopupWithTwoButtons
    }
    
    func show() {
        overlayView.alpha = 0
        dialogueBoxView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        if let oldAlert = keyWindow.viewWithTag(999) {
            oldAlert.removeFromSuperview()
        }
        keyWindow.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: keyWindow.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: keyWindow.bottomAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: keyWindow.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: keyWindow.rightAnchor).isActive = true
        UIView.animate(withDuration: 0.3, animations: {
            self.overlayView.alpha = 0.5
        })
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.dialogueBoxView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func dismiss() {
        self.removeFromSuperview()
    }
}
