//
//  DirectionsSearchView.swift
//  MapsDirectionsGooglePlacesLBTA
//
//  Created by Maksim Nosov on 27.12.2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import SwiftUI
import MapKit

struct DirectionsMapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    func makeUIView(context: UIViewRepresentableContext<DirectionsMapView>) -> DirectionsMapView.UIViewType {
        MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<DirectionsMapView>) {
        
    }
}

struct SelectLocationView: View {
    
    @EnvironmentObject var env: DirectionsEnvironment
    
    // here is the magic
//    @Binding var isShowing: Bool
    @State var mapItems = [MKMapItem]()
    @State var searchQuery = ""
    
    var body: some View {
        VStack {
            
            HStack(spacing: 16) {
                Button(action: {
                    // need to dismiss this view somehow
                    self.env.isSelectingSource = false
                    self.env.isSelectingDestination = false
                }, label: {
                    Image(uiImage: #imageLiteral(resourceName: "back_arrow"))
                }).foregroundColor(.black)
                
                TextField("Enter earch term", text: $searchQuery)
                    .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification)
                        .delay(for: .milliseconds(500),
                               scheduler: RunLoop.main)) { _ in
                                
                                // search
                                let request = MKLocalSearch.Request()
                                request.naturalLanguageQuery = self.searchQuery
                                let search = MKLocalSearch(request: request)
                                search.start { (resp, err) in
                                    // check your err
                                    if let err = err {
                                        print("Failed to search", err)
                                    }
                                    
                                    self.mapItems = resp?.mapItems ?? []
                                }
                                
                }
            }.padding()
            
            if mapItems.count > 0 {
                ScrollView {
                    ForEach (mapItems, id: \.self) { item in
                        Button(action: {
                            if self.env.isSelectingSource {
                                self.env.isSelectingSource = false
                                self.env.sourceSourceMapItem = item
                            } else {
                                self.env.isSelectingDestination = false
                                self.env.destinationMapItem = item
                            }
                        }) {
                            HStack {
                                VStack(alignment: .leading){
                                    Text("\(item.name ?? "")")
                                        .font(.headline)
                                    Text("\(item.address())")
                                }
                                Spacer()
                            }
                            .padding()
                        }.foregroundColor(.black)
                        
                    }
                }
            }
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            
        })
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct DirectionsSearchView: View {
    
    @EnvironmentObject var env: DirectionsEnvironment
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                VStack(spacing: 0) {
                    
                    VStack(spacing: 12) {
                        HStack(spacing: 16) {
                            Image(uiImage: #imageLiteral(resourceName: "start_location_circles")).frame(width: 24)
                            
                            NavigationLink(destination: SelectLocationView(), isActive: $env.isSelectingSource) {
                                
                                HStack {
                                    Text(env.sourceSourceMapItem != nil ? (env.sourceSourceMapItem?.name ?? "") : "Source") // come from Environment object
                                    Spacer()
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(3)
                            }
                            
                        }
                        
                        HStack(spacing: 16) {
                            Image(uiImage: #imageLiteral(resourceName: "annotation_icon")
                                .withRenderingMode(.alwaysTemplate))
                                .foregroundColor(.white)
                                .frame(width: 24)
                            
                            NavigationLink(destination: SelectLocationView(), isActive: $env.isSelectingDestination) {
                                
                                HStack {
                                    Text(env.destinationMapItem != nil ? (env.destinationMapItem?.name ?? "") : "Destination") // come from Environment object
                                    Spacer()
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(3)
                            }
                        }
                    }
                    .padding()
                    .background(Color.blue)
                    
                    DirectionsMapView().edgesIgnoringSafeArea(.bottom)
                }
                
                // status bar cover
                Spacer().frame(
                    width: UIApplication.shared.windows.filter{ $0.isKeyWindow }.first?.frame.width,
                    height: UIApplication.shared.windows.filter{ $0.isKeyWindow }.first?.safeAreaInsets.top)
                    .background(Color.blue)
                    .edgesIgnoringSafeArea(.top)
            }
            .navigationBarTitle("DIRECTIONS")
            .navigationBarHidden(true)
        }
    }
}

// treat your env as the brain of your application
class DirectionsEnvironment: ObservableObject {
    @Published var isSelectingSource = false
    @Published var isSelectingDestination = false
    
    @Published var sourceSourceMapItem: MKMapItem?
    @Published var destinationMapItem: MKMapItem?
}

struct DirectionsSearchView_Previews: PreviewProvider {
    static var env = DirectionsEnvironment()
    
    static var previews: some View {
        DirectionsSearchView().environmentObject(env)
    }
}
