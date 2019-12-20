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

class PlacesController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        mapView.fillSuperview()
        mapView.delegate = self
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
                
                let annotation = PlaceAnnotation(place: place)
                annotation.title = place.name
                annotation.coordinate = place.coordinate
                
                self?.mapView.addAnnotation(annotation)
            })
            
            self?.mapView.showAnnotations(self?.mapView.annotations ?? [], animated: true)
        }
    }
    
    class PlaceAnnotation: MKPointAnnotation {
        let place: GMSPlace
        
        init(place: GMSPlace) {
            self.place = place
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is PlaceAnnotation) { return nil }
        
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "id")
        annotationView.canShowCallout = true
        
        if let placeAnnotation = annotation as? PlaceAnnotation {
            let types = placeAnnotation.place.types
            if let firstType = types?.first {
                if firstType == "bar" {
                    annotationView.image = #imageLiteral(resourceName: "bar")
                } else if firstType == "restaurant" {
                    annotationView.image = #imageLiteral(resourceName: "restaurant")
                } else {
                    annotationView.image = #imageLiteral(resourceName: "tourist-1")
                }
            }
        }
        
        return annotationView
    }
    
    var currentCustomCallout: UIView?
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        currentCustomCallout?.removeFromSuperview()
        
        let customCalloutContainer = UIView(backgroundColor: .red)
        
//        customCalloutContainer.frame = .init(x: 0, y: 0, width: 100, height: 100)
        
        view.addSubview(customCalloutContainer)
        
        customCalloutContainer.translatesAutoresizingMaskIntoConstraints = false
        
        customCalloutContainer.widthAnchor.constraint(equalToConstant: 100).isActive = true
        customCalloutContainer.heightAnchor.constraint(equalToConstant: 200).isActive = true
        customCalloutContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        customCalloutContainer.bottomAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        currentCustomCallout = customCalloutContainer
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
