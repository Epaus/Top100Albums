//
//  UIViewController.swift
//  Top100Albums
//
//  Created by Estelle Paus on 6/19/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//
import UIKit

extension UIViewController {
    func configureNavigationBar(largeTitleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool, navigationBar: UINavigationBar) {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
            navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
            navBarAppearance.backgroundColor = backgoundColor
            
            navigationBar.standardAppearance = navBarAppearance
            navigationBar.compactAppearance = navBarAppearance
            navigationBar.scrollEdgeAppearance = navBarAppearance
            
            navigationBar.prefersLargeTitles = preferredLargeTitle
            navigationBar.isTranslucent = false
            navigationBar.tintColor = tintColor
            navigationItem.title = title
            navigationBar.items = [navigationItem]
            
        } else {
            // Fallback on earlier versions
            navigationController?.navigationBar.barTintColor = backgoundColor
            navigationController?.navigationBar.tintColor = tintColor
            navigationController?.navigationBar.isTranslucent = false
            navigationItem.title = title
        }
    }
    
    static func createTableView(cellClassesAndIDs: [String: AnyClass], style: UITableView.Style = .plain) -> UITableView {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: style)
        for (id, cellClass) in cellClassesAndIDs {
            tableView.register(cellClass, forCellReuseIdentifier: id)
        }
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }
    
}
