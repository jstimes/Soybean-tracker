//
//  CreateEntryPageViewController.swift
//  Soybean Tracker
//
//  Created by tom stimes on 11/6/16.
//  Copyright © 2016 iastate.mechanics. All rights reserved.
//

import UIKit

//class CreateEntryPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    /*var data = SoybeanData()
    var image: UIImage?
    
    var pageViewControllers: [UIViewController] = []
    
    var pageIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let selectPhotoViewController = storyboard?.instantiateViewController(withIdentifier: "SelectPhoto") as! SelectPhotoViewController
        selectPhotoViewController.parentPageViewController = self
        
        let diagnosisViewController = storyboard?.instantiateViewController(withIdentifier: "Diagnosis") as! DiagnosisViewController
        diagnosisViewController.parentPageViewController = self
        
        let contextViewController = storyboard?.instantiateViewController(withIdentifier: "Context") as! ContextViewController
        contextViewController.parentPageViewController = self
        
        let summaryViewController = storyboard?.instantiateViewController(withIdentifier: "Summary") as!
            EntrySummaryViewController
        summaryViewController.parentPageViewController = self
        
        pageViewControllers.append(selectPhotoViewController)
        pageViewControllers.append(diagnosisViewController)
        pageViewControllers.append(contextViewController)
        pageViewControllers.append(summaryViewController)
        
        setViewControllers([selectPhotoViewController],
                           direction: .forward,
                           animated: true,
                           completion: nil)
        
        dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //To be called by summaryVC
    func submit(){
        //TODO upload data
        
        //TODO save to CoreData
    }
    
    func transitionNext(){
        if(pageIndex < pageViewControllers.count - 1){
            pageIndex = pageIndex + 1
            self.setViewControllers([pageViewControllers[pageIndex]], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func transitionBack(){
        if(pageIndex > 0){
            pageIndex = pageIndex - 1
            self.setViewControllers([pageViewControllers[pageIndex]], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if pageIndex < 1 {
            return nil
        }
        
        pageIndex = pageIndex - 1
        return pageViewControllers[pageIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
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
        
        pageIndex = pageIndex + 1
        return pageViewControllers[pageIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        print(pageIndex)
        return pageIndex
    }*/
//}
