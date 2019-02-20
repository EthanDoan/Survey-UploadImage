//
//  CommonFunctions.swift
//  Survey-UploadImage
//
//  Created by Doan Van Phuong on 2/20/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

class CommonFunctions {
    
   static func saveImage(image: UIImage, fileName: String, completion: @escaping (_ success: Bool,_ fileURL: URL?) -> Void) {
        
        let fileManager = FileManager.default
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let timestampStr = "\(NSDate().timeIntervalSince1970 * 1000)"
        let fileName = "\(fileName)-\(timestampStr)"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        if (fileManager.fileExists(atPath: fileURL.path)) {
            do {
                try fileManager.removeItem(atPath: fileURL.path)
            } catch {
                print("error delete file:", error)
            }
        }
        
        if let data = image.jpegData(compressionQuality: 1.0) {
            do {
                try data.write(to: fileURL)
                completion(true, fileURL)
                return
            } catch {
                completion(false, nil)
                return
            }
        }
    }
    
}
