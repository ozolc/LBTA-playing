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
//        annotationView.canShowCallout = true
        
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
        
        let customCalloutContainer = UIView(backgroundColor: .white)
        
//        customCalloutContainer.frame = .init(x: 0, y: 0, width: 100, height: 100)
        
        view.addSubview(customCalloutContainer)
        
        customCalloutContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let widthAnchor = customCalloutContainer.widthAnchor.constraint(equalToConstant: 100)
            widthAnchor.isActive = true
        let heightAnchor = customCalloutContainer.heightAnchor.constraint(equalToConstant: 200)
            heightAnchor.isActive = true
        customCalloutContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        customCalloutContainer.bottomAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        customCalloutContainer.layer.borderWidth = 2
        customCalloutContainer.layer.borderColor = UIColor.darkGray.cgColor
        customCalloutContainer.setupShadow(opacity: 0.2, radius: 5, offset: .zero, color: .darkGray)
        customCalloutContainer.layer.cornerRadius = 5
        
        currentCustomCallout = customCalloutContainer
        
        // load the spinner
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .darkGray
        spinner.startAnimating()
        customCalloutContainer.addSubview(spinner)
        spinner.fillSuperview()
        
        // look up our photo
        guard let placeId = (view.annotation as? PlaceAnnotation)?.place.placeID else { return }
        
        client.lookUpPhotos(forPlaceID: placeId) { [weak self] (metadatalist, err) in
            if let err = err {
                print("Error when looking up photos:", err)
            }
            
//            print(metadatalist)
            guard let firstPhotoMetadata = metadatalist?.results.first else { return }
            
            self?.client.loadPlacePhoto(firstPhotoMetadata) { (image, err) in
                if let err = err {
                    print("Faile to load photo for place:", err)
                }
                
                guard let image = image else { return }
                
                if image.size.width > image.size.height {
                    // w1/h1 = w2/h2
                    let newWidth: CGFloat = 150
                    let newHeight = newWidth / image.size.width * image.size.height
                    widthAnchor.constant = newWidth
                    heightAnchor.constant = newHeight
                }
                
                widthAnchor.constant = image.size.width
                heightAnchor.constant = image.size.height
                
                let imageView = UIImageView(image: image, contentMode: .scaleAspectFill)
                customCalloutContainer.addSubview(imageView)
                imageView.fillSuperview()
            }
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
