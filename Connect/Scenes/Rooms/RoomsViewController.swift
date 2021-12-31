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
        configureTableView()
        fetchRooms()
    }
    
    // MARK: - Private Functions

    private func configureViewModel() {
        viewModel = RoomsViewModel()
    }
    
    private func fetchRooms() {
        viewModel?.fetchRooms { [weak self] rooms, error in
            self?.rooms = rooms
            self?.reloadTable()
        }
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "RoomTableViewCell", bundle: nil), forCellReuseIdentifier: "RoomTableViewCell")
        tableView.register(UINib(nibName: "RoomsHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "RoomsHeaderView")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func reloadTable() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    // MARK: - IBActions

    @IBAction func didTapCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

// MARK: - Table View Data Source

extension RoomsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTableViewCell") as? RoomTableViewCell
        let room = rooms?[indexPath.row]
        cell?.configure(id: room?.id ?? "", name: room?.name ?? "", maxOccupancy: "\(room?.max_occupancy ?? 0)", occupancy: "\(room?.is_occupied ?? false)")
        return cell ?? UITableViewCell()
    }
}

// MARK: - Table View Delegate

extension RoomsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RoomsHeaderView") as? RoomsHeaderView
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
