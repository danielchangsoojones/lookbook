//
//  AccountViewController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/8/22.
//

import UIKit

class AccountViewController: UIViewController {
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        let accountView = AccountView(frame: self.view.frame)
        self.view = accountView
        self.tableView = accountView.tableView
        setup(accountView.tableView)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func setup(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: AccountTableViewCell.self)
    }
}

extension AccountViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: AccountTableViewCell.self)
         return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: add button actions for each row on Accounts page
        logOut()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    private func logOut() {
        User.logOut()
        let welcomeVC = WelcomeViewController()
        let navController = UINavigationController(rootViewController: welcomeVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: false, completion: nil)
    }
}
