//
//  ListTableViewCell.swift
//  Top100Albums
//
//  Created by Estelle Paus on 6/19/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    lazy var thumbnailImageView : UIImageView = {
        var iView = UIImageView()
        return iView
    }()
    var model: AlbumModel
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, model: AlbumModel) {
        self.model = model
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    init(frame: CGRect, model: AlbumModel) {
        self.model = model
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: ConstantText.cellId)
       }
       
       required init?(coder: NSCoder, model: AlbumModel) {
        self.model = model
           super.init(coder: coder)
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        
        self.addSubview(thumbnailImageView)
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel?.translatesAutoresizingMaskIntoConstraints = false
        detailTextLabel?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 90),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 90),
            thumbnailImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
        ])
       
        guard let albumLabel = textLabel else { return }
        albumLabel.font = UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .bold))
        albumLabel.adjustsFontSizeToFitWidth = true
        albumLabel.lineBreakMode = .byWordWrapping
        albumLabel.numberOfLines = 0
    
        
        NSLayoutConstraint.activate([
            albumLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10),
            albumLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            albumLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            
        ])
        
        guard let artistNameLabel = detailTextLabel else { print("where is detailTextLabel?"); return }
        artistNameLabel.font = UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .regular))
        artistNameLabel.adjustsFontSizeToFitWidth = true
        
        NSLayoutConstraint.activate([
            artistNameLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10),
            artistNameLabel.topAnchor.constraint(equalTo: albumLabel.bottomAnchor, constant: 10),
            artistNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
