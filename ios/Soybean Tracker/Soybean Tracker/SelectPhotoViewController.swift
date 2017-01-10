//
//  SelectPhotoViewController.swift
//  Soybean Tracker
//
//  Created by tom stimes on 11/6/16.
//  Copyright © 2016 iastate.mechanics. All rights reserved.
//

import UIKit
import AlamofireImage

class SelectPhotoViewController: ChildViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate
 {
    
    var photoSelected = false
    
    //Reference to containing ViewController:
    weak var createViewController: CreateEntryViewController?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var annotateButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    let imagePicker = UIImagePickerController()
    
    var imagePath: String?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        super.index = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        //Force user to pick a photo before allowing them to move on or annotate
        //TODO also restrict swiping next
        setPhotoSelected(false)
        
        imageView.af_setImage(withURL: URL(string: "https://baskar-group.me.iastate.edu/soybean_app/images/12")!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //To load annotated image:
        if let path = imagePath {
            
            if FileManager.default.fileExists(atPath: path){
                let image = UIImage(contentsOfFile: path)
                imageView.image = image
                setPhotoSelected(true)
            }
            
        }
        else {
            //TODO show No Photo Selected
        }
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Uses device camera to take a photo:
    @IBAction func takePhotoOnClick(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            print("No camera available")
            //TODO just disable button
        }
    }
    
    //Opens user's photo library for picking a photo
    @IBAction func pickPhotoOnClick(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func nextOnClick(_ sender: UIButton) {
        createViewController?.transitionNextFrom(pageIndex: index)
    }
    
    //Callback method for when user takes/selects a photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //Can also do UIImagePickerControllerEditedImage
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.dismiss(animated: true, completion: nil)
            
            imageView.image = image
            setPhotoSelected(true)
            
            self.imagePath = Utils.getImageFilePath()
            Utils.saveImage(imagePath: imagePath!, image: image)
        }
    }
    
    private func setPhotoSelected(_ value: Bool){
        
        photoSelected = value
        nextButton.isEnabled = value
        annotateButton.isEnabled = value
        
        if value {
            createViewController?.image = imageView.image
            createViewController?.data.imagePath = imagePath
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        let destination = segue.destination as! UINavigationController
//        if let vc = destination.visibleViewController as? AnnotateImageViewController {
//            vc.imagePath = self.imagePath
//        }
//    }
}
