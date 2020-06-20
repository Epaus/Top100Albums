//
//  DetailViewController.swift
//  Top100Albums
//
//  Created by Estelle Paus on 6/19/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    lazy var imageView: UIImageView = {
        var iView = UIImageView()
        return iView
    }()
    
    lazy var copyrightLabel: UILabel = {
        var label = UILabel()
        return label
    }()
    
    lazy var albumNameLabel: UILabel = {
        var label = UILabel()
        return label
    }()
    
    lazy var artistNameLabel: UILabel = {
        var label = UILabel()
        return label
    }()
    
    lazy var releaseDateLabel: UILabel = {
        var label = UILabel()
        return label
    }()
    
    lazy var genresLabel: UILabel = {
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
        configureImage()
        configureCopyright()
        configureAlbumNameLabel()
        configureArtistNameLabel()
        configureGenreLabel()
        configureReleaseDateLabel()
        
        
        
        
    }
    
    func configureImage() {
        imageView = UIImageView()
        self.view.addSubview(imageView)
        imageView.getImage(name: model.artworkUrl100 ?? "")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant:UIElementSizes.navBarHeight/2),
            imageView.widthAnchor.constraint(equalToConstant:self.view.frame.size.width * 0.67),
            imageView.heightAnchor.constraint(equalToConstant:self.view.frame.size.width * 0.67),
            imageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    func configureCopyright() {
        
        copyrightLabel = UIViewController.createLabel(label: copyrightLabel, text: model.copyright ?? "",
                                                      font:  UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.systemFont(ofSize: 18, weight: .regular)),
                                                      adjustFontSize: true,
                                                      textAlignment: .center,
                                                      numberOfLines: 0,
                                                      lineBreakMode: .byWordWrapping)
        self.view.addSubview(copyrightLabel)
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            copyrightLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -10),
            copyrightLabel.widthAnchor.constraint(equalToConstant:self.view.frame.size.width * 0.90),
            copyrightLabel.heightAnchor.constraint(equalToConstant: 100.0),
            copyrightLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    func configureAlbumNameLabel() {
        albumNameLabel = UIViewController.createLabel(label: albumNameLabel, text: model.name ?? "", font:UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont.systemFont(ofSize: 26, weight: .heavy)),
        adjustFontSize: true,
        textAlignment: .center,
        numberOfLines: 0,
        lineBreakMode: .byWordWrapping)
        self.view.addSubview(albumNameLabel)
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                   albumNameLabel.topAnchor.constraint(equalTo: copyrightLabel.bottomAnchor, constant:10),
                   albumNameLabel.widthAnchor.constraint(equalToConstant:self.view.frame.size.width * 0.90),
                   albumNameLabel.heightAnchor.constraint(equalToConstant: 40.0),
                   albumNameLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
               ])
        
    }
    
    func configureArtistNameLabel() {
        
        let artistLabel = UIViewController.createLabel(label: UILabel(), text: "Artist:", font:UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont.systemFont(ofSize: 20, weight: .heavy)),
        adjustFontSize: true,
        textAlignment: .center,
        numberOfLines: 0,
        lineBreakMode: .byWordWrapping)
        self.view.addSubview(artistLabel)
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
                  NSLayoutConstraint.activate([
                             artistLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant:20),
                             artistLabel.widthAnchor.constraint(equalToConstant:self.view.frame.size.width * 0.90),
                             artistLabel.heightAnchor.constraint(equalToConstant: 20.0),
                             artistLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                         ])
        
        
        artistNameLabel = UIViewController.createLabel(label: artistNameLabel, text: model.artistName ?? "", font:UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: UIFont.systemFont(ofSize: 18, weight: .regular)),
           adjustFontSize: true,
           textAlignment: .center,
           numberOfLines: 0,
           lineBreakMode: .byWordWrapping)
           self.view.addSubview(artistNameLabel)
           artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
                      artistNameLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant:0),
                      artistNameLabel.widthAnchor.constraint(equalToConstant:self.view.frame.size.width * 0.90),
                      artistNameLabel.heightAnchor.constraint(equalToConstant: 40.0),
                      artistNameLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                  ])
           
       }
    
    func configureGenreLabel() {
        let genreLabel = UIViewController.createLabel(label: UILabel(), text: "Genre:", font:UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont.systemFont(ofSize: 20, weight: .heavy)),
               adjustFontSize: true,
               textAlignment: .center,
               numberOfLines: 0,
               lineBreakMode: .byWordWrapping)
               self.view.addSubview(genreLabel)
               genreLabel.translatesAutoresizingMaskIntoConstraints = false
                         NSLayoutConstraint.activate([
                                    genreLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant:20),
                                    genreLabel.widthAnchor.constraint(equalToConstant:self.view.frame.size.width * 0.90),
                                    genreLabel.heightAnchor.constraint(equalToConstant: 20.0),
                                    genreLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                ])
               
        
        let genreString = model.genreStringArray.joined(separator: ", ")
        genresLabel = UIViewController.createLabel(label: genresLabel, text: genreString , font:UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: UIFont.systemFont(ofSize: 18, weight: .regular)),
                                                  adjustFontSize: true,
                                                  textAlignment: .center,
                                                  numberOfLines: 0,
                                                  lineBreakMode: .byWordWrapping)
        self.view.addSubview(genresLabel)
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genresLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant:0),
            genresLabel.widthAnchor.constraint(equalToConstant:self.view.frame.size.width * 0.90),
            genresLabel.heightAnchor.constraint(equalToConstant: 60.0),
            genresLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
        ])
        
    }
    
    func configureReleaseDateLabel() {
     
     let releaseLabel = UIViewController.createLabel(label: UILabel(), text: "Release Date:", font:UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont.systemFont(ofSize: 20, weight: .heavy)),
     adjustFontSize: true,
     textAlignment: .center,
     numberOfLines: 0,
     lineBreakMode: .byWordWrapping)
     self.view.addSubview(releaseLabel)
     releaseLabel.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                          releaseLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant:20),
                          releaseLabel.widthAnchor.constraint(equalToConstant:self.view.frame.size.width * 0.90),
                          releaseLabel.heightAnchor.constraint(equalToConstant: 20.0),
                          releaseLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
                      ])
     
     
     let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = "MMM d, yyyy"
     let releaseDateString = dateFormatter.string(from: model.releaseDate ?? Date())
     releaseDateLabel = UIViewController.createLabel(label: releaseDateLabel, text: releaseDateString, font:UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: UIFont.systemFont(ofSize: 18, weight: .regular)),
        adjustFontSize: true,
        textAlignment: .center,
        numberOfLines: 0,
        lineBreakMode: .byWordWrapping)
        self.view.addSubview(releaseDateLabel)
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                   releaseDateLabel.topAnchor.constraint(equalTo: releaseLabel.bottomAnchor, constant:0),
                   releaseDateLabel.widthAnchor.constraint(equalToConstant:self.view.frame.size.width * 0.90),
                   releaseDateLabel.heightAnchor.constraint(equalToConstant: 40.0),
                   releaseDateLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
               ])
        
    }
    
}
