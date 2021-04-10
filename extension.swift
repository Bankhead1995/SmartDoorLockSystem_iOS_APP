//
//  extension.swift
//  testing
//
//  Created by Weixin Kong on 2021-02-04.
//

import Foundation
import UIKit

extension UITextField {
	func useUnderline(color: Bool) -> Void {
		//0 is UIColor.systemGray4.cgColor
		//1 is .red
		let border = CALayer()
		let borderWidth = CGFloat(1.6)
		var outputColor = UIColor.systemGray4.cgColor
		if color {
			outputColor = UIColor.red.cgColor
		}
		border.borderColor = outputColor
		border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
		border.borderWidth = borderWidth
		self.layer.addSublayer(border)
		self.layer.masksToBounds = true
  }
}
extension UIButton {
	
	func startAnimatingPressActions() {
		addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
		addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
	}
	
	@objc private func animateDown(sender: UIButton) {
		animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.98, y: 0.98))
	}
	
	@objc private func animateUp(sender: UIButton) {
		animate(sender, transform: .identity)
	}
	
	private func animate(_ button: UIButton, transform: CGAffineTransform) {
		UIView.animate(withDuration: 0.4,
					   delay: 0,
					   usingSpringWithDamping: 0.5,
					   initialSpringVelocity: 3,
					   options: [.curveEaseInOut],
					   animations: {
						button.transform = transform
			}, completion: nil)
	}
	
	func CirclePressActions() {
		addTarget(self, action: #selector(CircleDown), for: [.touchDown])
		addTarget(self, action: #selector(CircleUp), for: [.touchUpInside])
	}
	
	@objc private func CircleDown(sender: UIButton) {
		Circleanimate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.2, y: 0.2))
	}
	
	@objc private func CircleUp(sender: UIButton) {
		Circleanimate(sender, transform: .identity)
	}
	
	private func Circleanimate(_ button: UIButton, transform: CGAffineTransform) {
		UIView.animate(withDuration: 0.9,
					   delay: 0,
					   usingSpringWithDamping: 0.5,
					   initialSpringVelocity: 0.5,
					   options: [.curveEaseIn],
					   animations: {
						button.transform = transform
			}, completion: nil)
	}
}
