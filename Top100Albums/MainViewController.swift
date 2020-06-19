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
    
//    override func viewWillLayoutSubviews() {
//        setupNavigationBar()
//        setupTableView()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.showActivityIndicator(uiView: self.view)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTable), name:.ModelListUpdatedNotification, object: nil)
        getData()
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
        let title = "TOP 100 ALBUMS"
        let navigationBar = UINavigationBar(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:100))
//        configureNavigationBar(largeTitleColor: .white, backgoundColor: .systemPink, tintColor: .blue, title: "TOP 100 ALBUMS", preferredLargeTitle: true, navigationBar: navigationBar)
       if #available(iOS 13.0, *) {
           let navBarAppearance = UINavigationBarAppearance()
           navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = .systemPink

           navigationBar.standardAppearance = navBarAppearance
           navigationBar.compactAppearance = navBarAppearance
           navigationBar.scrollEdgeAppearance = navBarAppearance

           navigationBar.prefersLargeTitles = true
           navigationBar.isTranslucent = false
        navigationBar.tintColor = .blue
           navigationItem.title = title
           navigationBar.items = [navigationItem]

       } else {
           // Fallback on earlier versions
        navigationController?.navigationBar.barTintColor = .systemPink
        navigationController?.navigationBar.tintColor = .blue
           navigationController?.navigationBar.isTranslucent = false
           navigationItem.title = title
       }
        self.view.addSubview(navigationBar)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 50
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
               // let alert = self.createAlertController(title: "No Images Found", message: "No images match your search. \nPlease try again.")
               // self.present(alert, animated: true, completion: nil)
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
        return albums.count ?? 0
    }
    

}
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let model = albums[indexPath.row]
        
        cell.selectionStyle = .none
        cell.textLabel?.text = model.artistName ?? "not found"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let model = self.model else { return }
//        let askFor = model.currentCategory?.askFors?[indexPath.row] as? AskFor
//        let suggestionModel = SuggestionModel.init(managedContext: model.managedContext)
//        suggestionModel.currentAskFor = askFor
//        suggestionModel.managedContext = model.managedContext
//        let vc = SuggestionController()
//        vc.model = suggestionModel
//
//        navigationController?.pushViewController(vc, animated: true)
    }
}

