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
    
    lazy var bufferView: UIView = {
        var view = UIView()
        return view
    }()
    
    lazy var buttonStack: UIStackView = {
        var stack = UIStackView()
        return stack
    }()
    
    var model: AlbumModel


// MARK: - Lifecycle
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
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.barTintColor = .systemRed
        self.view.backgroundColor = UIColor.systemGray6
        configureStackView()
        configureScrollView()
    }
    
// MARK: - Configure views
    func configureScrollView() {
        self.view.addSubview(scrollView)
        
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                   scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
                   scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
                   
                   scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: -20),
                   scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 20)
               ])
        
        scrollView.addSubview(stackView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20).isActive = true;
        stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true;
        stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -10).isActive = true;
        stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: 0).isActive = true;
               
        //constrain width of stack view to width of self.view, NOT scroll view
        self.stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true;
    }
    
    func configureStackView() {
        self.stackView = UIViewController.createUIStackView(axis: .vertical, distribution: .fillProportionally, alignment: .center, spacing: 30)
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
        stackView.addArrangedSubview(buttonStack)
       
        NSLayoutConstraint.activate([
            imageStack.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -10),
            buttonStack.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -20),
            buttonStack.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
                   ])
    }
    
    func configureImageStack() {
        imageView.downloadImage(withUrlString: model.artworkUrl100 ?? "")
        copyrightLabel = UIViewController.createLabel(label: copyrightLabel, text: model.copyright ?? "",
        font:  UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.systemFont(ofSize: 17, weight: .regular)),
        adjustFontSize: true,
        textAlignment: .center,
        numberOfLines: 0,
        lineBreakMode: .byWordWrapping)
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        copyrightLabel.accessibilityIdentifier = "copyright"
        imageStack = UIViewController.createUIStackView(axis: .vertical, distribution: .equalCentering, alignment: .center, spacing: 10)
        imageStack.addArrangedSubview(imageView)
        imageStack.addArrangedSubview(copyrightLabel)
        imageStack.translatesAutoresizingMaskIntoConstraints = false
        
        copyrightLabel.widthAnchor.constraint(equalTo: imageStack.widthAnchor, constant: -20).isActive = true;
        
    }
    
    func configureAlbumNameLabel() {
        albumNameLabel = UIViewController.createLabel(label: albumNameLabel, text: model.name ?? "", font:UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont.systemFont(ofSize: 26, weight: .heavy)),
        adjustFontSize: true,
        textAlignment: .center,
        numberOfLines: 0,
        lineBreakMode: .byWordWrapping)
        albumNameLabel.accessibilityIdentifier = "albumName"
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
        artistNameLabel.accessibilityIdentifier = "artistName"

        artistStack = UIViewController.createUIStackView(axis: .vertical, distribution: .fillProportionally, alignment: .center, spacing: 30)
        artistStack.addArrangedSubview(artistLabel)
        artistStack.addArrangedSubview(artistNameLabel)
       }
    
    func configureGenreStack() {
        let genreLabel = UIViewController.createLabel(label: UILabel(), text: "Genre:", font:UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont.systemFont(ofSize: 20, weight: .heavy)),
               adjustFontSize: true,
               textAlignment: .center,
               numberOfLines: 0,
               lineBreakMode: .byWordWrapping)
        
        let genreString = model.genres?.compactMap { $0.name }.joined(separator: ", ") ?? " "
        
        genresLabel = UIViewController.createLabel(label: genresLabel, text: genreString , font:UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: UIFont.systemFont(ofSize: 18, weight: .regular)),
                                                  adjustFontSize: true,
                                                  textAlignment: .center,
                                                  numberOfLines: 0,
                                                  lineBreakMode: .byWordWrapping)
        genresLabel.accessibilityIdentifier = "genres"
        genreStack = UIViewController.createUIStackView(axis: .vertical, distribution: .fillProportionally, alignment: .center, spacing: 30)
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
        releaseLabel.accessibilityIdentifier = "releaseDate"
        
        releaseDateStack = UIViewController.createUIStackView(axis: .vertical, distribution: .fillProportionally, alignment: .center, spacing: 30)
        releaseDateStack.addArrangedSubview(releaseLabel)
        releaseDateStack.addArrangedSubview(releaseDateLabel)
    }
    
    func configureLinkButton() {
       
        let borderWidth: CGFloat = 0.0
        let borderColor = UIColor.clear
        let cornerRadius: CGFloat = 5
        let backgroundColor =  UIColor.systemRed
        linkButton = UIViewController.createButton(button: linkButton, text: "iTunes", font: UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: UIFont.systemFont(ofSize: 18, weight: .regular)), titleColor: .white, backgroundColor: backgroundColor, borderWidth: borderWidth, borderColor: borderColor, cornerRadius: cornerRadius, textAlignment: .center)
        linkButton.addTarget(self, action: #selector(openLink), for: UIControl.Event.touchUpInside)
        linkButton.accessibilityIdentifier = "linkButton"
        bufferView = UIView()
        bufferView.backgroundColor = .clear
        
       
        
        buttonStack = UIViewController.createUIStackView(axis: .vertical, distribution: .fillProportionally, alignment: .center, spacing: 0)
        buttonStack.addArrangedSubview(linkButton)
        buttonStack.addArrangedSubview(bufferView)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        linkButton.translatesAutoresizingMaskIntoConstraints = false
        bufferView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            bufferView.heightAnchor.constraint(equalToConstant: 20),
            bufferView.bottomAnchor.constraint(equalTo:buttonStack.bottomAnchor),
            linkButton.widthAnchor.constraint(equalTo:buttonStack.widthAnchor)
        ])
        
        
    }
 // MARK: - Button Action
    @objc func openLink() {
        guard let linkString = model.url else { return }
        print(linkString)
        if let url = URL(string: linkString) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
}
