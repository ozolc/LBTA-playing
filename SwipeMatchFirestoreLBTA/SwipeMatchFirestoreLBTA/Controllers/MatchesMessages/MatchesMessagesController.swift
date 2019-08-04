//
//  MatchesMessagesController.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Maksim Nosov on 02/08/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import LBTATools
import FirebaseAuth
import FirebaseFirestore

class MatchesMessagesController: LBTAListHeaderController<RecentMessageCell, UIColor, MatchesHeader>, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0 
    }
    
    override func setupHeader(_ header: MatchesHeader) {
        header.matchesHorizontalController.rootMatchesController = self
    }
    
    func didSelectMatchFromHeader(match: Match) {
        let chatLogController = ChatLogController(match: match)
        navigationController?.pushViewController(chatLogController, animated: true)
    }
    
    let customNavBar = MatchesNavBar()
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 250)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = [.red, .blue, .green, .purple]
        
        setupUI()
    }
    
//    fileprivate func fetchMatches() {
//        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
//        Firestore.firestore().collection("matches_messages").document(currentUserId).collection("matches").getDocuments { (querySnapshot, err) in
//            if let err = err {
//                print("Failed to fetch matches", err)
//                return
//            }
//
//            print("Here are my matches documents")
//
//            var matches = [Match]()
//            querySnapshot?.documents.forEach({ (documentSnapshot) in
//                let dictionary = documentSnapshot.data()
//                matches.append(.init(dictionary: dictionary))
//            })
//
//            self.items = matches
//            self.collectionView.reloadData()
//        }
//    }
    
    fileprivate func setupUI() {
        collectionView.backgroundColor = .white
        
        customNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        
        view.addSubview(customNavBar)
        customNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 150))
        collectionView.contentInset.top = 150
        collectionView.scrollIndicatorInsets.top = 150
        
        let statusBarCover = UIView(backgroundColor: .white)
        view.addSubview(statusBarCover)
        statusBarCover.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 130)
    }
    
}
