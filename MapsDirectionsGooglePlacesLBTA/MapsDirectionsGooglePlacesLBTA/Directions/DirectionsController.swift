//
//  DirectionsController.swift
//  MapsDirectionsGooglePlacesLBTA
//
//  Created by Maksim Nosov on 16.12.2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit
import LBTATools
import MapKit
import SwiftUI

class DirectionsController: UIViewController {
    
    let mapView = MKMapView()
    let navBar = UIView(backgroundColor: #colorLiteral(red: 0.2587935925, green: 0.5251715779, blue: 0.9613835216, alpha: 1))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        
        // setup region for SF
        setupRegionForMap()
        
//        mapView.fillSuperview()
        
        setupNavBarUI()
        
        mapView.anchor(top: navBar.bottomAnchor,
                       leading: view.leadingAnchor,
                       bottom: view.bottomAnchor,
                       trailing: view.trailingAnchor)
        
        mapView.showsUserLocation = true
        setupStartEndDummyAnnotations()
    }
    
    fileprivate func setupStartEndDummyAnnotations() {
        let startAnnotation = MKPointAnnotation()
        startAnnotation.coordinate = .init(latitude: 37.7666, longitude: -122.427290)
        startAnnotation.title = "Start"
        
        let endAnnotation = MKPointAnnotation()
        endAnnotation.coordinate = .init(latitude: 37.331352, longitude: -122.030331)
        endAnnotation.title = "End"
        
        mapView.addAnnotation(startAnnotation)
        mapView.addAnnotation(endAnnotation)
        
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    fileprivate func setupNavBarUI() {
        
        view.addSubview(navBar)
        navBar.setupShadow(opacity: 0.5, radius: 5)
        navBar.anchor(top: view.topAnchor,
                      leading: view.leadingAnchor,
                      bottom: view.safeAreaLayoutGuide.topAnchor,
                      trailing: view.trailingAnchor,
                      padding: .init(top: 0, left: 0, bottom: -100, right: 0))
//        navBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
    }
    
    fileprivate func setupRegionForMap() {
        let centerCoordinate = CLLocationCoordinate2D(latitude: 37.7666, longitude: -122.427290)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}

struct DirectionsPreview: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
//            .environment(\.colorScheme, .light)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: UIViewControllerRepresentableContext<DirectionsPreview.ContainerView>) -> UIViewController {
            return DirectionsController()
        }
        
        func updateUIViewController(_ uiViewController: DirectionsPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<DirectionsPreview.ContainerView>) {
            
        }
        
    }
}
