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
    
    func makeCoordinator() -> MapViewContainer.Coordinator {
        return Coordinator(mapView: mapView)
    }
    
    typealias UIViewType = MKMapView
    
    var annotations = [MKPointAnnotation]()
    var selectedMapItem: MKMapItem?
    var currentLocation = CLLocationCoordinate2D(latitude: 37.7666, longitude: -122.427290)
    
    let mapView = MKMapView()
    
    // treat this as your setup area
    func makeUIView(context: UIViewRepresentableContext<MapViewContainer>) -> MKMapView {
        // setup the region
        setupRegionForMap()
        mapView.showsUserLocation = true
        return mapView
    }
    
    // I want to set mapView.delegate = ?? somewhere
    class Coordinator: NSObject, MKMapViewDelegate {
        
        init(mapView: MKMapView) {
            super.init()
            mapView.delegate = self
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            if !(annotation is MKPointAnnotation) { return nil }
            
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "id")
            pinAnnotationView.canShowCallout = true
            return pinAnnotationView
        }
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapViewContainer>) {
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: currentLocation, span: span)
        
        uiView.setRegion(region, animated: true)
        
        if annotations.count == 0 {
            uiView.removeAnnotations(uiView.annotations)
        }
        
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(annotations)
        uiView.showAnnotations(uiView.annotations, animated: false)
        
        uiView.annotations.forEach { (annotation) in
            if annotation.title == selectedMapItem?.name {
                uiView.selectAnnotation(annotation, animated: true)
            }
        }
    }
    
    fileprivate func setupRegionForMap() {
        let centerCoordinate = CLLocationCoordinate2D(latitude: 37.7666, longitude: -122.427290)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}

import Combine

// keep track of properties that your view needs to render
class MapSearchViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var annotations = [MKPointAnnotation]()
    @Published var isSearching = false
    @Published var searchQuery = ""
    
    @Published var mapItems = [MKMapItem]()
    
    @Published var selectedMapItem: MKMapItem?
    @Published var keyboardHeight: CGFloat = 0
    
    @Published var currentLocation = CLLocationCoordinate2D(latitude: 37.7666, longitude: -122.427290)
    
    var cancellable: AnyCancellable?
    
    let locationManager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let firstLocation = locations.first else { return }
        self.currentLocation = firstLocation.coordinate
    }
    
    override init() {
        super.init()
        // combine code
        cancellable = $searchQuery.debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] (searchTerm) in
                self?.performSearch(query: searchTerm)
        }
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        listenForKeyboardNotifications()
    }
    
    fileprivate func listenForKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { [weak self] (notification) in
            guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            let keyboardFrame = value.cgRectValue
            let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
            
            withAnimation(.easeOut(duration: 0.25)) {
                self?.keyboardHeight = keyboardFrame.height - (window?.safeAreaInsets.bottom ?? 0)
            }
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { [weak self] (notification) in
            withAnimation(.easeOut(duration: 0.25)) {
                self?.keyboardHeight = 0
            }
        }
    }
    
    fileprivate func performSearch(query: String) {
        self.isSearching = true
        
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
            
            self.mapItems = resp?.mapItems ?? []
            
            var airportAnnotations = [MKPointAnnotation]()
            
            resp?.mapItems.forEach({ (mapItem) in
                let annotation = MKPointAnnotation()
                annotation.title = mapItem.name
                annotation.coordinate = mapItem.placemark.coordinate
                airportAnnotations.append(annotation)
            })
            
//            Thread.sleep(forTimeInterval: 1)
            self.isSearching = false
            
            self.annotations = airportAnnotations
        }
    }
    
    fileprivate func setupRegionForLocalSearch() -> MKCoordinateRegion {
        let centerCoordinate = CLLocationCoordinate2D(latitude: 37.7666, longitude: -122.427290)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        return region
    }

}

struct MapSearchingView: View {
    
    @ObservedObject var vm = MapSearchViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            MapViewContainer(annotations: vm.annotations, selectedMapItem: vm.selectedMapItem, currentLocation: vm.currentLocation)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
                HStack {
                    TextField("Search terms", text: $vm.searchQuery)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.white)
                    
                }.padding()
                
                if vm.isSearching {
                    Text("Searching...")
                }
                
                Spacer()
                
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        ForEach(vm.mapItems, id: \.self) { item in
                            
                            Button(action: {
                                self.vm.selectedMapItem = item
                                
                            }, label: {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.name ?? "")
                                        .font(.headline)
                                    Text(item.placemark.title ?? "")
                                }
                            }).foregroundColor(.black)
                            
                            .padding()
                            .frame(width: 200)
                            .background(Color.white)
                            .cornerRadius(5)
                        }
                        
                    }
                    .padding(.horizontal, 16)
                }.shadow(radius: 5)
                
                Spacer().frame(height: vm.keyboardHeight)
            }
        }
    }
    
}

struct MapSearchingView_Previews: PreviewProvider {
    static var previews: some View {
        MapSearchingView()
    }
}
