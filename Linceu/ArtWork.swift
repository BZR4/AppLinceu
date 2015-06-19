//
//  ArtWork.swift
//  Linceu
//
//  Created by Esdras Bezerra da Silva on 03/06/15.
//  Copyright (c) 2015 Esdras Bezerra da Silva. All rights reserved.
//

import MapKit
import AddressBook

class Artwork: NSObject, MKAnnotation {
    let title: String
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String {
        return locationName
    }
    

    // annotation callout info button opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(kABPersonAddressStreetKey): subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }

}