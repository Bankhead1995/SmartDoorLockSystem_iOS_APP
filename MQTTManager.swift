//
//  MQTTManager.swift
//  testing
//
//  Created by Weixin Kong on 2021-02-09.
//

import Foundation
import CocoaMQTT

class MQTTManager {
	private var mqtt:CocoaMQTT!
	private var host = "192.168.50.125"
	private var port = 1883
	private var topic:String!
	private var vc : UIViewController!
	
	func setUpMQTT(userName: String, password: String, viewContoller:UIViewController){
		vc = viewContoller
		let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
		mqtt = CocoaMQTT(clientID: clientID, host: host, port: UInt16(port))
		mqtt.username = userName
		mqtt.password = password
		// MARK: MQTT DEBUG MODE ON
		mqtt.logLevel = .debug
		mqtt.delegate = self
	}
	
	func connect(){
		let ret = mqtt.connect()
		//
		if !ret{
			let alert = UIAlertController(title: "Error", message: "Fail to connect to the lock, Please make sure the device is in the same network and Try Again", preferredStyle: UIAlertController.Style.alert)
			alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
			vc.present(alert, animated: true, completion: nil)
		}
	}
	
	func disconnect(){
		mqtt.disconnect()
	}
	
	func publish(Msg: String) {
		mqtt.publish("rpi/lock", withString:Msg)
	}
}

extension MQTTManager{
	func loginAlert(){
		let alert = UIAlertController(title: "Error", message: "Your account or password is incorrect. Please Try again", preferredStyle: UIAlertController.Style.alert)
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
		vc.present(alert, animated: true, completion: nil)
	}
}

extension MQTTManager: CocoaMQTTDelegate{
	func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck){
		// MARK: APP DEBUG MODE
		//if ack == .accept {
		if true {
			let mainPage = MainPageViewController()
			mainPage.modalPresentationStyle = .fullScreen
			vc.present(mainPage, animated: true)
		}
		else{
			loginAlert()
		}
	}
	func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16){
		
	}
	func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16){
		
	}
	func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16 ){
		
	}
	func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topics: [String]){
		
	}
	func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String){
		
	}
	func mqttDidPing(_ mqtt: CocoaMQTT){
		
	}
	func mqttDidReceivePong(_ mqtt: CocoaMQTT){
		
	}
	func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?){
		
	}
}

