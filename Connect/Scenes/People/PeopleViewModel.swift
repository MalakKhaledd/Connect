//
//  PeopleViewModel.swift
//  Connect
//
//  Created by Malak Badawy on 01/01/2022.
//

import CoreLocation
import Foundation

class PeopleViewModel {
    var people: [Person]?

    func fetchPeople(completion: @escaping ([Person]?, Error?) -> Void) {
        NetworkService.shared.fetchPeople { data, response, error in
            if error == nil {
                guard let data = data, let response = response as? HTTPURLResponse else { return }
                
                do {
                    if response.statusCode == 200 {
                        let result = try JSONDecoder().decode([Person].self, from: data)
                        self.people = result
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
    
    func getAddress(lat: Double, long: Double, completion: @escaping (String) -> Void) {
        var address: String = ""
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: long)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            var placeMark: CLPlacemark?
            placeMark = placemarks?[0]
            
            if let locationName = placeMark?.name {
                address += locationName + ", "
            }
            
            if let street = placeMark?.thoroughfare {
                address += street + ", "
            }

            if let city = placeMark?.subAdministrativeArea {
                address += city + ", "
            }

            if let country = placeMark?.country {
                address += country
            }
            
           completion(address)
        })
    }
}
