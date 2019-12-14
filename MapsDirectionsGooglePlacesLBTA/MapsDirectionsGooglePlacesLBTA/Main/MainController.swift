//
//  MainController.swift
//  MapsDirectionsGooglePlacesLBTA
//
//  Created by Maksim Nosov on 14.12.2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit
import MapKit
import LBTATools

class MainController: UIViewController {
    
    let mapView =  MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        mapView.fillSuperview()
        
        mapView.mapType = .hybrid
        
    }
}
