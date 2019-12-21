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
        
        setupSelectedAnnotationHUD()
    }
    
    let hudNameLabel = UILabel(text: "Name", font: .boldSystemFont(ofSize: 16))
    let hudAddressLabel = UILabel(text: "Address", font: .boldSystemFont(ofSize: 16))
    let hudTypesLabel = UILabel(text: "Types", textColor: .gray)
    lazy var infoButton = UIButton(type: .infoLight)
    let hudContainer = UIView(backgroundColor: .white)
    
    fileprivate func setupSelectedAnnotationHUD() {
        view.addSubview(hudContainer)
        hudContainer.layer.cornerRadius = 5
        hudContainer.setupShadow(opacity: 0.2, radius: 5, offset: .zero, color: .darkGray)
        hudContainer.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .allSides(16), size: .init(width: 0, height: 125))
        
        let topRow = UIView()
        topRow.hstack(hudNameLabel, infoButton.withWidth(44))
        hudContainer.hstack(hudContainer.stack(topRow,
                             hudAddressLabel,
                             hudTypesLabel, spacing: 8),
                   alignment: .center).withMargins(.allSides(16))
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
                    annotationView.image = #imageLiteral(resourceName: "tourist")
                }
            }
        }
        
        return annotationView
    }
    
    var currentCustomCallout: UIView?
    
    fileprivate func setupHUD(view: MKAnnotationView) {
        guard let annotation = view.annotation as? PlaceAnnotation else { return }
        
        let place = annotation.place
        hudNameLabel.text = place.name
        hudAddressLabel.text = place.formattedAddress
        hudTypesLabel.text = place.types?.joined(separator: ", ")
    }
    
    class CalloutContainer: UIView {
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            backgroundColor = .white
            
            translatesAutoresizingMaskIntoConstraints = false
            layer.borderWidth = 2
            layer.borderColor = UIColor.darkGray.cgColor
            setupShadow(opacity: 0.2, radius: 5, offset: .zero, color: .darkGray)
            layer.cornerRadius = 5
            
            // load the spinner
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.color = .darkGray
            spinner.startAnimating()
            addSubview(spinner)
            spinner.fillSuperview()
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        setupHUD(view: view)
        
        currentCustomCallout?.removeFromSuperview()
        
        let customCalloutContainer = CalloutContainer()
        
        view.addSubview(customCalloutContainer)
        
        let widthAnchor = customCalloutContainer.widthAnchor.constraint(equalToConstant: 100)
        widthAnchor.isActive = true
        let heightAnchor = customCalloutContainer.heightAnchor.constraint(equalToConstant: 200)
        heightAnchor.isActive = true
        customCalloutContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        customCalloutContainer.bottomAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        currentCustomCallout = customCalloutContainer
        
        // look up our photo
        guard let firstPhotoMetadata = (view.annotation as? PlaceAnnotation)?.place.photos?.first else { return }
        
        self.client.loadPlacePhoto(firstPhotoMetadata) { [weak self] (image, err) in
            if let err = err {
                print("Faile to load photo for place:", err)
            }
            
            guard let image = image else { return }
            
            guard let bestSize = self?.bestCalloutImageSize(image: image) else { return }
            widthAnchor.constant = bestSize.width
            heightAnchor.constant = bestSize.height
            
            let imageView = UIImageView(image: image, contentMode: .scaleAspectFill)
            customCalloutContainer.addSubview(imageView)
            imageView.layer.cornerRadius = 5
            imageView.fillSuperview()
            
            // label
            let labelContainer = UIView(backgroundColor: .white)
            let nameLabel = UILabel(text: (view.annotation as? PlaceAnnotation)?.place.name, textAlignment: .center)
            labelContainer.stack(nameLabel)
            customCalloutContainer.stack(UIView(), labelContainer.withHeight(30))
        }
    }
    
    fileprivate func bestCalloutImageSize(image: UIImage) -> CGSize {
        if image.size.width > image.size.height {
            // w1/h1 = w2/h2
            let newWidth: CGFloat = 300
            let newHeight = newWidth / image.size.width * image.size.height
            return .init(width: newWidth, height: newHeight)
        } else {
            let newHeight: CGFloat = 200
            let newWidth = newHeight / image.size.height * image.size.width
            return .init(width: newWidth, height: newHeight)
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
