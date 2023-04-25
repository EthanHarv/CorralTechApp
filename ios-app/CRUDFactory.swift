//
//  CRUDFactory.swift
//  ios-app
//
//  Created by Sophia Birch on 4/25/23.
//

import Foundation
import SQLite3

extension DatabaseConnection {
    
    //Inserts contents of a given instance of Record into cow.db. Returns an error if something goes wrong.
    func createRecord(Record: Record){
        guard self.prepareEntryStatement() == SQLITE_OK else { return }
                
        defer {
           // reset the prepared statement on exit.
           sqlite3_reset(self.insertEntryStmt)
        }
        
        if sqlite3_bind_text(self.insertEntryStmt, 1, (Record.cowId as NSString).utf8String, -1, nil) != SQLITE_OK {
            print("Error inserting cowId")
            return
        }
        
        if sqlite3_bind_text(self.insertEntryStmt, 2, (Record.birthYear as NSString).utf8String, -1, nil) != SQLITE_OK {
            print("Error inserting birthYear")
            return
        }
        
        if sqlite3_bind_text(self.insertEntryStmt, 3, (Record.vaxStatus as NSString).utf8String, -1, nil) != SQLITE_OK {
            
                    print("Error inserting vaxStatus")
                    return
                }
        
        if sqlite3_bind_double(self.insertEntryStmt, 4, Record.lastWeight) != SQLITE_OK {
            print("Error inserting lastWeight")
            return
        }
        
        //TRUE/FALSE pregnancy status MUST be fed in as an Int (either 1 or 0)
        if sqlite3_bind_int(self.insertEntryStmt, 5, Int32(Record.pregStatus as Int)) != SQLITE_OK {
            
                    print("Error inserting pregStatus")
                    return
                }
        
        if sqlite3_bind_text(self.insertEntryStmt, 6, (Record.sex as NSString).utf8String, -1, nil) != SQLITE_OK {
            
                    print("Error inserting sex")
                    return
                }
        
        let r = sqlite3_step(self.insertEntryStmt)
        if r != SQLITE_DONE {
            print("Error inserting record")
            return
        }
    }
    
    //TODO: add Read, Update, Destroy. 
}
