//
//  TypeCrimeViewController.swift
//  Linceu
//
//  Created by Esdras Bezerra da Silva on 14/06/15.
//  Copyright (c) 2015 Esdras Bezerra da Silva. All rights reserved.
//

import UIKit

class TypeCrimeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var subTitleField: UITextField!
    @IBOutlet weak var typeCrimePicker: UIPickerView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var dateCrimePicker: UIDatePicker!
    
    var selectedDay: NSDate?
    
    
    let typeCrimeArray = ["Roubo a pessoa",
        "Roubo a residencia",
        "Roubo de veiculo",
        "Roubo a comércio",
        "Furto a pessoa",
        "Furto a residencia",
        "Furto de veiculo",
        "Homicidio",
        "Vandalismo",
        "Venda de Drogas",
        "Assédio Violação de direitos"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeCrimeArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return typeCrimeArray[row] as String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.titleField.text = typeCrimeArray[row] as String
        self.subTitleField.text = typeCrimeArray[row] as String
        
    }
    
    func selectDay() -> String{
        let chosenDate = self.dateCrimePicker.date
        var formatedDate = NSDateFormatter()
        formatedDate.dateFormat = "d m y"
        let theDate = formatedDate.stringFromDate(chosenDate)
//        self.dateField.text = theDate
        
        return theDate
    }
    
    @IBAction func testDate(sender: AnyObject) {
        
        performSegueWithIdentifier("saveCrime", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "saveCrime"{
            if let destinationVC = segue.destinationViewController as? ArarasMapViewController{
                destinationVC.titleCrime = self.titleField.text
                destinationVC.subTitleCrime = self.subTitleField.text
                destinationVC.descriptionCrime = self.descriptionTextView.text
                destinationVC.dateCrime = self.dateCrimePicker.date
            }
        }
    }
    
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
