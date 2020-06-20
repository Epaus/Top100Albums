//
//  DetailViewController.swift
//  Top100Albums
//
//  Created by Estelle Paus on 6/19/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let sView = UIStackView()
        return sView
    }()
    
    lazy var imageView: UIImageView = {
           var iView = UIImageView()
        iView.alignmentRect(forFrame: CGRect(x:0,y:0, width:self.view.frame.size.width * 0.75,height:self.view.frame.size.width * 0.75))
           return iView
       }()
    
    lazy var imageStack: UIStackView = {
        let stackView = UIStackView()
        return stackView
       }()
    
    lazy var artistStack: UIStackView = {
       let stackView = UIStackView()
        return stackView
    }()
    
    lazy var genreStack: UIStackView = {
        let stackView = UIStackView()
              return stackView
    }()
    
    lazy var releaseDateStack: UIStackView = {
        let stackView = UIStackView()
              return stackView
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
    
    lazy var linkButton: UIButton = {
        var button = UIButton()
        return button
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
        configureStackView()
        configureScrollView()
    }
    
    func configureScrollView() {
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                   scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant:UIElementSizes.navBarHeight),
                   scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                   
                   scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                   scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
               ])
        scrollView.addSubview(stackView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 10).isActive = true;
        stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true;
        stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -10).isActive = true;
        stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -20).isActive = true;
               
        //constrain width of stack view to width of self.view, NOT scroll view
        self.stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -10).isActive = true;
    }
    
    func configureStackView() {
        self.stackView = UIViewController.createUIStackView(axis: .vertical, distribution: .equalCentering, alignment: .center, spacing: 20)
        configureImageStack()
        configureAlbumNameLabel()
        configureArtistStack()
        configureGenreStack()
        configureReleaseDateStack()
        configureLinkButton()
        
        stackView.addArrangedSubview(imageStack)
        stackView.addArrangedSubview(albumNameLabel)
        stackView.addArrangedSubview(artistStack)
        stackView.addArrangedSubview(genreStack)
        stackView.addArrangedSubview(releaseDateStack)
        stackView.addArrangedSubview(linkButton)
    }
    
    func configureImageStack() {
        imageView.getImage(name: model.artworkUrl100 ?? "")
        copyrightLabel = UIViewController.createLabel(label: copyrightLabel, text: model.copyright ?? "",
        font:  UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.systemFont(ofSize: 17, weight: .regular)),
        adjustFontSize: true,
        textAlignment: .center,
        numberOfLines: 0,
        lineBreakMode: .byWordWrapping)
        imageStack = UIViewController.createUIStackView(axis: .vertical, distribution: .equalCentering, alignment: .center, spacing: 10)
        imageStack.addArrangedSubview(imageView)
        imageStack.addArrangedSubview(copyrightLabel)
    }
    
    func configureAlbumNameLabel() {
        albumNameLabel = UIViewController.createLabel(label: albumNameLabel, text: model.name ?? "", font:UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont.systemFont(ofSize: 26, weight: .heavy)),
        adjustFontSize: true,
        textAlignment: .center,
        numberOfLines: 0,
        lineBreakMode: .byWordWrapping)
    }
    
    func configureArtistStack() {
        let artistLabel = UIViewController.createLabel(label: UILabel(), text: "Artist:", font:UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont.systemFont(ofSize: 20, weight: .heavy)),
        adjustFontSize: true,
        textAlignment: .center,
        numberOfLines: 0,
        lineBreakMode: .byWordWrapping)

        artistNameLabel = UIViewController.createLabel(label: artistNameLabel, text: model.artistName ?? "", font:UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: UIFont.systemFont(ofSize: 18, weight: .regular)),
           adjustFontSize: true,
           textAlignment: .center,
           numberOfLines: 0,
           lineBreakMode: .byWordWrapping)

        artistStack = UIViewController.createUIStackView(axis: .vertical, distribution: .equalCentering, alignment: .center, spacing: 10)
        artistStack.addArrangedSubview(artistLabel)
        artistStack.addArrangedSubview(artistNameLabel)
       }
    
    func configureGenreStack() {
        let genreLabel = UIViewController.createLabel(label: UILabel(), text: "Genre:", font:UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont.systemFont(ofSize: 20, weight: .heavy)),
               adjustFontSize: true,
               textAlignment: .center,
               numberOfLines: 0,
               lineBreakMode: .byWordWrapping)
        
        let genreString = model.genreStringArray.joined(separator: ", ")
        genresLabel = UIViewController.createLabel(label: genresLabel, text: genreString , font:UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: UIFont.systemFont(ofSize: 18, weight: .regular)),
                                                  adjustFontSize: true,
                                                  textAlignment: .center,
                                                  numberOfLines: 0,
                                                  lineBreakMode: .byWordWrapping)
       genreStack = UIViewController.createUIStackView(axis: .vertical, distribution: .equalCentering, alignment: .center, spacing: 10)
       genreStack.addArrangedSubview(genreLabel)
       genreStack.addArrangedSubview(genresLabel)
    }
    
    func configureReleaseDateStack() {
     
     let releaseLabel = UIViewController.createLabel(label: UILabel(), text: "Release Date:", font:UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont.systemFont(ofSize: 20, weight: .heavy)),
     adjustFontSize: true,
     textAlignment: .center,
     numberOfLines: 0,
     lineBreakMode: .byWordWrapping)
     
     let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = "MMM d, yyyy"
     let releaseDateString = dateFormatter.string(from: model.releaseDate ?? Date())
     releaseDateLabel = UIViewController.createLabel(label: releaseDateLabel, text: releaseDateString, font:UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: UIFont.systemFont(ofSize: 18, weight: .regular)),
        adjustFontSize: true,
        textAlignment: .center,
        numberOfLines: 0,
        lineBreakMode: .byWordWrapping)
       
        releaseDateStack = UIViewController.createUIStackView(axis: .vertical, distribution: .equalCentering, alignment: .center, spacing: 10)
        releaseDateStack.addArrangedSubview(releaseLabel)
        releaseDateStack.addArrangedSubview(releaseDateLabel)
    }
    
    func configureLinkButton() {
        linkButton = UIViewController.createButton(button: linkButton, text: "iTunes", font: UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: UIFont.systemFont(ofSize: 18, weight: .regular)), titleColor: .white, backgroundColor: .systemRed, borderWidth: 0, borderColor: .clear, cornerRadius: 5.0, textAlignment: .center)
    }
}
