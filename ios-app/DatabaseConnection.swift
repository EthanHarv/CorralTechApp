//
//  DatabaseConnection.swift
//  ios-app
//
//  Created by Sophia Birch on 4/25/23.
//

import Foundation
import SQLite3

class DatabaseConnection {
    let dbUrl: URL
    var db: OpaquePointer?
    
    var insertEntryStmt: OpaquePointer?
    var readEntryStmt: OpaquePointer?
    var updateEntryStmt: OpaquePointer?
    var deleteEntryStmt: OpaquePointer?
    
    init() {
        do {
            self.dbUrl = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("cow.db")
        } catch {
            self.dbUrl = URL(fileURLWithPath: "")
            return
        }
        
        openDB()
        createTable()
    }
    
    //Opens the database at the given url/pointer. Throws a fatal error
    //if issues arise. 
    private func openDB() {
        if sqlite3_open(dbUrl.path, &db) != SQLITE_OK {
            fatalError( "error opening database \(dbUrl.absoluteString)")
        }
    }
    
    //removes the database at the given URL. Returns an error
    //should problems arise
    func deleteDB(dbUrl: URL){
        do {
            try FileManager.default.removeItem(at: dbUrl)
        } catch {
            print("Error deleting DB");
            return;
        }
    }
    
    private func createTable() {

       let ret =  sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Record (id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT, cowId TEXT UNIQUE NOT NULL, birthYear TEXT NOT NULL, vaxStatus TEXT NOT NULL, lastWeight DOUBLE, pregStatus INTEGER NOT NULL, sex TEXT NOT NULL)", nil, nil, nil)
       if (ret != SQLITE_OK) { // corrupt database.
            fatalError("unable to create table Records")
       }
       
    }
    
    func prepareEntryStatement() -> Int32 {
        
        guard insertEntryStmt == nil else { return SQLITE_OK }
        
        let sql = "INSERT INTO Record (cowId, birthYear, vaxStatus, lastWeight, pregStatus, sex) VALUES (?,?,?,?,?,?)";
        
        let r = sqlite3_prepare(db, sql, -1, &insertEntryStmt, nil);
        
        if r != SQLITE_OK {
            print("Error occurred with prepared statement");
            return 1;
        }
       
        return r;
    }
    
    func prepareRetrievalStatement() -> Int32 {
        
        guard readEntryStmt == nil else { return SQLITE_OK }
        
        let sql = "SELECT * FROM Record where cowId = ?";
        
        let r = sqlite3_prepare(db, sql, -1, &readEntryStmt, nil);
        
        if r != SQLITE_OK {
            print("Error occurred with prepared statement");
            return 1;
        }
       
        return r;
    }
    
    func prepareUpdateStatement() -> Int32 {
        
        guard updateEntryStmt == nil else { return SQLITE_OK }
        
        let sql = "UPDATE Record SET cowId = ?, birthYear = ?, vaxStatus = ?, lastWeight = ?, pregStatus = ?, sex = ?, latitude = ?, longitude = ? WHERE cowId = ?";
        
        let r = sqlite3_prepare(db, sql, -1, &updateEntryStmt, nil);
        
        if r != SQLITE_OK {
            print("Error occurred with prepared statement");
            return 1;
        }
       
        return r;
    }
    //TODO: add Destroy functions.
}


