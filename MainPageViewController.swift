//
//  MainPageViewController.swift
//  testing
//
//  Created by Weixin Kong on 2021-02-10.
//

import UIKit
import CocoaMQTT
import SideMenu
class MainPageViewController: UIViewController {
	let lockSwitch = UISwitch()
	let switchLabel = UILabel()
	var status = false
	let lockBtn = UIButton()
	let lockViewBtn = UIButton()
	let userViewBtn = UIButton()
	var menu: SideMenuNavigationController?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = backgroundColor
		//let topView = curveView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 0.8))
		//self.view.addSubview(topView)
		
		
		//switch
		/*
		lockSwitch.center.x = self.view.center.x
		lockSwitch.center.y = self.view.center.y
		lockSwitch.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
		//view.addSubview(lockSwitch)*/
		
		//LockButton
		lockBtn.setBackgroundImage(stateToColor(state: status), for: .normal)
		lockBtn.frame = CGRect(x: 0, y: 0, width: 270, height: 270)
		lockBtn.center.x = self.view.center.x
		lockBtn.center.y = self.view.center.y
		lockBtn.clipsToBounds = true
		lockBtn.layer.cornerRadius = lockBtn.frame.height/2
		lockBtn.addTarget(self, action: #selector(lockPressed) ,for: .touchUpInside)
		view.addSubview(lockBtn)
		
		//lockLabel
		switchLabel.text = "My Lock"
		switchLabel.font = UIFont(name: "Avenir-Black", size: 25)
		//switchLabel.font = switchLabel.font.withSize(30)
		switchLabel.textColor = textColor
		switchLabel.frame = CGRect(x: 0, y: 0, width: 250, height: 100)
		switchLabel.textAlignment = .center
		switchLabel.center.x = self.view.center.x
		switchLabel.center.y = self.view.center.y - lockBtn.frame.height/2 - view.frame.height * 0.07
		view.addSubview(switchLabel)
		
		//lockViewBtn
		/*
		lockViewBtn.setImage(UIImage(named: "lockMenu"), for: .normal)
		lockViewBtn.imageView?.contentMode = .scaleAspectFit
		lockViewBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
		lockViewBtn.center.x = self.view.center.x/2
		lockViewBtn.center.y = self.view.center.y * 1.8
		lockViewBtn.clipsToBounds = true
		view.addSubview(lockViewBtn)
		*/
		
		//userViewBtn
		userViewBtn.setImage(UIImage(named: "userIcon"), for: .normal)
		userViewBtn.imageView?.contentMode = .scaleAspectFit
		userViewBtn.frame = CGRect(x: 0, y: 0, width: 29, height: 29)
		userViewBtn.center.x = self.view.center.x * 1.8
		userViewBtn.center.y = self.view.center.y * 0.2
		userViewBtn.clipsToBounds = true
		userViewBtn.addTarget(self, action: #selector(userViewBtnPressed),for: .touchUpInside)
		view.addSubview(userViewBtn)
		
		//sideMenu
		menu = SideMenuNavigationController(rootViewController: MenuListController())
		menu?.setNavigationBarHidden(true, animated: false)
		SideMenuManager.default.rightMenuNavigationController = menu
		SideMenuManager.default.addPanGestureToPresent(toView: self.view)
		//menu?.leftSide = false
		//lockview | userview line
		/*
		let linePath = UIBezierPath.init()
		linePath.move(to: CGPoint.init(x:self.view.center.x, y: lockViewBtn.frame.origin.y + lockViewBtn.frame.height ))
		linePath.addLine(to: CGPoint.init(x: self.view.center.x, y: lockViewBtn.frame.origin.y))
		
		let lineLayer = CAShapeLayer.init()
		lineLayer.lineWidth = 1.5
		lineLayer.strokeColor = backgroundColor.cgColor
		lineLayer.path = linePath.cgPath
		lineLayer.fillColor = UIColor.clear.cgColor
		
		self.view.layer.addSublayer(lineLayer)
		*/
    }
	@objc private func switchChanged(){
		status = !status
		sendCommand(state: status)
	}
	
	@objc private func lockPressed(sender: UIButton){
		status = !status
		self.circleAnimate(sender, img: stateToColor(state: status))
		sendCommand(state: status)
	}
	
	@objc private func userViewBtnPressed(sender: UIButton){
		present(menu!, animated: true)
	}
	
	func sendCommand(state: Bool){
		if state == true{
			mqttClient.publish(Msg:"lock/on")
		}
		else{
			mqttClient.publish(Msg:"lock/off")
		}
	}
}
extension MainPageViewController{
	fileprivate func circleAnimate(_ viewToAnimate: UIButton, img: UIImage){
		UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: .curveEaseIn, animations: {
			viewToAnimate.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
		}){(_) in
			UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 15, options: .curveEaseIn, animations: {
				//viewToAnimate.backgroundColor = color
				viewToAnimate.setBackgroundImage(img, for: .normal)
				viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
			}, completion: nil)
		}
	}
	
	private func stateToColor(state: Bool)->UIImage{
		if(state){
			return UIImage(named: "lockImgGreen")!
		}
		return UIImage(named: "lockImgRed")!
	}
}

class MenuListController: UITableViewController {
	var list = ["Modify user", "Add user", "Delete user"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.backgroundColor = backgroundColor
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return list.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = list[indexPath.row]
		cell.textLabel?.textColor = textColor
		cell.backgroundColor = backgroundColor
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		switch indexPath{
		case [0, 0]:
			print("modify")
			self.present(ModifyViewController(), animated: true)
		case [0, 1]:
			print("add")
			self.present(AddViewController(), animated: true)
		case [0, 2]:
			self.present(DeleteViewController(), animated: true)
			print("delete")
		default:
			break
		}
		
	}
}

class curveView: UIView{
	override init(frame: CGRect){
		super.init(frame: frame)
		backgroundColor = .clear
	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		backgroundColor = .clear
	}
	
	override func draw(_ rect: CGRect) {
		let size = self.bounds.size
		let h = size.height * 0.93
		
		let p1 = self.bounds.origin
		let p2 = CGPoint(x:p1.x + size.width, y:p1.y)
		let p3 = CGPoint(x:p2.x, y:p2.y + h)
		let p4 = CGPoint(x:size.width/2, y:size.height)
		let p5 = CGPoint(x:p1.x, y:h)

		let path = UIBezierPath()
		path.move(to: p1)
		path.addLine(to: p2)
		path.addLine(to: p3)
		//path.addQuadCurve(to: p4, controlPoint: CGPoint(x:size.width / 2, (size.height - h) - 60))
		path.addLine(to: p4)
		path.addLine(to: p5)
		path.close()

		UIColor(red: 0.22352941, green: 0.24313725, blue: 0.2745098, alpha: 1.00).set()
		path.fill()
	}
}
