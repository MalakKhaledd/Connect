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
            containerView.layer.cornerRadius = UIConstants.cornerRadius
        }
    }
    
    // MARK: - Public Functions

    func configure(id: String, name: String, maxOccupancy: String, occupancy: String) {
        idLabel.text = id
        nameLabel.text = name
        maxOccupancyLabel.text = maxOccupancy
        occupancyLabel.text = occupancy
        applyAccessibility(id: id, name: name, maxOccupancy: maxOccupancy, occupancy: occupancy)
    }
}

extension RoomTableViewCell {
    func applyAccessibility(id: String, name: String, maxOccupancy: String, occupancy: String) {
        idLabel.isAccessibilityElement = true
        idLabel.accessibilityTraits = .none
        idLabel.accessibilityLabel = "I.D Label"
        idLabel.accessibilityValue = id
        nameLabel.isAccessibilityElement = true
        nameLabel.accessibilityTraits = .none
        nameLabel.accessibilityLabel = "Name Label"
        nameLabel.accessibilityValue = name
        maxOccupancyLabel.isAccessibilityElement = true
        maxOccupancyLabel.accessibilityTraits = .none
        maxOccupancyLabel.accessibilityLabel = "Maximum Occupancy"
        maxOccupancyLabel.accessibilityValue = maxOccupancy
        occupancyLabel.isAccessibilityElement = true
        occupancyLabel.accessibilityTraits = .none
        occupancyLabel.accessibilityLabel = "Occupancy Status"
        occupancyLabel.accessibilityValue = occupancy
    }
}
