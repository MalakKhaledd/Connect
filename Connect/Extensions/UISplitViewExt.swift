//
//  UISplitViewExt.swift
//  Connect
//
//  Created by Malak Badawy on 02/01/2022.
//

import Foundation
import UIKit

extension UISplitViewController {
    var primaryViewController: PeopleMasterTableViewController? {
        let navController = self.viewControllers.first as? UINavigationController
        return navController?.topViewController as? PeopleMasterTableViewController
    }
    
    var secondaryViewController: PeopleDetailViewController? {
        let navController = self.viewControllers[1] as? UINavigationController
        return navController?.topViewController as? PeopleDetailViewController
    }
}
