//
//  CKOperationsExempleViewController.swift
//  LearnCloudKit
//
//  Created by Matheus Costa on 28/01/19.
//  Copyright © 2019 Matheus Costa. All rights reserved.
//

import UIKit
import CloudKit

class CKOperationsExampleViewController: UIViewController {

    let container = CKContainer.default()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.saveRecords(name: "Casa do Gabriel", openKey: 123445)
//        self.queryRecords()
        
        if let recordName = UserDefaults.standard.string(forKey: "SavedRecordName") {
            let recordID = CKRecord.ID(recordName: recordName)
            
            self.fetchByIDs(recordIDs: [recordID])
        }
    }

    func queryRecords() {
        let query = CKQuery(recordType: "Houses", predicate: NSPredicate(value: true))
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["name"]
        
        // This block is executed for each record returned by the query.
        operation.recordFetchedBlock = { record in
            print(record["name"])
            print(record["openKey"]) // Since this key isn't on the desiredKeys, it's returned nil.
        }
        
        // Executed at the end of operation.
        operation.queryCompletionBlock = { (cursor, error) in
            print("end")
        }
        
        self.container.privateCloudDatabase.add(operation)
    }
    
    func saveRecords(name: String, openKey: Int) {
        let record = CKRecord(recordType: "Houses")
        record["name"] = name
        record["openKey"] = openKey
        
        // Is possible to pass records to save and IDs of records to delete.
        let operation = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: [])
        
        // Executed when the process ends.
        operation.modifyRecordsCompletionBlock = { _, _, error in
            guard error == nil else {
                print(error)
                return
            }
            
            print("Record saved")
            
            UserDefaults.standard.set(record.recordID.recordName, forKey: "SavedRecordName")
        }
        
        // This is the default value, just to make it explicit.
        operation.qualityOfService = .utility
        
        self.container.privateCloudDatabase.add(operation)
    }
    ea
    func fetchByIDs(recordIDs: [CKRecord.ID]) {
        // You must pass the IDs of the records you want to fetch.
        // That way, you can get several records at once.
        let operation = CKFetchRecordsOperation(recordIDs: recordIDs)
        
        // Executed when the process ends.
        operation.fetchRecordsCompletionBlock = { records, error in
            guard error == nil else { return }
            
            print(records)
        }
        
        // This is the default value, just to make it explicit.
        operation.qualityOfService = .utility
        
        self.container.privateCloudDatabase.add(operation)
    }
}
