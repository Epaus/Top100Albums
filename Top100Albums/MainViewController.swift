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
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    
    var topbarHeight: CGFloat = 0
   
    var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        return tableView
    }()
    
// MARK: - Lifecycle
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
        
         NotificationCenter.default.addObserver(self, selector: #selector(updateTable), name:.ModelListUpdatedNotification, object: nil)
        
        
       // setupNavigationBar()
       
        self.topbarHeight = (self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) + 60
        setupTableView()
        configureActivityIndicator()
        activityIndicator.startAnimating()
       
      
        self.view.backgroundColor = .tertiarySystemBackground
    }
    
// MARK: - Update Table
    func getData() {
        if networkManager == nil {
            self.networkManager = NetworkManager()
        }
        if let nManager = self.networkManager {
            if nManager.models.count == 0 && nManager.running == false {
               
                print("running status1 = \(nManager.running)")
                nManager.makeRequest {
                    print("running status2 = \(nManager.running)")
                    DispatchQueue.main.async(execute: {
                        print("in completion block from MainViewController")
                        self.albums = nManager.models
                         //self.hideActivityIndicator()
                        self.tableView.reloadData()
                       
                    })
                }
            }
        }
    }
    
    @objc func updateTable(notification: Notification) {
          //self.hideActivityIndicator()
          guard let tAlbums = notification.object as? [AlbumModel] else { return }
          self.albums = tAlbums
          DispatchQueue.main.async {
              if self.albums.count == 0 {
                  guard let nManager = self.networkManager else { return }
                  self.albums = nManager.models
              }
              self.tableView.reloadData()
              self.hideActivityIndicator()
          }
      }
    
// MARK: - Configure Views
    
    func setupNavigationBar() {
        let navigationBar = UINavigationBar(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:UIElementSizes.navBarHeight))
        configureNavigationBar(largeTitleColor: .white, backgoundColor: .systemPink, tintColor: .blue, title: ConstantText.listTitle, preferredLargeTitle: true, navigationBar: navigationBar)
        //self.view.addSubview(navigationBar)
        print(navigationBar.frame.height)
        
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ConstantText.cellId)
        tableView.estimatedRowHeight = 100
        tableView.contentInset = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant:self.topbarHeight),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
  
    
    func configureActivityIndicator() {

        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        activityIndicator.color = .systemRed
        self.view.addSubview(activityIndicator)
                  
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

                   activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                   activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
               ])
        
    }
    
    // MARK: - Activity Indicator
           func start() {
     
               DispatchQueue.main.async {
                   self.activityIndicator.startAnimating()
               }
           }
               
           func hideActivityIndicator() {
                   DispatchQueue.main.async {
                       
                       self.activityIndicator.stopAnimating()
                   }
               }

    
}

// MARK: - TableViewDataSource functions
extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count 
    }
    

}
// MARK: - TableViewDelegate functions
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let model = albums[indexPath.row]
        let acell = ListTableViewCell.init(style: .subtitle, reuseIdentifier: ConstantText.cellId, model: model)
        acell.textLabel?.text = model.name
        acell.detailTextLabel?.text = model.artistName
        acell.thumbnailImageView.getImage(name: model.artworkUrl100 ?? "")
        
        return acell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = albums[indexPath.row]
        let vc = DetailViewController(model: model)
        if let navController = self.navigationController {
            print("aha")
        } else {
            print("fuck you")
        }
        //self.present(vc, animated: true, completion: nil)
       
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 32
    }
}

