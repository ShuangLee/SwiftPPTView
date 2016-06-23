//
//  ViewController.swift
//  SwiftPPTView
//
//  Created by 光头强 on 16/6/23.
//  Copyright © 2016年 Ls. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //网络相册：
        let pptView = SwiftPPTView(type: .Network) { () -> [DataModel]? in
            var networkImages = ["http://img.netbian.com/file/2015/0619/e8ffa0a298a4f7374df0e599c4fa134d.jpg"]
            var networkTitleStr = ["网络幻灯:小黄人一","网络幻灯:小黄人二","网络幻灯:小黄人三","网络幻灯:小黄人四","网络幻灯:小黄人五"]
            var dataModels: [DataModel] = Array()
            for i in 0..<networkImages.count {
                let dataModel = DataModel(networkImageUrl: networkImages[i], placeHolderImage: nil, title: networkTitleStr[i],model: nil)
                dataModels.append(dataModel)
            }
            
            return dataModels
        }
        pptView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 160)
        view.addSubview(pptView)
        
        
        
        //创建SwiftPPT
        let pptView1: SwiftPPTView = SwiftPPTView(type: .Local) { () -> [DataModel] in
            
            var localImages = [UIImage(named: "local1"),UIImage(named: "local2"),UIImage(named: "local3"),UIImage(named: "local4")]
            
            var localTitleStr = ["本地幻灯：花千骨剧照一","本地幻灯：花千骨剧照二","本地幻灯：花千骨剧照三","本地幻灯：花千骨剧照四"]
            
            var dataModels: [DataModel] = Array()
            
            for i in 0..<localImages.count {
                
                let dataModel = DataModel(localImage: localImages[i]!, title: localTitleStr[i])
                
                dataModels.append(dataModel)
                
            }
            
            return dataModels
        }
        pptView1.frame = CGRectMake(0, 200, UIScreen.mainScreen().bounds.width, 160)
        
        self.view.addSubview(pptView1)
        
        pptView1.clickImageV = {(index: Int, pptDataModel: DataModel) -> Void in
            
            print(index)
        }

    }

}

