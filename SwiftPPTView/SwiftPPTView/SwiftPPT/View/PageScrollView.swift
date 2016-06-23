//
//  PageScrollView.swift
//  SwiftPPTView
//
//  Created by 光头强 on 16/6/23.
//  Copyright © 2016年 Ls. All rights reserved.
//

import UIKit

class PageScrollView: UIScrollView, UIScrollViewDelegate {
    var type: SwiftPPTViewType?
    
    ///  数据源
    var dataModels: [DataModel]? {
        didSet {
            if timer != nil {//停止定时器
                timer!.invalidate()
                timer = nil
            }
            
            updatePageScrollView()
            
            startTimer()
        }
    }
    
    ///创建3个imageview
    private let imageViewCount: Int = 3
    
    var timer: NSTimer?
    /// 指定默认图片
    private var holderImage: UIImage! = nil
    
    /// 图片数量
    lazy var pageCount: Int = {self.dataModels!.count}()
    /// 当前页码
    var currentPage: Int = 0 {
        didSet{
            if(currentPage < 0){currentPage = self.pageCount - 1}
            
            if(currentPage >= self.pageCount) {currentPage = 0}
            
            if(self.currentPage != oldValue && self.pageCount != 0){
                //执行页码回调
                self.scrollViewPageChangedClosure?(currentPage: currentPage)
            }
        }
    }

    
    /// 点击图片闭包回调
    var clickImageV:((index: Int, dataModel: DataModel) -> Void)?
    /// 图片页码改变闭包
    var scrollViewPageChangedClosure:((currentPage: Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        pagingEnabled = true //开启分页
        showsHorizontalScrollIndicator = false //隐藏水平条
        delegate = self
        contentSize = CGSizeMake(CGFloat(imageViewCount) * bounds.size.width, 0)
        
        // 添加子视图
        setupView()
    }

    /**
     创建子视图
     */
    private func setupView() {
        for _ in 0..<imageViewCount {
            let imageView = UIImageView()
            imageView.contentMode = UIViewContentMode.ScaleAspectFill
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapImageV:"))
            addSubview(imageView)
            imageViewArray.append(imageView)
        }
    }
    
    /**  图片控件  */
    lazy var imageViewArray: [UIImageView] = Array()
    override func layoutSubviews() {
        var frame = self.bounds
        var index = 0
        for imageV in imageViewArray{
            frame.origin.x = CGFloat(index) * self.bounds.size.width
            imageV.frame = frame
            index++
        }
    }
    
    //MARK: - 图片点击事件
    func tapImageV(sender: UITapGestureRecognizer) {
        let index = self.currentPage
        let dataModel = self.dataModels![index]
        
        if clickImageV == nil {return}
        
        clickImageV!(index: index, dataModel: dataModel)
    }

    
    //MARK: 更新内容
    private func updatePageScrollView() {
        for var i = 0; i < imageViewArray.count; i++ {
            let imageView = imageViewArray[i] 
            var index = currentPage
            
            if i == 0 {
                index--
            } else if 2 == i {
                index++
            }
            
            if index < 0 {
                index = pageCount - 1
            } else if index >= pageCount {
                index = 0
            }
            
            imageView.tag = index
            
            if .Local == self.type {
                imageView.image = dataModels![index].localImage
            } else {
                // 自己指定默认图
                holderImage = dataModels![index].placeholderImage
                
                imageView.imageWithUrl(dataModels![index].networkImageUrl!, placeholderImage: holderImage)
            }
        }
        
        contentOffset = CGPointMake(bounds.size.width, 0)
    }
    
    // MARK: Timer
    private func startTimer() {
        timer = NSTimer(timeInterval: 2.0, target: self, selector: "next", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func next() {
        setContentOffset(CGPointMake(2.0 * frame.size.width, 0), animated: true)
    }

    // MARK:- UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var page: Int = 0
        var minDistance: CGFloat = CGFloat(MAXFLOAT)
        for i in 0..<imageViewArray.count {
            let imageView = imageViewArray[i]
            let distance:CGFloat = abs(imageView.frame.origin.x - scrollView.contentOffset.x)
            
            if distance < minDistance {
                minDistance = distance
                page = imageView.tag
            }
        }
        currentPage = page
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        updatePageScrollView()
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        updatePageScrollView()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
