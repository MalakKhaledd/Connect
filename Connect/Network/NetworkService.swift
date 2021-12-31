//
//  NetworkService.swift
//  Connect
//
//  Created by Malak Badawy on 31/12/2021.
//

import Foundation
import UIKit

class NetworkService {
    static let shared = NetworkService()
    
    private let baseURL = "https://5f7c2c8400bd74001690a583.mockapi.io/api/v1/"
    private let session = URLSession(configuration: .default)
    
    func fetchRooms(completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let fetchRoomsURL = URL(string: baseURL + "rooms") else { return }
        
        let task = session.dataTask(with: fetchRoomsURL) { data, response, error in
            completion(data, response, error)
        }
        task.resume()
    }
}
