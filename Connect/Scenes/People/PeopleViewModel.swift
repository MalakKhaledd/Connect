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
    
    func getAddress(lat: Double, long: Double, completion: @escaping (String) -> Void)
    {
        var address: String = ""
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: long)
        //selectedLat and selectedLon are double values set by the app in a previous process
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark?
            placeMark = placemarks?[0]
            
            // Address dictionary
            //print(placeMark.addressDictionary ?? "")
            
            // Location name
            if let locationName = placeMark?.addressDictionary?["Name"] as? String {
                address += locationName + ", "
            }
            
            // Street address
            if let street = placeMark?.addressDictionary?["Thoroughfare"] as? String {
                address += street + ", "
            }
            
            // City
            if let city = placeMark?.addressDictionary?["City"] as? String {
                address += city + ", "
            }
            
            // Zip code
            if let zip = placeMark?.addressDictionary?["ZIP"] as? String {
                address += zip + ", "
            }
            
            // Country
            if let country = placeMark?.addressDictionary?["Country"] as? String {
                address += country
            }
            
           // Passing address back
           completion(address)
        })
    }
    
//    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) -> String {
//            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
//            let lat: Double = Double("\(pdblLatitude)")!
//            //21.228124
//            let lon: Double = Double("\(pdblLongitude)")!
//            //72.833770
//            let ceo: CLGeocoder = CLGeocoder()
//            center.latitude = lat
//            center.longitude = lon
//
//            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
//            var addressString : String = ""
//
//
//            ceo.reverseGeocodeLocation(loc, completionHandler:
//                {(placemarks, error) in
//                    if (error != nil)
//                    {
//                        print("reverse geodcode fail: \(error!.localizedDescription)")
//                    }
//                    let pm = placemarks! as [CLPlacemark]
//
//                    if pm.count > 0 {
//                        let pm = placemarks![0]
//                        print(pm.country)
//                        print(pm.locality)
//                        print(pm.subLocality)
//                        print(pm.thoroughfare)
//                        print(pm.postalCode)
//                        print(pm.subThoroughfare)
//                        if pm.subLocality != nil {
//                            addressString = addressString + pm.subLocality! + ", "
//                        }
//                        if pm.thoroughfare != nil {
//                            addressString = addressString + pm.thoroughfare! + ", "
//                        }
//                        if pm.locality != nil {
//                            addressString = addressString + pm.locality! + ", "
//                        }
//                        if pm.country != nil {
//                            addressString = addressString + pm.country! + ", "
//                        }
//                        if pm.postalCode != nil {
//                            addressString = addressString + pm.postalCode! + " "
//                        }
//
//                        print(addressString)
//
//                  }
//            })
//        return addressString
//        }
}
