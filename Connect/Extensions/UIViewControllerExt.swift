//
//  UIViewControllerExt.swift
//  Connect
//
//  Created by Malak Badawy on 02/01/2022.
//

import Foundation
import UIKit

extension UIViewController {
    func addAsChildViewController(type controller: UIViewController, attached toView: UIView) {
        addChild(controller)
        toView.addSubview(controller.view)
        controller.view.frame = toView.bounds
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        controller.didMove(toParent: self)
    }
}
