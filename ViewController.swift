//
//  ViewController.swift
//  testing
//
//  Created by Weixin Kong on 2021-02-03.
//

import UIKit
import CocoaMQTT

let backgroundColor = UIColor(red: 0.22352941, green: 0.24313725, blue: 0.2745098, alpha: 1.00)
let textColor = UIColor(red: 0.84, green: 0.85, blue: 0.85, alpha: 1.00)
var mqttClient = MQTTManager()
var loginName = String()
class ViewController: UIViewController {
	
	let connectBtn = UIButton()
	let logoImg = UIImageView()
	let authorLabel = UILabel()

	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = backgroundColor
		
		//button
		connectBtn.setTitle("Connect to Lock", for: .normal)
		connectBtn.backgroundColor = textColor
		connectBtn.startAnimatingPressActions()
		connectBtn.setTitleColor(backgroundColor, for: .normal)
		connectBtn.layer.cornerRadius = 10
		connectBtn.frame = CGRect(x: 0, y: 0, width: 300, height: 52)
		connectBtn.center.x = self.view.center.x
		connectBtn.center.y = (self.view.center.y)*1.5
		connectBtn.addTarget(self, action: #selector(connectBtnPressed), for: .touchUpInside)
		view.addSubview(connectBtn)
		
		//image
		logoImg.image = UIImage(named: "Logo")
		logoImg.contentMode = .scaleToFill
		logoImg.frame = CGRect(x: 0, y: 0, width: 260, height: 260)
		logoImg.center.x = self.view.center.x
		logoImg.center.y = (self.view.center.y)/1.5
		view.addSubview(logoImg)
		
		//label
		authorLabel.text = "Created By: Weixin Kong\n                           Jamsel Bualat"
		authorLabel.textColor = textColor
		authorLabel.numberOfLines = 2
		authorLabel.textAlignment = .center
		authorLabel.frame = CGRect(x: 0, y: 0, width: 250, height: 100)
		authorLabel.center.x = self.view.center.x
		authorLabel.center.y = (self.view.center.y)*1.8
		view.addSubview(authorLabel)
		
	}
	
	@objc private func connectBtnPressed (){
		//if buildConnection() {
		if true { //Testing Use
			connectionSucceeded()
		}
		else{
			//connectionFailed()
		}
	}
	
	private func buildConnection() -> Bool{
		let mqttClient = CocoaMQTT(clientID: "iPhone", host: "192.168.50.128", port: 1883)
		let connectionFlag = mqttClient.connect()
		return connectionFlag
	}
	
	private func connectionFailed (){
		let alert = UIAlertController(title: "Error", message: "Fail to connect to the lock, Please make sure the device is in the same network and Try Again", preferredStyle: UIAlertController.Style.alert)
		alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
	
	private func connectionSucceeded (){
		let loginVC = LoginViewController()
		loginVC.modalPresentationStyle = .fullScreen
		present(loginVC, animated: true)
	}
	
}
// MARK: LoginViewController
class LoginViewController: UIViewController , UITextFieldDelegate{
	
	let loginImg = UIImageView()
	let nameTxtBox = UITextField()
	let passwordTxtBox = UITextField()
	let loginBtn = UIButton()
	let registerBtn = UIButton()
	let nameWarningLabel = UILabel()
	let passwordWarningLabel = UILabel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .white
		title = "Login"
		
		//loginImg
		loginImg.image = UIImage(named: "Logo150")
		loginImg.contentMode = .scaleAspectFit
		loginImg.backgroundColor = backgroundColor
		loginImg.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: (self.view.frame.height)*0.382)
		view.addSubview(loginImg)
		
		//nameTxtBox
		nameTxtBox.placeholder = "Enter your name"
		nameTxtBox.backgroundColor = .white
		nameTxtBox.textColor = backgroundColor
		nameTxtBox.frame = CGRect(x: (self.view.center.x - 140), y: ((self.view.frame.height)*0.382) + 60, width: 280, height: 60)
		nameTxtBox.useUnderline(color: false)
		nameTxtBox.autocorrectionType = UITextAutocorrectionType.no
		nameTxtBox.textContentType = UITextContentType.oneTimeCode
		nameTxtBox.keyboardType = UIKeyboardType.alphabet
		//nameTxtBox.delegate = self
		view.addSubview(nameTxtBox)
		
		//passwordTxtBox
		passwordTxtBox.placeholder = "Enter your password"
		passwordTxtBox.backgroundColor = .white
		passwordTxtBox.textColor = backgroundColor
		passwordTxtBox.frame = CGRect(x: (self.view.center.x - 140), y: ((self.view.frame.height)*0.382) + 140, width: 280, height: 60)
		passwordTxtBox.useUnderline(color: false)
		passwordTxtBox.autocorrectionType = UITextAutocorrectionType.no
		passwordTxtBox.keyboardType = UIKeyboardType.alphabet
		passwordTxtBox.textContentType = UITextContentType.oneTimeCode
		passwordTxtBox.isSecureTextEntry = true
		passwordTxtBox.delegate = self
		view.addSubview(passwordTxtBox)
		
		// MARK: ADD arrow
		loginBtn.setTitle("Login", for: .normal)
		//loginBtn.setImage(UIImage(named: "arrow"), for: .normal)
		
		//loginBtn.setBackgroundImage(UIImage(named:"LoginBtnBackground"), for: .normal)
		//loginBtn.clipsToBounds = true
		loginBtn.startAnimatingPressActions()
		loginBtn.backgroundColor = UIColor(red: 0.31960784, green: 0.31372549, blue: 0.380392157, alpha: 1)
		loginBtn.setTitleColor(textColor, for: .normal)
		loginBtn.layer.cornerRadius = 25
		loginBtn.frame = CGRect(x: (self.view.center.x - 140), y: ((self.view.frame.height)*0.382) + 140 + 120, width: 280, height: 50)
		loginBtn.addTarget(self, action: #selector(loginBtnPressed), for: .touchUpInside)
		loginBtn.layer.shadowColor = UIColor.black.cgColor
		loginBtn.layer.shadowOffset = CGSize(width: 1.0, height: 6.0)
		loginBtn.layer.shadowRadius = 8
		loginBtn.layer.shadowOpacity = 0.5
		view.addSubview(loginBtn)
		
		//registerBtn
		registerBtn.setTitle("Sign Up", for: .normal)
		registerBtn.setTitleColor(.systemGray2, for: .normal)
		registerBtn.frame = CGRect(x: (self.view.center.x - 35), y: ((self.view.frame.height)*0.382) + 140 + 120 + 70, width: 70, height: 20)
		registerBtn.addTarget(self, action:#selector(registerBtnPressed), for: .touchUpInside)
		registerBtn.titleLabel?.font = .systemFont(ofSize: 14)
		view.addSubview(registerBtn)
	}
	
	@objc func loginBtnPressed(){
		// MARK: APP DEBUG MODE
		if true{
		//if isInputVaild(){
			mqttClient.setUpMQTT(userName: nameTxtBox.text!, password: passwordTxtBox.text!, viewContoller: self)
			mqttClient.connect()
			loginName = nameTxtBox.text!
		}
	}
	
	@objc func registerBtnPressed(){
		self.present(AddViewController(), animated: true)
		print("signup")
	}
	
	func isInputVaild() -> Bool {
		let name: String? = nameTxtBox.text
		let password: String? = passwordTxtBox.text
		var flag = 0
		if checkTextBoxInputTurnRed(txtBox: nameTxtBox, input: name) {
			txtBoxWarning(txtBox: nameTxtBox, toggle: true, msg: "Please enter your name.", label: nameWarningLabel)
		}
		else{
			txtBoxWarning(txtBox: nameTxtBox, toggle: false, msg: "", label: nameWarningLabel)
			flag += 1
		}
		if checkTextBoxInputTurnRed(txtBox: passwordTxtBox, input: password) {
			txtBoxWarning(txtBox: passwordTxtBox, toggle: true, msg: "Please enter password.", label: passwordWarningLabel)
		}
		else{
			txtBoxWarning(txtBox: passwordTxtBox, toggle: false, msg: "", label: passwordWarningLabel)
			flag += 1
		}
		if flag == 2 {
			return true
		}
		return false
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	
	func checkTextBoxInputTurnRed(txtBox: UITextField, input: String?) -> Bool{
		if input == "" {
			txtBox.useUnderline(color: true)
			return true
		}
		txtBox.useUnderline(color: false)
		return false
	}
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let currentText = textField.text ?? ""
		guard let stringRange = Range(range, in:currentText) else {
			return false
		}
		let updateText = currentText.replacingCharacters(in: stringRange, with: string)
		
		return updateText.count < 5
	}
	
	
	
	func txtBoxWarning(txtBox:UITextField, toggle: Bool, msg: String, label: UILabel) {
		if toggle {
			label.text = msg
			label.textColor = UIColor(red: 0.85490196, green: 0.24313725, blue: 0.32156863, alpha: 1)
			label.frame = CGRect(x: txtBox.frame.origin.x, y: txtBox.frame.origin.y + txtBox.frame.size.height + 5, width: txtBox.frame.size.width, height: 17)
			label.font = UIFont.systemFont(ofSize: 15, weight: .light)
			view.addSubview(label)
		}
		else{
			label.removeFromSuperview()
		}
	}
}
