//
//  PlacesController.swift
//  MapsDirectionsGooglePlacesLBTA
//
//  Created by Maksim Nosov on 20.12.2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import SwiftUI
import LBTATools
import MapKit
import GooglePlaces

class PlacesController: UIViewController, CLLocationManagerDelegate {
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        mapView.fillSuperview()
        mapView.showsUserLocation = true
        locationManager.delegate = self
        
        requestForLocationAuthorization()
        
    }
    
    let client = GMSPlacesClient()
    
    fileprivate func findNearbyPlaces() {
        client.currentPlace { [weak self] (likelyhoodList, err) in
            if let err = err {
                print("Failed to find find current place:", err)
                return
            }
            
            likelyhoodList?.likelihoods.forEach({ (likelyhood) in
                print(likelyhood.place.name ?? "")
                
                let place = likelyhood.place
                
                let annotation = MKPointAnnotation()
                annotation.title = place.name
                annotation.coordinate = place.coordinate
                
                self?.mapView.addAnnotation(annotation)
            })
            
            self?.mapView.showAnnotations(self?.mapView.annotations ?? [], animated: true)
        }
    }
    
    fileprivate func requestForLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let first = locations.first else { return }
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: first.coordinate, span: span)
        mapView.setRegion(region, animated: false)
        
        findNearbyPlaces()
    }
}

struct PlacesController_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: UIViewControllerRepresentableContext<PlacesController_Previews.Container>) -> UIViewController {
            PlacesController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<PlacesController_Previews.Container>) {
            
        }
    }
}
