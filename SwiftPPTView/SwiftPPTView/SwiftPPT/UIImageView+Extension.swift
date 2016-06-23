//
//  UIImageView+Extension.swift
//  GTQImageScrollView
//
//  Created by 光头强 on 16/6/22.
//  Copyright © 2016年 Ls. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    func imageWithUrl(url: String, placeholderImage: UIImage?) {
            sd_setImageWithURL(NSURL(string: url), placeholderImage: placeholderImage, options: SDWebImageOptions.ProgressiveDownload, completed: nil)
    }
}
