//
//  MainViewController.swift
//  Top100Bare
//
//  Created by Estelle Paus on 6/17/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import UIKit


class MainViewController: UIViewController, UINavigationBarDelegate {
    var networkManager: NetworkManager?
    var albums = [AlbumModel]()
    
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
        self.networkManager = networkManager
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .tertiarySystemBackground
        activityIndicator.showActivityIndicator(uiView: self.view)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTable), name:.ModelListUpdatedNotification, object: nil)
        setupNavigationBar()
        setupTableView()
    }
    
    func getData() {
        if networkManager == nil {
            self.networkManager = NetworkManager()
        }
        if let nManager = self.networkManager {
            if nManager.models.count == 0 {
                //activityIndicator.showActivityIndicator(uiView: self.view)
                nManager.makeRequest {
                    DispatchQueue.main.async(execute: {
                        print("in completion block")
                        self.albums = nManager.models
                        self.tableView.reloadData()
                        self.activityIndicator.hideActivityIndicator()
                    })
                }
            }
        }
    }
    
    func setupNavigationBar() {
        let navigationBar = UINavigationBar(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:UIElementSizes.navBarHeight))
        configureNavigationBar(largeTitleColor: .white, backgoundColor: .systemPink, tintColor: .blue, title: ConstantText.listTitle, preferredLargeTitle: true, navigationBar: navigationBar)
        self.view.addSubview(navigationBar)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ConstantText.cellId)
        tableView.estimatedRowHeight = 100
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant:UIElementSizes.navBarHeight),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc func updateTable(notification: Notification) {
        albums = notification.object as! [AlbumModel]
        
        DispatchQueue.main.async {
            if self.albums.count == 0 {
                guard let nManager = self.networkManager else { return }
                self.albums = nManager.models
            }
            self.tableView.reloadData()
            self.activityIndicator.hideActivityIndicator()
        }
    }
    
}
// MARK: UITableviewDataSource, UITableViewDelegate extension
extension MainViewController: UITableViewDataSource {
    // MARK: - TableViewDataSource functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count 
    }
    

}
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let model = albums[indexPath.row]
        let acell: ListTableViewCell = {
            return ListTableViewCell.init(style: .default, reuseIdentifier: ConstantText.cellId, model: model)
        }()
        acell.thumbnailImageView.getImage(name: model.artworkUrl100 ?? "")
        
        return acell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

