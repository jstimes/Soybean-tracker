//
//  CreateEntryViewController.swift
//  Soybean Tracker
//
//  Created by tom stimes on 11/7/16.
//  Copyright © 2016 iastate.mechanics. All rights reserved.
//

import UIKit
import Alamofire

//TODO:
    // get actual author
// upload class?
class CreateEntryViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var data = SoybeanData()
    var image: UIImage?
    
    var pageViewControllers: [UIViewController] = []
    
    //var pageIndex = 0
    
    weak var pageViewController: UIPageViewController?
    
    weak var homeReference: HomeTableViewController?
    
    var currentIndex = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        pageViewController = storyboard?.instantiateViewController(withIdentifier: "CreateEntry") as? UIPageViewController
        
        let selectPhotoViewController = storyboard?.instantiateViewController(withIdentifier: "SelectPhoto") as! SelectPhotoViewController
        selectPhotoViewController.createViewController = self
        
        let annotateImageViewController = storyboard?.instantiateViewController(withIdentifier: "Annotate") as! AnnotateImageViewController
        annotateImageViewController.createViewController = self
        
        let diagnosisViewController = storyboard?.instantiateViewController(withIdentifier: "Diagnosis") as! DiagnosisViewController
        diagnosisViewController.createViewController = self
        
        let contextViewController = storyboard?.instantiateViewController(withIdentifier: "Context") as! ContextViewController
        contextViewController.createViewController = self
        
        let summaryViewController = storyboard?.instantiateViewController(withIdentifier: "Summary") as!
        EntrySummaryViewController
        summaryViewController.createViewController = self
        
        pageViewControllers.append(selectPhotoViewController)
        pageViewControllers.append(annotateImageViewController)
        pageViewControllers.append(diagnosisViewController)
        pageViewControllers.append(contextViewController)
        pageViewControllers.append(summaryViewController)
        
        pageViewController?.setViewControllers([selectPhotoViewController],
                           direction: .forward,
                           animated: true,
                           completion: nil)
        
        //pageViewController?.dataSource = self
        
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMove(toParentViewController: self)
        
        setupPageControl()
        
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.gray
        appearance.currentPageIndicatorTintColor = UIColor.white
        appearance.backgroundColor = UIColor.darkGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //To be called by summaryVC
    func submit(){
        //TODO upload data
        
        uploadImageAndData()
        
        //TODO save to CoreData
        
        homeReference!.entries.append(self.data)
        self.dismiss(animated: true, completion: nil)
    }
    
    func transitionNextFrom(pageIndex: Int){
        if(pageIndex < pageViewControllers.count - 1){
            currentIndex = pageIndex + 1
            pageViewController?.setViewControllers([pageViewControllers[pageIndex + 1]], direction: .forward, animated: true, completion: nil)
//            if pageIndex == 1{
//                pageViewController?.dataSource = nil
//            }
//            else {
//                pageViewController?.dataSource = self
//            }
        }
    }
    
    func uploadImageAndData(){
        //parameters
        let author    = "TODO get author"
        let disease = data.disease!
        let takenDate  = Utils.MySQLstringForData(data.date!)
        
//        var cropRect: Data?
//        do {
//            cropRect = try JSONSerialization.data(withJSONObject: ["x": -1, "y":-1, "w":-1, "h":-1])
//        }
//        catch {
//            cropRect = nil
//        }
        let cropRect = ["x": -1, "y":-1, "w":-1, "h":-1]
        
        let latitude   = data.latitude!
        let longitude     = data.longitude!
        let severity = String(data.severity!) //TODO int in DB
        
        //var parameters = [String:String]()
        let parameters: Parameters = ["author":author ,//as AnyObject,
                      "disease":disease ,//as AnyObject,
                      "takenDate":takenDate ,//as AnyObject,
                      "cropRect":cropRect ,//as AnyObject,
                      "latitude":String(latitude) ,//as AnyObject,
                      "longitude":String(longitude) ,//as AnyObject,
                        "severity":String(severity) ?? -2 ,
                        "image_base64": UIImageJPEGRepresentation(image!, 0.5)?.base64EncodedString(options: .lineLength64Characters) ?? "img encoding failed"]//as AnyObject]
        
        let URL = "https://baskar-group.me.iastate.edu/soybean_app/upload.php"

//        Alamofire.upload(multipartFormData:{ multipartFormData in
//                if let imageData = UIImageJPEGRepresentation(self.image!, 0.6) {
//                    multipartFormData.append(imageData, withName: "image_base64", fileName: "file.png", mimeType: "image/png")
//                }
//            
//                for (key, value) in parameters {
//                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
//                }
//                if let rect = cropRect {
//                    multipartFormData.append(rect, withName: "cropRect")
//                }
//            },
//             usingThreshold:UInt64.init(),
//             to:URL,
//             method:.post,
//             //headers:["Authorization": "auth_token"],
//             encodingCompletion: { encodingResult in
//                switch encodingResult {
//                case .success(let upload, _, _):
//                    upload.responseJSON { response in
//                        debugPrint(response)
//                    }
//                case .failure(let encodingError):
//                    print(encodingError)
//                }
//        })
        //.responseJSON { response in
                //debugPrint(response)
        //}

        Alamofire.request(URL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                debugPrint(response)
            }

    }
    
    func transitionBackFrom(pageIndex: Int){
        if(pageIndex > 0){
            currentIndex = pageIndex - 1
            pageViewController?.setViewControllers([pageViewControllers[pageIndex - 1]], direction: .reverse, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let childVC = viewController as! ChildViewController
        let pageIndex = childVC.index
        
        if pageIndex < 1 {
            return nil
        }
        
        return pageViewControllers[pageIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let childVC = viewController as! ChildViewController
        let pageIndex = childVC.index
        
        //Make sure there is one after the current VC:
        if pageIndex > pageViewControllers.count - 2 {
            return nil
        }
        
        //Also make sure required data is set before moving on:
        /*if pageIndex == 0 {
         let vc = viewController as! SelectPhotoViewController
         if !vc.photoSelected {
         return nil
         }
         }*/
        
        print("VC after " + String(pageIndex))
        
        return pageViewControllers[pageIndex  + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        print("presentationIndex " + String(currentIndex))
        return currentIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let nextVC = pendingViewControllers.first as! ChildViewController
        
        currentIndex = nextVC.index
        print("Will transition to " + String(currentIndex))
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    }

    @IBAction func cancelOnClick(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    class JSONRect {
        var x: Int
        var y: Int
        var w: Int
        var h: Int
        
        init(rect: CGRect){
            self.x = Int(rect.origin.x)
            self.y = Int(rect.origin.y)
            self.w = Int(rect.size.width)
            self.h = Int(rect.size.height)
        }
    }
}
