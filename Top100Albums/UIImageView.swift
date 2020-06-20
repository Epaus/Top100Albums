//
//  UIImageView.swift
//  Top100Albums
//
//  Created by Estelle Paus on 6/18/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import UIKit
import os.log

extension UIImageView {
    
    func getImage(name: String)  {
        guard let request = URL(string: name) else { return }
        URLSession.shared.dataTask(with: request, completionHandler:  { (data, response, error)  in
            if error != nil {
                guard let tError = error else { return }
                os_log("ERROR: %@", tError.localizedDescription )
                return
            }
            DispatchQueue.main.async(execute: {
                guard let tData = data else { return }
                let image = UIImage(data: tData)
                self.image = image
                NotificationCenter.default.post(name: Notification.Name.ImageViewSetNotification, object: nil )
            })
        }).resume()
    }
}
