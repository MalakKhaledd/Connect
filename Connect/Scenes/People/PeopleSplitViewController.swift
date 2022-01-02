//
//  PeopleSplitViewController.swift
//  Connect
//
//  Created by Malak Badawy on 01/01/2022.
//

import UIKit

class PeopleSplitViewController: UISplitViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredDisplayMode = .allVisible
        if #available(iOS 14.0, *) {
            let masterVC = self.viewController(for: .primary) as? PeopleMasterTableViewController
            let detailVC = self.viewController(for: .secondary) as? PeopleDetailViewController
            masterVC?.delegate = detailVC
        }
    }
}
