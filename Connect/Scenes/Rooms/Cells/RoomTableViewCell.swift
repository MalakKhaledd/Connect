//
//  RoomTableViewCell.swift
//  Connect
//
//  Created by Malak Badawy on 31/12/2021.
//

import UIKit

class RoomTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var maxOccupancyLabel: UILabel!
    @IBOutlet weak var occupancyLabel: UILabel!
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 10
        }
    }
    
    // MARK: - Public Functions

    func configure(id: String, name: String, maxOccupancy: String, occupancy: String) {
        idLabel.text = id
        nameLabel.text = name
        maxOccupancyLabel.text = maxOccupancy
        occupancyLabel.text = occupancy
    }
}