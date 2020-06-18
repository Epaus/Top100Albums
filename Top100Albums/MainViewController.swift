//
//  ViewController.swift
//  Top100Bare
//
//  Created by Estelle Paus on 6/17/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var networkManager: NetworkManager?
    
    
    override func viewWillAppear(_ animated: Bool) {
        guard let nManager = networkManager else { return }
        nManager.performRequest()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

