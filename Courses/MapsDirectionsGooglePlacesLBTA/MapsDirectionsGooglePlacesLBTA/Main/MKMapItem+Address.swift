//
//  MKMapItem+Address.swift
//  MapsDirectionsGooglePlacesLBTA
//
//  Created by Maksim Nosov on 15.12.2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import MapKit

extension MKMapItem {
    func address() -> String {
        var addressString = ""
        if placemark.subThoroughfare != nil {
            addressString = placemark.subThoroughfare! + " "
        }
        if placemark.thoroughfare != nil {
            addressString += placemark.thoroughfare! + ", "
        }
        if placemark.postalCode != nil {
            addressString += placemark.postalCode! + " "
        }
        if placemark.locality != nil {
            addressString += placemark.locality! + ", "
        }
        if placemark.administrativeArea != nil {
            addressString += placemark.administrativeArea! + " "
        }
        if placemark.country != nil {
            addressString += placemark.country!
        }
        return addressString
    }
}
