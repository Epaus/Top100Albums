//
//  ActivityIndicatorView.swift
//  Top100Albums
//
//  Created by Estelle Paus on 6/18/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIView {
    var blurView: UIView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    func showActivityIndicator(uiView: UIView) {
        
        let blurEffect = UIBlurEffect(style: .prominent)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = uiView.frame
        blurView.center = uiView.center
        
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.center = uiView.center
        activityIndicator.color = .systemRed
        
        uiView.addSubview(blurView)
        uiView.addSubview(activityIndicator)
        
//        NSLayoutConstraint.activate([
//                   blurView.topAnchor.constraint(equalTo: uiView.topAnchor, constant:UIElementSizes.navBarHeight),
//                   blurView.bottomAnchor.constraint(equalTo: uiView.bottomAnchor),
//                   blurView.leadingAnchor.constraint(equalTo: uiView.leadingAnchor),
//                   blurView.trailingAnchor.constraint(equalTo: uiView.trailingAnchor)
//               ])
//        
//        NSLayoutConstraint.activate([
//                          activityIndicator.heightAnchor.constraint(equalToConstant:100),
//                           activityIndicator.widthAnchor.constraint(equalToConstant:100),
//                           activityIndicator.centerYAnchor.constraint(equalTo: uiView.centerYAnchor),
//                           activityIndicator.centerXAnchor.constraint(equalTo: uiView.centerXAnchor)
//                      ])
       
        start()
    }
    
    func start() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.blurView.removeFromSuperview()
            self.activityIndicator.stopAnimating()
        }
    }
    
}
