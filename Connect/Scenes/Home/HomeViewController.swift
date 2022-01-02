//
//  HomeViewController.swift
//  Connect
//
//  Created by Malak Badawy on 31/12/2021.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak var peopleButton: UIButton! {
        didSet {
            peopleButton.layer.cornerRadius = UIConstants.cornerRadius
            peopleButton.alignTextBelow()
        }
    }
    @IBOutlet weak var roomsButton: UIButton! {
        didSet {
            roomsButton.layer.cornerRadius = UIConstants.cornerRadius
            roomsButton.alignTextBelow()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let roomsStoryboardName = "Rooms"
    let roomsViewCtrlIdentifier = "RoomsViewController"
    let peopleStoryboardName = "People"
    let peopleSplitViewCtrlIdentifier = "PeopleSplitViewController"
    
    // MARK: - IBActions
    
    @IBAction func didTapOnRooms(_ sender: UIButton) {
        let roomsStoryBoard = UIStoryboard(name: roomsStoryboardName, bundle: nil)
        let roomsViewController = roomsStoryBoard.instantiateViewController(withIdentifier: roomsViewCtrlIdentifier)
        navigationController?.pushViewController(roomsViewController, animated: true)
    }
    @IBAction func didTapOnPeople(_ sender: UIButton) {
        let containerViewCtrl = UIViewController()
        let peopleStoryBoard = UIStoryboard(name: peopleStoryboardName, bundle: nil)
        let peopleViewCtrl = peopleStoryBoard.instantiateViewController(withIdentifier: peopleSplitViewCtrlIdentifier)
        containerViewCtrl.addAsChildViewController(type: peopleViewCtrl, attached: containerViewCtrl.view)
        navigationController?.pushViewController(containerViewCtrl, animated: true)
    }
}

extension UIButton {
    func alignTextBelow(spacing: CGFloat = 6.0) {
        if let image = self.imageView?.image
        {
            let imageSize: CGSize = image.size
            self.titleEdgeInsets = UIEdgeInsets(top: spacing, left: -imageSize.width, bottom: -(imageSize.height), right: 0.0)
            let labelString = NSString(string: self.titleLabel!.text!)
            let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: self.titleLabel!.font])
            self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        }
    }
}
