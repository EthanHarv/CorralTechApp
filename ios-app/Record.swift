//
//  Record.swift
//  ios-app
//
//  Created by Sophia Birch on 4/25/23.
//

import Foundation
import SQLite3
//Record that stores relevant data about the cow.

class Record {
    var cowId: String;
    var birthYear: String;
    var vaxStatus: String;
    var lastWeight: Double;
    var pregStatus: Int;
    var sex: String;
    
    init(cowId: String, birthYear: String,
         vaxStatus: String, lastWeight: Double,
         pregStatus: Int, sex: String){
        self.cowId = cowId;
        self.birthYear = birthYear;
        self.vaxStatus = vaxStatus;
        self.lastWeight = lastWeight;
        self.pregStatus = pregStatus;
        self.sex = sex;
        
    }
    
}
