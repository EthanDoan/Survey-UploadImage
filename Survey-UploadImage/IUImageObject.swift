//
//  IUImageObject.swift
//  Survey-UploadImage
//
//  Created by Doan Van Phuong on 2/20/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

enum ImageCategory {
    case TONG_QUAN
    case COT_DIEN_TRAM_BIEN_AP
    case HO_GA
    case LUOI_DIEN_CAO_THE
}

class IUImageObject {
    
    var category: ImageCategory
    var imageUrl: String
    var originImage: UIImage
    
    init(category: ImageCategory, imageUrl: String, originImage: UIImage) {
        self.category = category
        self.imageUrl = imageUrl
        self.originImage = originImage
    }
    
}
