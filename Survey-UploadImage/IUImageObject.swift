//
//  IUImageObject.swift
//  Survey-UploadImage
//
//  Created by Doan Van Phuong on 2/20/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

enum ImageCategory: String, CaseIterable {
    case TONG_QUAN = "TONG_QUAN"
    case COT_DIEN_TRAM_BIEN_AP = "COT_DIEN_TRAM_BIEN_AP"
    case HO_GA = "HO_GA"
    case LUOI_DIEN_CAO_THE = "LUOI_DIEN_CAO_THE"
    
    static let allValues = [TONG_QUAN, COT_DIEN_TRAM_BIEN_AP, HO_GA, LUOI_DIEN_CAO_THE]
    
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
