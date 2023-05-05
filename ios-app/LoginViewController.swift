//
//  ViewController.swift
//  ios-app
//
//  Created by Ethan Harvey on 4/13/23.
//

import UIKit

// god i love terrible practices :)
// In a real login scenerio, this would all be database-handled with proper key auth and such.
var GLOBAL_USERNAME: String = "Username"

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Store username in global variable so we can display it in the settings page.
    @IBAction func UsernameInput(_ sender: UITextField) {
        GLOBAL_USERNAME = sender.text ?? "Username"
    }
}
