//
//  SwiftPPTView.swift
//  SwiftPPTView
//
//  Created by 光头强 on 16/6/23.
//  Copyright © 2016年 Ls. All rights reserved.
//

import UIKit

enum SwiftPPTViewType {
    /// 本地图片
    case Local
    /// 网络图片
    case Network
}

class SwiftPPTView: UIView {
    /// 指示器
    private var pageControl: GTQPageControl?
    /// 滚动视图
    private var scrollView: PageScrollView?
    /// 图片数据源
    private var titleLabel: UILabel?
    /// 展示图片类型
    private var type: SwiftPPTViewType?
    /// 图片数据源
    private var dataModels: [DataModel]?
    
    var clickImageV: ((index: Int, dataModel: DataModel) ->Void)?{
        didSet{
            self.scrollView?.clickImageV = clickImageV
        }
    }
    
    convenience init(type: SwiftPPTViewType, dataModels:() -> [DataModel]?) {
        self.init(frame: CGRectZero)
        
        self.type = type
        
        self.scrollView?.type = type
        
        self.dataModels = dataModels()
        
        /** 数据源赋值 */
        dataModelIsComing()
    }
    
    /**
     数据来了
     */
    private func dataModelIsComing() {
        if (dataModels == nil || dataModels!.count == 0) {return}
        
        //传递数据
        self.scrollView?.dataModels = self.dataModels!;
        
        //总页码
        self.pageControl?.numberOfPages = self.dataModels!.count
        
        //默认第一页
        self.updatePage(page: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    /**
      初始化界面
     */
    private func setupView() {
        // 添加scrollView
        setupScrollView()
        
        // 添加标题Label
        setupTitleLabel()
        
        // 添加指示器
        setupPageControl()
    }

    private func updatePage(page page: Int) {
        if (dataModels!.count == 0) {return}
        
        // 说明文字
        titleLabel?.text = self.dataModels![page].title
        
        pageControl?.currentPage = page
    }
    
    /** 滚动视图 */
    private func setupScrollView() {
        let scrollView = PageScrollView()
        //禁止将autoresizing转化为约束
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView = scrollView
        addSubview(scrollView)
        
        // 约束
        let leftConstraint = NSLayoutConstraint(item: scrollView, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1.0, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: scrollView, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1.0, constant: 0)
        let topConstraint = NSLayoutConstraint(item: scrollView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: scrollView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0)
        self.addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
        
        //事件：页码改变
        scrollView.scrollViewPageChangedClosure = { [unowned self] (currentPage: Int) -> Void in
            self.updatePage(page: currentPage)
        }
    }
    
    /** 指示器 */
    private func setupPageControl() {
        let pageControl = GTQPageControl()
        //禁止将autoresizing转化为约束
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl = pageControl
        addSubview(pageControl)
        
        // 约束
        let leftConstraint = NSLayoutConstraint(item: pageControl, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1.0, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: pageControl, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1.0, constant: 0)
        let topConstraint = NSLayoutConstraint(item: pageControl, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0)
        self.addConstraints([leftConstraint, rightConstraint, topConstraint])
        
        let heightConstraint = NSLayoutConstraint(item: pageControl, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 0.0, constant: 30)
        pageControl.addConstraint(heightConstraint)
    }
    
    /** 标题Label */
    private func setupTitleLabel() {
        let titleLabel = UILabel()
        //禁止将autoresizing转化为约束
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = UIColor.blackColor()
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.whiteColor()
        self.titleLabel = titleLabel
        addSubview(titleLabel)
        
        // 约束
        let leftConstraint = NSLayoutConstraint(item: titleLabel, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1.0, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1.0, constant: 0)
        let topConstraint = NSLayoutConstraint(item: titleLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0)
        self.addConstraints([leftConstraint, rightConstraint, topConstraint])
        
        let heightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 0.0, constant: 30)
        titleLabel.addConstraint(heightConstraint)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
