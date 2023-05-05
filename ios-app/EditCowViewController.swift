//
//  EditCowViewController.swift
//  ios-app
//
//  Created by Elijah Gnuse on 4/25/23.
//

import UIKit

class EditCowViewController: UIViewController {

    var originalCowName = ""
    
    @IBOutlet weak var cowNameLabel: UILabel!
    @IBOutlet weak var newCowName: UITextField!
    @IBOutlet weak var newCowWeight: UITextField!
    @IBOutlet weak var newCowVaccinations: UITextView!
    @IBOutlet weak var newCowNotes: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cowNameLabel.text = originalCowName
        // Do any additional setup after loading the view.
        
        let con = DatabaseConnection()
        let rec = con.readRecord(cowId: originalCowName)
        
        newCowName.text = rec.cowId
        newCowWeight.text = String(rec.lastWeight)
        newCowVaccinations.text = rec.vaxStatus
        newCowNotes.text = rec.sex
        
        let borderColor : UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        newCowNotes.layer.borderWidth = 1
        newCowNotes.layer.borderColor = borderColor.cgColor
        newCowVaccinations.layer.borderWidth = 1
        newCowVaccinations.layer.borderColor = borderColor.cgColor

    }
        
    @IBAction func deleteCow(_ sender: Any) {
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure?", preferredStyle: .alert)

        let confirmAction = UIAlertAction(title: "Yes", style: .destructive) { [self] (_) in
            // Action to perform when the user confirms
            // This block is executed when the user taps the "Yes" button
            
            let con = DatabaseConnection()
            print(originalCowName)
            con.destroyCow(cowId: originalCowName)
            
            print("Confirmed")
            
            performSegue(withIdentifier: "BackToMainSegue", sender: nil)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            // Action to perform when the user cancels
            // This block is executed when the user taps the "Cancel" button
            print("Cancelled")
        }

        alert.addAction(confirmAction)
        alert.addAction(cancelAction)

        // Present the alert
        // 'self' here represents the view controller from which you are presenting the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func updateCow(_ sender: Any) {
        /*
          (1)Are all data types of parameters to Record() correct?
          (2)Change updateEntryStmt to correctly access cow pointed to? Opaque Pointer
          (3)Add error handling to prevent user from entering bad input for numeric values such as Weight? (Don't add cow if input is bad or give popup notification)
          (4)Add additional text fields in EditCow screen and AddCow Screen for birthYear, pregStatus, sex?
            Or
            Parse all information (birthYear, pregStatus, sex) from "Notes" text field?
          (5)Top displays Cow #32 (Name). Tapping on dot indicating cow (on map) will make this screen come up and label corresponding to cow will be displayed in future?
         */
        let lat = Double.random(in: 41.249795 ..< 41.255328)
        let lon = Double.random(in: -96.014733 ..< -96.004884)
        let con: DatabaseConnection = DatabaseConnection()
        let record: Record = Record(cowId: newCowName.text!, birthYear: "1920", vaxStatus: newCowVaccinations.text!, lastWeight: Double(newCowWeight.text!) ?? 0, pregStatus: 0, sex: newCowNotes.text!, latitude: lat, longitude: lon)
        print("ok")
        con.replaceRecord(cowId: originalCowName, record: record)
        //BackToMainSegue
        performSegue(withIdentifier: "BackToMainSegue", sender: nil)
    }
}
