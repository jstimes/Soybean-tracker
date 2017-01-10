//
//  Utils.swift
//  Soybean Tracker
//
//  Created by tom stimes on 11/9/16.
//  Copyright © 2016 iastate.mechanics. All rights reserved.
//

import UIKit

class Utils {
    
    class func getImageFilePath() -> String {
        let filename = Date().description + ".jpg"
        return (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(filename)
    }
    
    class func getCroppedImageFilePath() -> String {
        let filename = Date().description + "-cropped.jpg"
        return (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(filename)
    }
    
    class func saveImage(imagePath: String, image: UIImage) {
        
        print(imagePath)
        
        let imageData = UIImageJPEGRepresentation(image, 0.6)
        
        //TODO - Should I save to photos album?
        //let compressedJPGImage = UIImage(data: imageData!)
        //UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        
        FileManager.default.createFile(atPath: imagePath, contents: imageData, attributes: nil)
    }
    
    class func stringForDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
        
        //let calendar = NSCalendar.current
        //let hour = calendar.component(.hour, from: date as Date)
        //let minutes = calendar.component(.minute, from: date as Date)
    }
    
    class func MySQLstringForData(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return formatter.string(from: date)
    }
}
