//
//  PeopleMasterViewControllerTableViewController.swift
//  Connect
//
//  Created by Malak Badawy on 01/01/2022.
//

import UIKit

class PeopleMasterTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "RoomTableViewCell", bundle: nil), forCellReuseIdentifier: "RoomTableViewCell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTableViewCell") as? RoomTableViewCell
        
        cell?.configure(id: "", name: "test", maxOccupancy: "", occupancy: "")

        return cell ?? UITableViewCell()
    }
    
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
