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
        roomsViewController.modalPresentationStyle = .fullScreen
        self.present(roomsViewController, animated: true)
    }
}
