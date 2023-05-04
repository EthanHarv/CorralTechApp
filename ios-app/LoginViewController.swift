//
//  ViewController.swift
//  ios-app
//
//  Created by Ethan Harvey on 4/13/23.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        let con: DatabaseConnection = DatabaseConnection()
//        let record: Record = Record(cowId: "KF0MKL", birthYear: "1920", vaxStatus: "none of them (#natural)", lastWeight: 2.0, pregStatus: 0, sex: "Intersex")
//        con.createRecord(Record: record)
        print("Database URL", con.dbUrl)
    }
}

