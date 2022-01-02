//
//  RoomsViewController.swift
//  Connect
//
//  Created by Malak Badawy on 31/12/2021.
//

import UIKit

class RoomsViewController: UIViewController {
    // MARK: - IBOutlets

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
        tableView.register(
            UINib(nibName: Constants.infoTableViewCell, bundle: nil),
            forCellReuseIdentifier: Constants.infoTableViewCell
        )
        
        tableView.register(
            UINib(nibName: Constants.roomsHeaderView, bundle: nil),
            forHeaderFooterViewReuseIdentifier: Constants.roomsHeaderView
        )
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.infoTableViewCell) as? InformationTableViewCell
        let room = rooms?[indexPath.row]
        cell?.selectionStyle = .none
        cell?.configure(
            id: room?.id ?? "",
            name: room?.name ?? "",
            maxOccupancy: "\(room?.max_occupancy ?? 0)",
            occupancy: viewModel?.appropriateOccupancyStatus(isOccupied: room?.is_occupied ?? false) ?? ""
        )
        return cell ?? UITableViewCell()
    }
}

// MARK: - Table View Delegate

extension RoomsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIConstants.roomsTableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.roomsHeaderView) as? RoomsHeaderView
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIConstants.roomsTableViewHeaderHeight
    }
}
