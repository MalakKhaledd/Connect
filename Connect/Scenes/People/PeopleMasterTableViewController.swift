//
//  PeopleMasterViewControllerTableViewController.swift
//  Connect
//
//  Created by Malak Badawy on 01/01/2022.
//

import UIKit

class PeopleMasterTableViewController: UITableViewController {
    // MARK: - Private Properties
    
    private var viewModel: PeopleViewModel?
    private var people: [Person]?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureViewModel()
        fetchPeople()
    }
    
    // MARK: - Private Functions
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "RoomTableViewCell", bundle: nil), forCellReuseIdentifier: "RoomTableViewCell")
    }
    
    private func configureViewModel() {
        viewModel = PeopleViewModel()
    }
    
    private func fetchPeople() {
        viewModel?.fetchPeople { [weak self] people, error in
            if error == nil {
                self?.people = people
                self?.reloadTable()
            }
        }
    }
    
    private func reloadTable() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTableViewCell") as? RoomTableViewCell
        let person = people?[indexPath.row]
        cell?.configure(
            id: "",
            name: viewModel?.retrieveFullName(firstName: person?.firstName, lastName: person?.lastName) ?? "",
            maxOccupancy: "",
            occupancy: ""
        )
        return cell ?? UITableViewCell()
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let splitViewController = splitViewController {
//            if splitViewController.isCollapsed {
//                let shipmentDetailViewController = storyboard?.instantiateViewController(identifier: "shipmentDetailViewController") as! ShipmentDetailViewController
//                shipmentDetailViewController.shipment = selectedShipment
//                self.navigationController?.pushViewController(shipmentDetailViewController, animated: true)
//            }
//        }
    }
}
