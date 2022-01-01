//
//  PeopleViewModel.swift
//  Connect
//
//  Created by Malak Badawy on 01/01/2022.
//

import Foundation

class PeopleViewModel {
    func fetchPeople(completion: @escaping ([Person]?, Error?) -> Void) {
        NetworkService.shared.fetchPeople { data, response, error in
            if error == nil {
                guard let data = data, let response = response as? HTTPURLResponse else { return }
                
                do {
                    if response.statusCode == 200 {
                        let result = try JSONDecoder().decode([Person].self, from: data)
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
    
    func retrieveFullName(firstName: String?, lastName: String?) -> String {
        guard let firstName = firstName, let lastName = lastName else {
            return ""
        }
        return firstName + " " + lastName
    }
}
