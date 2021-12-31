//
//  Room.swift
//  Connect
//
//  Created by Malak Badawy on 31/12/2021.
//

import Foundation

struct Room: Codable {
    let id: String
    let created_at: String
    let name: String
    let max_occupancy: Int
    let is_occupied: Bool
}
