//
//  TweetCell.swift
//  TweetKouga
//
//  Created by Yuji Yamamoto on 2018/06/15.
//  Copyright © 2018年 ridgeroot. All rights reserved.
//

import UIKit
import Instantiate
import InstantiateStandard
import Kingfisher

final class TweetCell: UITableViewCell {
    @IBOutlet private weak var mainImageView: UIImageView!
}

extension TweetCell: Reusable {
    typealias Dependency = (CellData)
    
    func inject(_ dependency: Dependency) {
        mainImageView.kf.setImage(with: dependency.imageURL, completionHandler: { (image, error, cacheType, url) in
            // FIXME: aspectratioを変更
            self.setNeedsLayout()
        })
    }
}
