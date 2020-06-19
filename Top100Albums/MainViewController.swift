//
//  MainViewController.swift
//  Top100Bare
//
//  Created by Estelle Paus on 6/17/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
    var networkManager: NetworkManager?
    var albums: [AlbumModel]?
    
   
    var activityIndicator = ActivityIndicatorView()
    
    var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        return tableView
    }()
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
     init(frame: CGRect, networkManager: NetworkManager) {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .red
        self.view.tintColor = .green
        self.networkManager = networkManager
    }
    
    required init?(coder: NSCoder) {
       super.init(nibName: nil, bundle: nil)
       print("ugh")
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        guard let nManager = networkManager else { return }
        if nManager.models.count == 0 {
            activityIndicator.showActivityIndicator(uiView: self.view)
            nManager.makeRequest {
                      print("in viewWillAppear - completed request")
                      albums = nManager.models
                      activityIndicator.hideActivityIndicator()
                  }
        } else {
            albums = nManager.models
        }
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //activityIndicator.showActivityIndicator(uiView: self.view)
      
        setupNavigationBar()
        setupTableView()
        
    }
    
    func setupNavigationBar() {
//        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIElementSizes.screenWidth, height: UIElementSizes.navBarHeight))
//
//        self.view.addSubview(navBar);
        self.navigationController?.title = "TOP 100 ALBUMS"
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 50
        self.view.addSubview(tableView)
        self.setConstraints()
    }
    
    func setConstraints() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIElementSizes.navBarHeight),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    
}
// MARK: UITableviewDataSource, UITableViewDelegate extension
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

