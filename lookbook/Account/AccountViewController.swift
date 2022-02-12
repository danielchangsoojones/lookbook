//
//  AccountViewController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/8/22.
//

import UIKit

class AccountViewController: UIViewController {
    private var tableView: UITableView!
    private var rows: [String] = ["Log Out", "Contact Us"]
    private var messageHelper: MessageHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageHelper = MessageHelper(currentVC: self)
        checkIfInfluencer()
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
    
    private func checkIfInfluencer() {
        if User.current()?.influencer != nil {
            rows.append("Add Payout Info")
        }
    }
}

extension AccountViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: AccountTableViewCell.self)
        let accountsRowLabel = rows[indexPath.row]
        cell.set(rowLabel: accountsRowLabel)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let accountsRowLabel = rows[indexPath.row]
        if accountsRowLabel == "Log Out" {
            logOut()
        } else if (accountsRowLabel == "Contact Us") {
            let customerServicePhone = "3176905323"
            self.messageHelper?.text(customerServicePhone, body: "[Ohana] Help! I'm having issues.")
        } else {
            let customerServicePhone = "3176905323"
            self.messageHelper?.text(customerServicePhone, body: "[Ohana] I'm an influencer and I need to add my payout info. Could you help me?")
        }
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
