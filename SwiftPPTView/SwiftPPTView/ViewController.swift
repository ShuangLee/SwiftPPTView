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
            var networkImages = ["http://hbimg.b0.upaiyun.com/9dd4b54a696c885d5e9dc15b4daffc9a7cfa27488297-xR1iKM_fw658","http://hbimg.b0.upaiyun.com/0990ec1206aa465704e558cde2d640197230db8a845f-oZTt6p_fw658","http://hbimg.b0.upaiyun.com/f726eac19335673467eb814e4177b2ae54cc342bd628-xQlgTT_fw658","http://hbimg.b0.upaiyun.com/3fe00337839c73eb3528b633d21f264ea3d593506db7-3dF0Qi_fw658","http://hbimg.b0.upaiyun.com/2fcdecdbcac1fe0cc6617ab969a81f305c1dca2c7671-CNjVrw_fw658"]
            var networkTitleStr = ["网络幻灯:一","网络幻灯:二","网络幻灯:三","网络幻灯:四","网络幻灯:五"]
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
            
            var localTitleStr = ["本地幻灯：一","本地幻灯：二","本地幻灯：三","本地幻灯：四"]
            
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

