//
//  RoomsViewModel.swift
//  Connect
//
//  Created by Malak Badawy on 31/12/2021.
//

import Foundation

class RoomsViewModel {
    func fetchRooms(completion: @escaping ([Room]?, Error?) -> Void) {
        NetworkService.shared.fetchRooms { data, response, error in
            if error == nil {
                guard let data = data, let response = response as? HTTPURLResponse else { return }
                
                do {
                    if response.statusCode == 200 {
                        let result = try JSONDecoder().decode([Room].self, from: data)
                        completion(result, nil)
                    }
                } catch {
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
        }
    }
    
    func appropriateOccupancyStatus(isOccupied: Bool) -> String {
        return isOccupied ? "Occupied" : "Free"
    }
}
