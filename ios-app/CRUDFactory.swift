//
//  CRUDFactory.swift
//  ios-app
//
//  Created by Sophia Birch on 4/25/23.
//

import Foundation
import SQLite3

// Handles paramter binding and execution of database statements
extension DatabaseConnection {
    
    // Inserts contents of a given instance of Record. Prints errors to stdout.
    func createRecord(Record: Record) {
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
        
        if sqlite3_bind_double(self.insertEntryStmt, 7, Record.latitude) != SQLITE_OK {
            print("Error inserting latitude")
            return
        }
        
        if sqlite3_bind_double(self.insertEntryStmt, 8, Record.longitude) != SQLITE_OK {
            print("Error inserting longitude")
            return
        }
        
        let r = sqlite3_step(self.insertEntryStmt)
        if r != SQLITE_DONE {
            print("Error inserting record")
            return
        }
    }
    
    // Read record by cowId, if exists. Prints errors to stdout.
    func readRecord(cowId: String) -> Record {
        let emptyRecord: Record = Record(cowId: "N/A", birthYear: "N/A", vaxStatus: "N/A" , lastWeight: -1.0 , pregStatus: -1, sex: "N/A", latitude: -0, longitude: -0)
        
        guard self.prepareRetrievalStatement() == SQLITE_OK else { return emptyRecord }
                
        defer {
           // reset the prepared statement on exit.
           sqlite3_reset(self.readEntryStmt)
        }
        
        if sqlite3_bind_text(self.readEntryStmt, 1, (cowId as NSString).utf8String, -1, nil) != SQLITE_OK {
            print("Error binding cowId param.")
            return emptyRecord
        }
        
        // Read row into a Record
        if(sqlite3_step(readEntryStmt) == SQLITE_ROW) {
            let cowId:String = String(cString: sqlite3_column_text(readEntryStmt, 1))
            let birthYear = String(cString: sqlite3_column_text(readEntryStmt, 2))
            let vaxStatus = String(cString: sqlite3_column_text(readEntryStmt, 3))
            let lastWeight = sqlite3_column_double(readEntryStmt, 4)
            let pregStatus = sqlite3_column_int(readEntryStmt, 5)
            let sex = String(cString: sqlite3_column_text(readEntryStmt, 6))
            let lat = sqlite3_column_double(readEntryStmt, 7)
            let long = sqlite3_column_double(readEntryStmt, 8)
            
            let record: Record = Record(cowId: cowId, birthYear: birthYear, vaxStatus: vaxStatus, lastWeight: lastWeight, pregStatus: Int(pregStatus), sex: sex, latitude: lat, longitude: long)
            
            return record
        } else {
            print("No row of cowID \(cowId) found.")
            return emptyRecord
        }
    }
    
    // Read all records, if exists. Prints errors to stdout.
    func readAllRecords() -> [Record] {
        var recordList: [Record] = []
        guard self.prepareReadAllStatement() == SQLITE_OK else { return recordList}
                
        defer {
           // reset the prepared statement on exit.
           sqlite3_reset(self.readAllEntryStmt)
        }
  
        while(sqlite3_step(readAllEntryStmt) == SQLITE_ROW) {
            
            let cowId = String(cString: sqlite3_column_text(readAllEntryStmt, 1))
            let birthYear = String(cString: sqlite3_column_text(readAllEntryStmt, 2))
            let vaxStatus = String(cString: sqlite3_column_text(readAllEntryStmt, 3))
            let lastWeight = sqlite3_column_double(readAllEntryStmt, 4)
            let pregStatus = sqlite3_column_int(readAllEntryStmt, 5)
            let sex = String(cString: sqlite3_column_text(readAllEntryStmt, 6))
            let lat = sqlite3_column_double(readAllEntryStmt, 7)
            let long = sqlite3_column_double(readAllEntryStmt, 8)
            
            let record: Record = Record(cowId: cowId, birthYear: birthYear, vaxStatus: vaxStatus, lastWeight: lastWeight, pregStatus: Int(pregStatus), sex: sex, latitude: lat, longitude: long)

            recordList.append(record)
        }
        
        return recordList
    }
    
    // Update a record by replacing all fields. Prints errors to stdout.
    // (To use: first copy record, make changes, and send back).
    func replaceRecord(cowId: String, record: Record) {
        guard self.prepareUpdateStatement() == SQLITE_OK else { return }

        defer {
           // reset the prepared statement on exit.
           sqlite3_reset(self.updateEntryStmt)
        }
               
        if sqlite3_bind_text(self.updateEntryStmt, 9, (cowId as NSString).utf8String, -1, nil) != SQLITE_OK {
            print("Error binding cowId param.")
            return
        }
        
        if sqlite3_bind_text(self.updateEntryStmt, 1, (record.cowId as NSString).utf8String, -1, nil) != SQLITE_OK {
            print("Error inserting cowId")
            return
        }
        
        if sqlite3_bind_text(self.updateEntryStmt, 2, (record.birthYear as NSString).utf8String, -1, nil) != SQLITE_OK {
            print("Error inserting birthYear")
            return
        }
        
        if sqlite3_bind_text(self.updateEntryStmt, 3, (record.vaxStatus as NSString).utf8String, -1, nil) != SQLITE_OK {
            print("Error inserting vaxStatus")
            return
        }
        
        if sqlite3_bind_double(self.updateEntryStmt, 4, record.lastWeight) != SQLITE_OK {
            print("Error inserting lastWeight")
            return
        }
        
        //TRUE/FALSE pregnancy status MUST be fed in as an Int (either 1 or 0)
        if sqlite3_bind_int(self.updateEntryStmt, 5, Int32(record.pregStatus as Int)) != SQLITE_OK {
            print("Error inserting pregStatus")
            return
        }
        
        if sqlite3_bind_text(self.updateEntryStmt, 6, (record.sex as NSString).utf8String, -1, nil) != SQLITE_OK {
            print("Error inserting sex")
            return
        }
        
        if sqlite3_bind_double(self.updateEntryStmt, 7, record.latitude) != SQLITE_OK {
            print("Error inserting latitude")
            return
        }
        
        if sqlite3_bind_double(self.updateEntryStmt, 8, record.longitude) != SQLITE_OK {
            print("Error inserting longitude")
            return
        }
        
        let r = sqlite3_step(self.updateEntryStmt)
        if r != SQLITE_DONE {
            print("Error inserting record")
            return
        }
    }
    
    // Remove cow from database by cowId. Prints errors to stdout.
    func destroyCow(cowId: String) {
        guard self.prepareDestroyStmt() == SQLITE_OK else { return }
                
        defer {
           // reset the prepared statement on exit.
           sqlite3_reset(self.destroyStmt)
        }
        
        if sqlite3_bind_text(self.destroyStmt, 1, (cowId as NSString).utf8String, -1, nil) != SQLITE_OK {
            print("Error inserting cowId")
            return
        }
       
        if sqlite3_step(destroyStmt) == SQLITE_DONE {
            print("Successfully deleted row.")
        } else {
            print("Could not delete row.")
        }
    }
}
