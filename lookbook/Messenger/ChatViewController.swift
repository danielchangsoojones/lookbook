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
        collectionView.backgroundColor = .white
        collectionView.reloadData()
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
        collectionView.register(cellType: ChatTextCollectionCell.self)
        view.addSubview(collectionView)
    }
}

extension ChatViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                         cellType: ChatTextCollectionCell.self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width,
                      height: 100)
    }
}
