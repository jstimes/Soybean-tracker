//
//  DiagnosisViewController.swift
//  Soybean Tracker
//
//  Created by tom stimes on 11/6/16.
//  Copyright © 2016 iastate.mechanics. All rights reserved.
//

import UIKit

//TODO sync data with CreateViewController every time a value changes so user can use swiping or next/back buttons
class DiagnosisViewController: ChildViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var diseasePickerView: UIPickerView!
    
    @IBOutlet weak var severitySlider: UISlider!
    
    weak var createViewController: CreateEntryViewController?
    
    let diseaseStrings = ["Disease A", "Disease B", "Unknown"]
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        super.index = 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        diseasePickerView.delegate = self
        diseasePickerView.dataSource = self
        
        severitySlider.maximumValue = 100
        severitySlider.minimumValue = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.imageView.image = createViewController?.image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 2.0, *)
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return diseaseStrings.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return diseaseStrings[row]
    }
    
    
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        createViewController?.data.disease = diseaseStrings[row]
    }
    
    @IBAction func backOnClick(_ sender: UIButton) {
        createViewController?.transitionBackFrom(pageIndex: index)
    }

    @IBAction func nextOnClick(_ sender: UIButton) {
        let diseaseIndex = diseasePickerView.selectedRow(inComponent: 0)
        createViewController?.data.disease = diseaseStrings[diseaseIndex]
        
        createViewController?.data.severity = severitySlider.value
        
        createViewController?.transitionNextFrom(pageIndex: index)
    }

}
