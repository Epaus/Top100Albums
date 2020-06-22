//
//  UIViewController.swift
//  Top100Albums
//
//  Created by Estelle Paus on 6/19/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//
import UIKit

extension UIViewController {
    
// MARK: - Create UIElements

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

    static func createLabel(label: UILabel, text: String, font: UIFont, adjustFontSize: Bool, textAlignment: NSTextAlignment, numberOfLines: Int, lineBreakMode: NSLineBreakMode) -> UILabel {
        
        label.text = text
        label.font = font
        label.adjustsFontSizeToFitWidth = adjustFontSize
        label.textAlignment = textAlignment
        label.numberOfLines = numberOfLines
        label.lineBreakMode = lineBreakMode
        label.sizeToFit()
        return label
    }
    
    static func createUIStackView( axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, alignment: UIStackView.Alignment, spacing: CGFloat ) -> UIStackView {
           let sView = UIStackView()
           sView.axis = axis
           sView.distribution =  .equalSpacing
           sView.alignment = alignment //UIStackView.Alignment.center
           sView.spacing = spacing
           sView.translatesAutoresizingMaskIntoConstraints = false
           return sView
       }
    
    static func createButton(button: UIButton, text: String, font: UIFont, titleColor: UIColor = .white, backgroundColor: UIColor = .clear, borderWidth: CGFloat = 0, borderColor: UIColor = .clear, cornerRadius: CGFloat = 5, textAlignment: NSTextAlignment) -> UIButton {
        
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = font
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = textAlignment
        button.titleLabel?.adjustsFontSizeToFitWidth = true
       
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = borderColor.cgColor
        button.layer.cornerRadius = cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    static func createBlurViewWithActivityIndicator( blurView: inout UIView, centerView: CGPoint ) -> UIView {
    
        let blurEffect = UIBlurEffect(style: .prominent)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = .zero
        blurView.isUserInteractionEnabled = false
        blurView.translatesAutoresizingMaskIntoConstraints = false
      
        return blurView
    }
    
}
