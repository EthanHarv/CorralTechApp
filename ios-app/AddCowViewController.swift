//
//  AddCowViewController.swift
//  ios-app
//
//  Created by Elijah Gnuse on 4/25/23.
//

import UIKit

class AddCowViewController: UIViewController {

    @IBOutlet weak var cowName: UITextField!
    @IBOutlet weak var cowWeight: UITextField!
    @IBOutlet weak var cowVaccinations: UITextField!
    @IBOutlet weak var cowNotes: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addCow(_ sender: Any) {
        /*
          (1)Are all data types of parameters to Record() correct?
          (2)Add error handling to prevent user from entering bad input for numeric values such as Weight?
          (3)Add additional text fields for birthYear, pregStatus, sex?
            Or
            Parse all information (birthYear, pregStatus, sex) from "Notes" text field?
            -SOPHIA ANSWER: Additional text fields, people may not state that in notes and its required for record creation. 
          (4)Is vaxStatus string or "Y/N"? Currently adds string that was input into "Vaccinations" text field. Could change to be "Y/N" depending on if box is emptpy
                -SOPHIA ANSWER: Vax Status could be some kind of checklist, but its a string right now for simplicity.
         */
        let lat = Double.random(in: 41.249795 ..< 41.255328)
        let lon = Double.random(in: -96.014733 ..< -96.004884)

        let con: DatabaseConnection = DatabaseConnection()
        let record: Record = Record(cowId: cowName.text ?? "", birthYear: "1920", vaxStatus: cowVaccinations.text ?? "", lastWeight: Double(cowWeight.text!) ?? 0.0, pregStatus: 0, sex: cowNotes.text!, latitude: lat, longitude: lon)
        con.createRecord(Record: record)
        print(con.dbUrl)
        
        print(con.readRecord(cowId: cowName.text!).cowId)
        
    }
}
