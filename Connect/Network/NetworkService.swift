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
    
    func fetchRooms(completion: @escaping ([Room]?, Error?) -> Void) {
        guard let fetchRoomsURL = URL(string: baseURL + "rooms") else { return }
        
        let task = session.dataTask(with: fetchRoomsURL) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse else { return }
            do {
                if response.statusCode == 200 {
                    let result = try JSONDecoder().decode([Room].self, from: data)
                    completion(result, nil)
                } else {
                    completion(nil, error)
                }
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
