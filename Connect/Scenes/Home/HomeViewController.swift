//
//  HomeViewController.swift
//  Connect
//
//  Created by Malak Badawy on 31/12/2021.
//

import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapOnRooms(_ sender: UIButton) {
        let roomsStoryBoard = UIStoryboard(name: "Rooms", bundle: nil)
        let roomsViewController = roomsStoryBoard.instantiateViewController(withIdentifier: "RoomsViewController")
        navigationController?.pushViewController(roomsViewController, animated: true)
    }
    @IBAction func didTapOnPeople(_ sender: UIButton) {
        let container = UIViewController()
        let peopleStoryBoard = UIStoryboard(name: "People", bundle: nil)
        let peopleViewCtrl = peopleStoryBoard.instantiateViewController(withIdentifier: "PeopleSplitViewController")
        container.addAsChildViewController(type: peopleViewCtrl, attached: container.view)
        navigationController?.pushViewController(container, animated: true)
    }
}

extension UIViewController {
    func addAsChildViewController(type controller: UIViewController, attached toView: UIView) {
        addChild(controller)
        toView.addSubview(controller.view)
        controller.view.frame = toView.bounds
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        controller.didMove(toParent: self)
    }
}
