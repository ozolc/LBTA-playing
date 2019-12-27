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

struct DirectionsSearchView: View {
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack(spacing: 0) {
                
                VStack {
                    HStack(spacing: 16) {
                        Image(uiImage: #imageLiteral(resourceName: "start_location_circles")).frame(width: 24)
                        HStack {
                            Text("Source")
                            Spacer()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(3)
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
    }
}

struct DirectionsSearchView_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsSearchView()
    }
}
