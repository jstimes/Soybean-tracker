//
//  AnnotateImageViewController.swift
//  Soybean Tracker
//
//  Created by tom stimes on 11/7/16.
//  Copyright © 2016 iastate.mechanics. All rights reserved.
//

import UIKit

//TODO a clear option, save back to pageview when done
class AnnotateImageViewController: ChildViewController {
    
    var cropPath: String?
    
    var originalImage: UIImage?
    
    var lastPoint = CGPoint.zero
    var red: CGFloat = 1.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    var firstPoint = CGPoint.zero
    var currentPoint = CGPoint.zero
    
    //Reference to containing ViewController:
    weak var createViewController: CreateEntryViewController?
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if FileManager.default.fileExists(atPath: (createViewController?.data.imagePath)!){
            originalImage = UIImage(contentsOfFile: (createViewController?.data.imagePath)!)
            imageView.image = originalImage
            
            cropPath = Utils.getCroppedImageFilePath()
        }
        
        createViewController!.data.cropRect = CGRect()
        
        super.index = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveOnClick(_ sender: UIButton) {

        let cropRect = CGRect(x: firstPoint.x, y: firstPoint.y, width: currentPoint.x - firstPoint.x, height: currentPoint.y - firstPoint.y)
        UIGraphicsBeginImageContextWithOptions(cropRect.size, true, 1)
        
        let newImage = originalImage!
        let imageSize = imageView.frame.size
        newImage.draw(in: CGRect(x: -cropRect.origin.x, y: -cropRect.origin.y, width: imageSize.width, height: imageSize.height))
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        Utils.saveImage(imagePath: cropPath!, image: result!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            firstPoint = touch.location(in: self.imageView)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first {
            currentPoint = touch.location(in: self.imageView)
            drawRectangleOnImage()
        }
    }
    
    func drawRectangleOnImage()  {
        let imageSize = imageView.frame.size
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(imageSize, true, scale)
        let context = UIGraphicsGetCurrentContext()
        
        let newImage = originalImage!
        newImage.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        
        let rectangle = CGRect(x: firstPoint.x, y: firstPoint.y, width: currentPoint.x - firstPoint.x, height: currentPoint.y - firstPoint.y)
        
        context?.setStrokeColor(UIColor.black.cgColor)
        context?.setLineWidth(2.0)
        context?.addRect(rectangle)
        context?.drawPath(using: .stroke)

        let rectImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        imageView.image = rectImage
    }
    
    @IBAction func nextOnClick(_ sender: UIButton) {
        createViewController?.transitionNextFrom(pageIndex: index)
    }
    
    @IBAction func backOnClick(_ sender: UIButton) {
        createViewController?.transitionBackFrom(pageIndex: index)
    }
}
