//
//  LocationSearchController.swift
//  MapsDirectionsGooglePlacesLBTA
//
//  Created by Maksim Nosov on 18.12.2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import SwiftUI
import UIKit
import LBTATools
import MapKit

class LocationSearchCell: LBTAListCell<MKMapItem> {
    
    override var item: MKMapItem! {
        didSet {
            nameLabel.text = item.name
            addressLabel.text = item.address()
        }
    }
    
    let nameLabel = UILabel(text: "Name", font: .boldSystemFont(ofSize: 16))
    let addressLabel = UILabel(text: "Address", font: .systemFont(ofSize: 14))
    
    override func setupViews() {
        stack(nameLabel,
              addressLabel).withMargins(.allSides(16))
        
        addSeparatorView(leftPadding: 16)
    }
}

class LocationSearchController: LBTAListController<LocationSearchCell, MKMapItem> {
    
    var selectionHandler: ((MKMapItem) -> ())?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.popViewController(animated: true)
        let mapItem = self.items[indexPath.item]
        selectionHandler?(mapItem)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performLocalSearch()
    }
    
    fileprivate func performLocalSearch() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Apple"
        
        let search = MKLocalSearch.init(request: request)
        search.start { (resp, err) in
            // check err
            self.items = resp?.mapItems ?? []
        }
    }
}

extension LocationSearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 70)
    }
}

struct LocationSearchController_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<LocationSearchController_Previews.ContainerView>) -> UIViewController {
            return LocationSearchController()
        }
        
        func updateUIViewController(_ uiViewController: LocationSearchController_Previews.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<LocationSearchController_Previews.ContainerView>) {
            
        }
    }
}
