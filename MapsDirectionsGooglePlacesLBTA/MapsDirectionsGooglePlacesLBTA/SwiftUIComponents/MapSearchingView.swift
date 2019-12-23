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
    
    let mapView = MKMapView()
    
    // treat this as your setup area
    func makeUIView(context: UIViewRepresentableContext<MapViewContainer>) -> MKMapView {
        // setup the region
        setupRegionForMap()
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapViewContainer>) {
        
    }
    
    fileprivate func setupRegionForMap() {
        let centerCoordinate = CLLocationCoordinate2D(latitude: 37.7666, longitude: -122.427290)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}

struct MapSearchingView: View {
    var body: some View {
        ZStack(alignment: .top) {
            
            MapViewContainer()
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                Button(action: {
                    
                }) {
                    Text("Search for airport")
                        .padding()
                        .background(Color.white)
                }
                
                Button(action: {
                    
                }) {
                    Text("Clear Annotations")
                        .padding()
                        .background(Color.white)
                }
            }.shadow(radius: 3)
        }
    }
}

struct MapSearchingView_Previews: PreviewProvider {
    static var previews: some View {
        MapSearchingView()
    }
}
