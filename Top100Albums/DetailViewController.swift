//
//  DetailViewController.swift
//  Top100Albums
//
//  Created by Estelle Paus on 6/19/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    lazy var imageView : UIImageView = {
        var iView = UIImageView()
        return iView
    }()
    lazy var copyrightLabel : UILabel = {
        var label = UILabel()
        return label
    }()
    var model: AlbumModel
    
    init(model: AlbumModel) {
         self.model = model
         super.init(nibName: nil, bundle: nil)
     }
     
     init(frame: CGRect, model: AlbumModel) {
         self.model = model
         super.init(nibName: nil, bundle: nil)
        
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.backgroundColor = UIColor.systemGray6
        self.view.addSubview(imageView)
        imageView.getImage(name: model.artworkUrl100 ?? "")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant:UIElementSizes.navBarHeight),
            imageView.widthAnchor.constraint(equalToConstant:self.view.frame.size.width * 0.67),
            imageView.heightAnchor.constraint(equalToConstant:self.view.frame.size.width * 0.67),
            imageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
        ])
        
        copyrightLabel.text = model.copyright
        copyrightLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.systemFont(ofSize: 18, weight: .regular))
        copyrightLabel.adjustsFontForContentSizeCategory = true
        copyrightLabel.textAlignment = .center
        copyrightLabel.numberOfLines = 0
        copyrightLabel.lineBreakMode = .byWordWrapping
        self.view.addSubview(copyrightLabel)
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            copyrightLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant:0),
            copyrightLabel.widthAnchor.constraint(equalToConstant:self.view.frame.size.width * 0.90),
            copyrightLabel.heightAnchor.constraint(equalToConstant: 100.0),
            copyrightLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
        ])
        
    }
    
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
