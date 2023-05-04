//
//  EditCowViewController.swift
//  ios-app
//
//  Created by Elijah Gnuse on 4/25/23.
//

import UIKit

class EditCowViewController: UIViewController {

    var cowName = ""
    
    @IBOutlet weak var cowNameLabel: UILabel!
    @IBOutlet weak var newCowName: UITextField!
    @IBOutlet weak var newCowWeight: UITextField!
    @IBOutlet weak var newCowVaccinations: UITextField!
    @IBOutlet weak var newCowNotes: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        cowNameLabel.text = cowName
        // Do any additional setup after loading the view.
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
        let con: DatabaseConnection = DatabaseConnection()
        let record: Record = Record(cowId: newCowName.text!, birthYear: "1920", vaxStatus: newCowVaccinations.text!, lastWeight: Double(newCowWeight.text!)!, pregStatus: 0, sex: "Intersex", latitude: 8, longitude: 7)
//        con.updateEntryStmt(newCowName.text!)
        
    }
}
