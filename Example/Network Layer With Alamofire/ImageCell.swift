//
//  ImageCell.swift
//  Network Layer With Alamofire
//
//  Created by Tayyab Ali on 7/25/20.
//  Copyright © 2020 Tayyab Ali. All rights reserved.
//

import UIKit
import SDWebImage

class ImageCell: UITableViewCell {

    @IBOutlet weak var imageIV: UIImageView!
    
    func updateCell(with imageUrl: String) {
        imageIV?.layer.cornerRadius = 10
        setImage(imageView: imageIV, imageUrl: imageUrl, placeholder: "")
    }
    
    func setImage(imageView: UIImageView, imageUrl: String?, placeholder imageName: String) {
        
        if imageUrl == nil {
            imageView.image = UIImage(named: imageName)
            return
        }
        
        guard let  URL = URL(string: imageUrl!) else {
            imageView.image = UIImage(named: imageName)
            return
        }
        
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        imageView.sd_setImage(with: URL, placeholderImage: UIImage(named: ""), options: .progressiveLoad, completed: nil)
    }
}
