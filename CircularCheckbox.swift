//
//  CircularCheckbox.swift
//  testing
//
//  Created by Weixin Kong on 2021-03-24.
//

import UIKit

final class CircularCheckbox: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		layer.borderWidth = 0.5
		layer.borderColor = UIColor.secondaryLabel.cgColor
		layer.cornerRadius = frame.size.width / 2.0
		backgroundColor = .systemBackground
	}
	required init?(coder: NSCoder) {
		fatalError()
	}
	func setChecked(_ isChecked: Bool){
		if isChecked {
			backgroundColor = .systemBlue
		}
		else{
			backgroundColor = .systemBackground
		}
	}
}

