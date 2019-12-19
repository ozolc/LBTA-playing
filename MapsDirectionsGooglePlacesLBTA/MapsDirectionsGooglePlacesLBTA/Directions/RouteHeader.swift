//
//  RouteHeader.swift
//  MapsDirectionsGooglePlacesLBTA
//
//  Created by Maksim Nosov on 19.12.2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import SwiftUI

//struct RouteHeader: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

class RouteHeader: UICollectionReusableView {
    
    let nameLabel = UILabel(text: "Route Name", font: .systemFont(ofSize: 16))
    let distanceLabel = UILabel(text: "Distance", font: .systemFont(ofSize: 16))
    let estimatedTimeLabel = UILabel(text: "Est time...", font: .systemFont(ofSize: 16))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        hstack(stack(nameLabel,
                     distanceLabel,
                     estimatedTimeLabel,
                     spacing: 8),
               alignment: .center)
            .withMargins(.allSides(16))
        
        nameLabel.attributedText = generateAttributedString(title: "Route", description: "US 101S")
        distanceLabel.attributedText = generateAttributedString(title: "Distance", description: "1473m")
    }
    
    func generateAttributedString(title: String, description: String) -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: title + ": ", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        attributedString.append(.init(string: description, attributes: [.font: UIFont.systemFont(ofSize: 16)]))
        return attributedString
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct RouteHeader_Previews: PreviewProvider {
    static var previews: some View {
        Container()
    }
    
    struct Container: UIViewRepresentable {
        
        func makeUIView(context: UIViewRepresentableContext<RouteHeader_Previews.Container>) -> UIView {
            RouteHeader()
        }
        
        func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<RouteHeader_Previews.Container>) {
            
        }
    }
}
