//
//  RoomsViewController.swift
//  Connect
//
//  Created by Malak Badawy on 31/12/2021.
//

import UIKit

class RoomsViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.setTitle("", for: .normal)
        }
    }
    @IBOutlet weak var tableView: UITableView!
   
    // MARK: - Private Properties

    private var viewModel: RoomsViewModel?
    private var rooms: [Room]?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        fetchRooms()
    }
    
    // MARK: - Private Functions

    private func configureViewModel() {
        viewModel = RoomsViewModel()
    }
    
    private func fetchRooms() {
        viewModel?.fetchRooms { [weak self] rooms, error in
            self?.rooms = rooms
        }
    }

    // MARK: - IBActions

    @IBAction func didTapCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
