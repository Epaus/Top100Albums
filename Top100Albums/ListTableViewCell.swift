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
    var model: AlbumModel {
        didSet {
            self.textLabel?.text = model.name ?? ""
            self.detailTextLabel?.text = model.artistName ?? ""
        }
    }
    
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
        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            thumbnailImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 80),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
