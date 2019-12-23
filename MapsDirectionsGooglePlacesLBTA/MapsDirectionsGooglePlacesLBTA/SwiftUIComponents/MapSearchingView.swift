//
//  MapSearchingView.swift
//  MapsDirectionsGooglePlacesLBTA
//
//  Created by Maksim Nosov on 23.12.2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import SwiftUI
import MapKit

struct MapViewContainer: UIViewRepresentable {
    
    typealias UIViewType = MKMapView
    
    var annotations = [MKPointAnnotation]()
    
    let mapView = MKMapView()
    
    // treat this as your setup area
    func makeUIView(context: UIViewRepresentableContext<MapViewContainer>) -> MKMapView {
        // setup the region
        setupRegionForMap()
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapViewContainer>) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(annotations)
        uiView.showAnnotations(uiView.annotations, animated: false)
    }
    
    fileprivate func setupRegionForMap() {
        let centerCoordinate = CLLocationCoordinate2D(latitude: 37.7666, longitude: -122.427290)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}

struct MapSearchingView: View {
    
    @State var annotations = [MKPointAnnotation]()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            MapViewContainer(annotations: annotations)
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                Button(action: {
                    // let's perform an airport search
                    self.performSearch(query: "airports")
                }) {
                    Text("Search for airport")
                        .padding()
                        .background(Color.white)
                }
                
                Button(action: {
                    self.annotations = []
                }) {
                    Text("Clear Annotations")
                        .padding()
                        .background(Color.white)
                }
            }.shadow(radius: 3)
        }
    }
    
    fileprivate func setupRegionForLocalSearch() -> MKCoordinateRegion {
        let centerCoordinate = CLLocationCoordinate2D(latitude: 37.7666, longitude: -122.427290)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        return region
    }
    
    fileprivate func performSearch(query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = setupRegionForLocalSearch()
        let localSearch = MKLocalSearch(request: request)
        localSearch.start { (resp, err) in
            // handle your error
            if let err = err {
                print("Failed to complete an search", err)
            }
            // success
            
            var airportAnnotations = [MKPointAnnotation]()
            
            resp?.mapItems.forEach({ (mapItem) in
                let annotation = MKPointAnnotation()
                annotation.title = mapItem.name
                annotation.coordinate = mapItem.placemark.coordinate
                airportAnnotations.append(annotation)
            })
            
            self.annotations = airportAnnotations
        }
    }
}

struct MapSearchingView_Previews: PreviewProvider {
    static var previews: some View {
        MapSearchingView()
    }
}
