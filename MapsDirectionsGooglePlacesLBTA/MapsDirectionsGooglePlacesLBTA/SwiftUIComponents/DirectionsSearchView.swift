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
    
    // here is the magic
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack {
            Button(action: {
                
                // need to dismiss this view somehow
                self.isShowing = false
                
            }, label: {
                Text("Dismiss")
            })
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct DirectionsSearchView: View {
    
    @State var isSelectingSource = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                VStack(spacing: 0) {
                    
                    VStack {
                        HStack(spacing: 16) {
                            Image(uiImage: #imageLiteral(resourceName: "start_location_circles")).frame(width: 24)
                            
                            NavigationLink(destination: SelectLocationView(isShowing: $isSelectingSource), isActive: $isSelectingSource) {
                                
                                HStack {
                                    Text("Source")
                                    Spacer()
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(3)
                            }
                            
                        }
                        
                        HStack(spacing: 16) {
                            Image(uiImage: #imageLiteral(resourceName: "annotation_icon").withRenderingMode(.alwaysTemplate))
                                .foregroundColor(.white)
                            HStack {
                                Text("Destination")
                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(3)
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

struct DirectionsSearchView_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsSearchView()
    }
}
