//
//  ListViewController.swift
//  testing
//
//  Created by Weixin Kong on 2021-03-18.
//

import UIKit

class ModifyViewController: UIViewController , UITextFieldDelegate{
	let nameTxtBox = UITextField()
	let passwordTxtBox = UITextField()
	//let FPBtn = UIButton()
	let confirmBtn = UIButton()
	let cancelBtn = UIButton()
	let ViewLabel = UILabel()
	let FPCB = CircularCheckbox()
	let FPCBLabel = UILabel()
	var checkBoxStatus = false
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = .white
		
		let titleRect:CGRect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 150)
		let titleBackgroundView = UIView(frame: titleRect)
		titleBackgroundView.backgroundColor = backgroundColor
		self.view.addSubview(titleBackgroundView)
		
		ViewLabel.text = "Modify User"
		ViewLabel.textColor = textColor
		ViewLabel.font = UIFont(name: "GillSans-UltraBold", size: 27)
		ViewLabel.frame = CGRect(x: 0, y: 0, width: 250, height: 100)
		ViewLabel.center.x = titleBackgroundView.center.x - 50
		ViewLabel.center.y = titleBackgroundView.center.y
		self.view.addSubview(ViewLabel)
		
		nameTxtBox.placeholder = "Enter new name"
		nameTxtBox.backgroundColor = .white
		nameTxtBox.textColor = backgroundColor
		nameTxtBox.frame = CGRect(x: (self.view.center.x - 140), y: titleBackgroundView.frame.origin.y + titleBackgroundView.frame.height + 30, width: 280, height: 60)
		nameTxtBox.useUnderline(color: false)
		nameTxtBox.autocorrectionType = UITextAutocorrectionType.no
		nameTxtBox.textContentType = UITextContentType.oneTimeCode
		nameTxtBox.keyboardType = UIKeyboardType.alphabet
		//nameTxtBox.delegate = self
		view.addSubview(nameTxtBox)
		
		passwordTxtBox.placeholder = "Enter new password"
		passwordTxtBox.backgroundColor = .white
		passwordTxtBox.textColor = backgroundColor
		passwordTxtBox.frame = CGRect(x: (self.view.center.x - 140), y:nameTxtBox.frame.origin.y + nameTxtBox.frame.height + 30, width: 280, height: 60)
		passwordTxtBox.useUnderline(color: false)
		passwordTxtBox.autocorrectionType = UITextAutocorrectionType.no
		passwordTxtBox.keyboardType = UIKeyboardType.alphabet
		passwordTxtBox.textContentType = UITextContentType.oneTimeCode
		passwordTxtBox.isSecureTextEntry = true
		passwordTxtBox.delegate = self
		view.addSubview(passwordTxtBox)
		/*
		FPBtn.setTitle("Change Finger Print", for: .normal)
		FPBtn.setTitleColor(textColor, for: .normal)
		FPBtn.startAnimatingPressActions()
		FPBtn.backgroundColor = UIColor(red: 0.31960784, green: 0.31372549, blue: 0.380392157, alpha: 1)
		FPBtn.layer.cornerRadius = 25
		FPBtn.frame = CGRect(x: (self.view.center.x - 140), y: (passwordTxtBox.frame.origin.y + passwordTxtBox.frame.height + 50), width: 280, height: 50)
		FPBtn.layer.shadowColor = UIColor.black.cgColor
		FPBtn.layer.shadowOffset = CGSize(width: 1.0, height: 6.0)
		FPBtn.layer.shadowRadius = 3
		FPBtn.layer.shadowOpacity = 0.5
		view.addSubview(FPBtn)
		*/
		
		FPCBLabel.text = "Finger Print"
		FPCBLabel.textColor = backgroundColor
		FPCBLabel.frame = CGRect(x: (self.view.center.x - 100), y: (passwordTxtBox.frame.origin.y + passwordTxtBox.frame.height + 50), width: 100, height: 30)
		self.view.addSubview(FPCBLabel)
		
		FPCB.frame = CGRect(x: (self.view.center.x - 140), y: (passwordTxtBox.frame.origin.y + passwordTxtBox.frame.height + 50), width: 30, height: 30)
		let gesture = UITapGestureRecognizer(target: self, action: #selector(TapCheckedbox))
		FPCB.addGestureRecognizer(gesture)
		view.addSubview(FPCB)
		
		confirmBtn.setTitle("Confirm", for: .normal)
		confirmBtn.setTitleColor(textColor, for: .normal)
		confirmBtn.startAnimatingPressActions()
		confirmBtn.backgroundColor = UIColor(red: 0.31960784, green: 0.31372549, blue: 0.380392157, alpha: 1)
		confirmBtn.layer.cornerRadius = 25
		confirmBtn.frame = CGRect(x: (self.view.center.x / 2 - 50 ), y: (FPCB.frame.origin.y + FPCB.frame.height + 50), width: 100, height: 50)
		confirmBtn.layer.shadowColor = UIColor.black.cgColor
		confirmBtn.layer.shadowOffset = CGSize(width: 1.0, height: 6.0)
		confirmBtn.layer.shadowRadius = 3
		confirmBtn.layer.shadowOpacity = 0.5
		confirmBtn.addTarget(self, action: #selector(confirmPressed), for: .touchUpInside)
		view.addSubview(confirmBtn)
		
		cancelBtn.setTitle("Cancel", for: .normal)
		cancelBtn.setTitleColor(textColor, for: .normal)
		cancelBtn.startAnimatingPressActions()
		cancelBtn.backgroundColor = UIColor(red: 0.31960784, green: 0.31372549, blue: 0.380392157, alpha: 1)
		cancelBtn.layer.cornerRadius = 25
		cancelBtn.frame = CGRect(x: (self.view.center.x / 2 + 130 ), y: (FPCB.frame.origin.y + FPCB.frame.height + 50), width: 100, height: 50)
		cancelBtn.layer.shadowColor = UIColor.black.cgColor
		cancelBtn.layer.shadowOffset = CGSize(width: 1.0, height: 6.0)
		cancelBtn.layer.shadowRadius = 3
		cancelBtn.layer.shadowOpacity = 0.5
		view.addSubview(cancelBtn)
    }
	
	@objc func TapCheckedbox(){
		checkBoxStatus = !checkBoxStatus
		FPCB.setChecked(checkBoxStatus)
	}
	
	@objc func confirmPressed(){
		var opStr = "modify/"+loginName+"/"
		if nameTxtBox.text! != "" {
			opStr = opStr+nameTxtBox.text!+"/"
		}else{
			opStr = opStr + "*/"
		}
		if passwordTxtBox.text! != ""{
			opStr = opStr + passwordTxtBox.text! + "/"
		}else{
			opStr = opStr + "*/"
		}
		if checkBoxStatus{
			opStr = opStr + "t/"
		}else{
			opStr = opStr + "*/"
		}
		mqttClient.publish(Msg: opStr)
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let currentText = textField.text ?? ""
		guard let stringRange = Range(range, in:currentText) else {
			return false
		}
		let updateText = currentText.replacingCharacters(in: stringRange, with: string)
		
		return updateText.count < 5
	}
}

class AddViewController: UIViewController, UITextFieldDelegate{
	let nameTxtBox = UITextField()
	let passwordTxtBox = UITextField()
	let confirmBtn = UIButton()
	let cancelBtn = UIButton()
	let ViewLabel = UILabel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .white
		
		let titleRect:CGRect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 150)
		let titleBackgroundView = UIView(frame: titleRect)
		titleBackgroundView.backgroundColor = backgroundColor
		self.view.addSubview(titleBackgroundView)
		
		ViewLabel.text = "Add User"
		ViewLabel.textColor = textColor
		ViewLabel.font = UIFont(name: "GillSans-UltraBold", size: 27)
		ViewLabel.frame = CGRect(x: 0, y: 0, width: 250, height: 100)
		ViewLabel.center.x = titleBackgroundView.center.x - 50
		ViewLabel.center.y = titleBackgroundView.center.y
		self.view.addSubview(ViewLabel)
		
		nameTxtBox.placeholder = "Enter new name"
		nameTxtBox.backgroundColor = .white
		nameTxtBox.textColor = backgroundColor
		nameTxtBox.frame = CGRect(x: (self.view.center.x - 140), y: titleBackgroundView.frame.origin.y + titleBackgroundView.frame.height + 30, width: 280, height: 60)
		nameTxtBox.useUnderline(color: false)
		nameTxtBox.autocorrectionType = UITextAutocorrectionType.no
		nameTxtBox.textContentType = UITextContentType.oneTimeCode
		nameTxtBox.keyboardType = UIKeyboardType.alphabet
		//nameTxtBox.delegate = self
		view.addSubview(nameTxtBox)
		
		passwordTxtBox.placeholder = "Enter new password"
		passwordTxtBox.backgroundColor = .white
		passwordTxtBox.textColor = backgroundColor
		passwordTxtBox.frame = CGRect(x: (self.view.center.x - 140), y:nameTxtBox.frame.origin.y + nameTxtBox.frame.height + 30, width: 280, height: 60)
		passwordTxtBox.useUnderline(color: false)
		passwordTxtBox.autocorrectionType = UITextAutocorrectionType.no
		passwordTxtBox.keyboardType = UIKeyboardType.alphabet
		passwordTxtBox.textContentType = UITextContentType.oneTimeCode
		passwordTxtBox.isSecureTextEntry = true
		passwordTxtBox.delegate = self
		view.addSubview(passwordTxtBox)
		
		confirmBtn.setTitle("Confirm", for: .normal)
		confirmBtn.setTitleColor(textColor, for: .normal)
		confirmBtn.startAnimatingPressActions()
		confirmBtn.backgroundColor = UIColor(red: 0.31960784, green: 0.31372549, blue: 0.380392157, alpha: 1)
		confirmBtn.layer.cornerRadius = 25
		confirmBtn.frame = CGRect(x: (self.view.center.x / 2 - 50 ), y: (nameTxtBox.frame.origin.y + nameTxtBox.frame.height + 150), width: 100, height: 50)
		confirmBtn.layer.shadowColor = UIColor.black.cgColor
		confirmBtn.layer.shadowOffset = CGSize(width: 1.0, height: 6.0)
		confirmBtn.layer.shadowRadius = 3
		confirmBtn.layer.shadowOpacity = 0.5
		confirmBtn.addTarget(self, action: #selector(confirmPressed), for: .touchUpInside)
		view.addSubview(confirmBtn)
		
		cancelBtn.setTitle("Cancel", for: .normal)
		cancelBtn.setTitleColor(textColor, for: .normal)
		cancelBtn.startAnimatingPressActions()
		cancelBtn.backgroundColor = UIColor(red: 0.31960784, green: 0.31372549, blue: 0.380392157, alpha: 1)
		cancelBtn.layer.cornerRadius = 25
		cancelBtn.frame = CGRect(x: (self.view.center.x / 2 + 130 ), y: (nameTxtBox.frame.origin.y + nameTxtBox.frame.height + 150), width: 100, height: 50)
		cancelBtn.layer.shadowColor = UIColor.black.cgColor
		cancelBtn.layer.shadowOffset = CGSize(width: 1.0, height: 6.0)
		cancelBtn.layer.shadowRadius = 3
		cancelBtn.layer.shadowOpacity = 0.5
		view.addSubview(cancelBtn)
	}
	
	@objc func confirmPressed(){
		var opStr = "add/"+loginName+"/"
		if nameTxtBox.text! != "" {
			opStr = opStr+nameTxtBox.text!+"/"
		}else{
			opStr = opStr + "*/"
		}
		if passwordTxtBox.text! != ""{
			opStr = opStr + passwordTxtBox.text! + "/"
		}else{
			opStr = opStr + "*/"
		}
		mqttClient.publish(Msg: opStr)
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let currentText = textField.text ?? ""
		guard let stringRange = Range(range, in:currentText) else {
			return false
		}
		let updateText = currentText.replacingCharacters(in: stringRange, with: string)
		
		return updateText.count < 5
	}
}

class DeleteViewController: UIViewController, UITextFieldDelegate {
	let nameSearchBox = UITextField()
	let confirmBtn = UIButton()
	let cancelBtn = UIButton()
	let ViewLabel = UILabel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .white
		
		let titleRect:CGRect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 150)
		let titleBackgroundView = UIView(frame: titleRect)
		titleBackgroundView.backgroundColor = backgroundColor
		self.view.addSubview(titleBackgroundView)
		
		ViewLabel.text = "Delete User"
		ViewLabel.textColor = textColor
		ViewLabel.font = UIFont(name: "GillSans-UltraBold", size: 27)
		ViewLabel.frame = CGRect(x: 0, y: 0, width: 250, height: 100)
		ViewLabel.center.x = titleBackgroundView.center.x - 50
		ViewLabel.center.y = titleBackgroundView.center.y
		self.view.addSubview(ViewLabel)
		
		nameSearchBox.placeholder = "Enter your name"
		nameSearchBox.backgroundColor = .white
		nameSearchBox.textColor = backgroundColor
		nameSearchBox.frame = CGRect(x: (self.view.center.x - 140), y: ((self.view.frame.height)*0.382) + 60, width: 280, height: 60)
		nameSearchBox.useUnderline(color: false)
		nameSearchBox.autocorrectionType = UITextAutocorrectionType.no
		nameSearchBox.textContentType = UITextContentType.oneTimeCode
		nameSearchBox.keyboardType = UIKeyboardType.alphabet
		nameSearchBox.delegate = self
		view.addSubview(nameSearchBox)
		
		confirmBtn.setTitle("Confirm", for: .normal)
		confirmBtn.setTitleColor(textColor, for: .normal)
		confirmBtn.startAnimatingPressActions()
		confirmBtn.backgroundColor = UIColor(red: 0.31960784, green: 0.31372549, blue: 0.380392157, alpha: 1)
		confirmBtn.layer.cornerRadius = 25
		confirmBtn.frame = CGRect(x: (self.view.center.x / 2 - 50 ), y: (nameSearchBox.frame.origin.y + nameSearchBox.frame.height + 50), width: 100, height: 50)
		confirmBtn.layer.shadowColor = UIColor.black.cgColor
		confirmBtn.layer.shadowOffset = CGSize(width: 1.0, height: 6.0)
		confirmBtn.layer.shadowRadius = 3
		confirmBtn.layer.shadowOpacity = 0.5
		confirmBtn.addTarget(self, action: #selector(confirmPressed), for: .touchUpInside)

		view.addSubview(confirmBtn)
		
		cancelBtn.setTitle("Cancel", for: .normal)
		cancelBtn.setTitleColor(textColor, for: .normal)
		cancelBtn.startAnimatingPressActions()
		cancelBtn.backgroundColor = UIColor(red: 0.31960784, green: 0.31372549, blue: 0.380392157, alpha: 1)
		cancelBtn.layer.cornerRadius = 25
		cancelBtn.frame = CGRect(x: (self.view.center.x / 2 + 130 ), y: (nameSearchBox.frame.origin.y + nameSearchBox.frame.height + 50), width: 100, height: 50)
		cancelBtn.layer.shadowColor = UIColor.black.cgColor
		cancelBtn.layer.shadowOffset = CGSize(width: 1.0, height: 6.0)
		cancelBtn.layer.shadowRadius = 3
		cancelBtn.layer.shadowOpacity = 0.5
		view.addSubview(cancelBtn)
	}
	
	@objc func confirmPressed(){
		var opStr = "add/"+loginName+"/"
		if nameSearchBox.text! != "" {
			opStr = opStr+nameSearchBox.text!+"/"
		}else{
			opStr = opStr + "*/"
		}
		mqttClient.publish(Msg: opStr)
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}
