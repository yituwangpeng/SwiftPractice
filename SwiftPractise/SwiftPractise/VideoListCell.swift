
//
//  VideoListCell.swift
//  SwiftPractise
//
//  Created by 王鹏 on 17/2/8.
//  Copyright © 2017年 王鹏. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class VideoListCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        
        let image: UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height))
        image.backgroundColor = UIColor.blue
        
        return image
        
    }()
    
    lazy var titleLabel: UILabel = {
        
        let label: UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height))
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeUI() {
        
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(titleLabel)

    }
    
    open func setData(data:videoModel!) -> Void {
        titleLabel.text = data.title
        imageView.sd_setImage(with: URL.init(string: data.cover))
    }
}
