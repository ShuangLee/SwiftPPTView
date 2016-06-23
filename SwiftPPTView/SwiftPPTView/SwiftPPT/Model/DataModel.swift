//
//  DataModel.swift
//  GTQImageScrollView
//
//  Created by 光头强 on 16/6/22.
//  Copyright © 2016年 Ls. All rights reserved.
//

import UIKit

class DataModel: NSObject {
    /// 本地图片：本地相册模式
    var localImage: UIImage?
    /// 远程服务器图片地址：网络图片模式
    var networkImageUrl: String?
    /// 占位图片：网络图片模式
    var placeholderImage: UIImage?
    /// 说明文字
    var title: String?
    /// 传入数据模型
    var model: AnyObject?
    
    /**
     本地图片
     - parameter localImage: 本地图片
     - parameter title:      说明文字
     */
    init(localImage: UIImage?, title: String?) {
        self.localImage = localImage
        self.title = title
    }
    
    /**
    从网络获取图片
     - parameter networkImageUrl:  网络图片链接
     - parameter placeHolderImage: 默认占位图片
     - parameter title:            说明文字
     - parameter model:            传入模型
     - returns:
     */
    init(networkImageUrl: String, placeHolderImage: UIImage?, title: String?, model: AnyObject?) {
        self.networkImageUrl = networkImageUrl
        self.placeholderImage = placeHolderImage
        self.title = title
        self.model = model
    }
}
