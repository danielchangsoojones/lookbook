//
//  MessengerViewController.swift
//  lookbook
//
//  Created by Daniel Jones on 2/8/22.
//

import UIKit

class ChatViewController: UIViewController {
    private var messages: [String] = ["hi"]
    private var collectionView: UICollectionView!
    
    override func loadView() {
        super.loadView()
        setupCollectionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    private func setupCollectionView() {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: self.view.frame.width,
                           height: self.view.frame.height)
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ChatViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
