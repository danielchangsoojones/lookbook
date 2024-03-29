//
//  ExploreViewController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit

class ExploreViewController: UIViewController {
    var tableView: UITableView!
    private var influencers: [InfluencerParse] = []
    private let dataStore = ExploreDataStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        let exploreView = ExploreView(frame: self.view.frame)
        self.view = exploreView
        self.tableView = exploreView.tableView
        setup(exploreView.tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        loadInfluencers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setup(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: InfluencerTableViewCell.self)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    private func loadInfluencers() {
        dataStore.getAllInfluencers { (influencers) in
            self.influencers = influencers
            self.tableView.reloadData()
        }
    }
}

extension ExploreViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return influencers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: InfluencerTableViewCell.self)
        let influencer = influencers[indexPath.row]
        cell.selectionStyle = .none
        cell.startChattingAction = {
            self.dataStore.createChatRoom(influencerObjectId: influencer.objectId ?? "") { success in
                //TODO: disable button + add spinner
                if success {
                    //TODO: enable button + stop timer
                    if let currentUser = User.current() {
                        let isUserFan = currentUser.influencer == nil ? true : false
                        //only fans can see the ExploreVC
                        if isUserFan {
                            self.pushVC(ChatViewController(influencer: influencer, fan: currentUser))
                        }
                    }
                }
            }
        }
        cell.set(imageFile: influencer.user.profilePhoto,
                 name: influencer.user.name ?? "",
                 messageCount: "5K")
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
