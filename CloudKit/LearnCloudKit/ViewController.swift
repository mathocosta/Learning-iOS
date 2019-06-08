//
//  ViewController.swift
//  LearnCloudKit
//
//  Created by Matheus Costa on 14/11/18.
//  Copyright © 2018 Matheus Costa. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController {

    let container = CKContainer.default()
    
    var homeCreated: CKRecord.ID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CKContainer.default().fetchUserRecordID { (recordID, error) in
            if let error = error {
                print(error)
            } else if let recordID = recordID {
                print(recordID)
            }
        }
        
//        self.createHouse()
//        self.fetchHouses()
        self.fetchUserData()
    }
    
    func fetchHouses() {
        let query = CKQuery(recordType: "Houses", predicate: NSPredicate(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        self.container.publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            records?.forEach({ (record) in
                guard error == nil else {
                    print(error?.localizedDescription as Any)
                    return
                }
                
                print(record.value(forKey: "name") ?? "ersssss")
            })
        }
    }
    
    func createHouse() {
        let record = CKRecord(recordType: "Houses")
        
        record["name"] = "Casa Amaral"
        record["openKey"] = 1234
        
        self.container.publicCloudDatabase.save(record) { (saved, error) in
            if let error = error {
                print(error)
            }
            
            self.homeCreated = saved?.recordID
            print("Record saved: \(self.homeCreated)")
            
            self.addHouseToUser()
        }
    }
    
    func fetchHouse(for recordId: CKRecord.ID) {
        self.container.publicCloudDatabase.fetch(withRecordID: recordId, completionHandler: { (record, error) in
            guard let record = record, error == nil else {
                print(error!)
                return
            }
            
            print(record.value(forKey: "name")!)
        })
    }
    
    func fetchUserData() {
        self.container.fetchUserRecordID { (recordId, error) in
            guard let recordId = recordId, error == nil else {
                return
            }
            
            self.container.publicCloudDatabase.fetch(withRecordID: recordId, completionHandler: { (record, error) in
                guard let record = record, error == nil else {
                    return
                }
                
                let houseReference = record.value(forKey: "house") as! CKRecord.Reference
                
                self.fetchHouse(for: houseReference.recordID)
                print(record)
            })
            
            self.fetchUserName(for: recordId)
        }
    }
    
    func fetchUserName(for recordID: CKRecord.ID) {
        self.container.requestApplicationPermission(.userDiscoverability) { status, error in
            guard status == .granted, error == nil else {
                return
            }
            
            self.container.discoverUserIdentity(withUserRecordID: recordID) { identity, error in
                guard let components = identity?.nameComponents, error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    let fullName = PersonNameComponentsFormatter().string(from: components)
                    print("The user's full name is \(fullName)")
                }
            }
        }
    }
    
    func addHouseToUser() {
        self.container.fetchUserRecordID { (recordId, error) in
            guard let recordId = recordId, error == nil else {
                return
            }
            
            self.container.publicCloudDatabase.fetch(withRecordID: recordId, completionHandler: { (userRecord, error) in
                guard let userRecord = userRecord, error == nil else { return }
                
                let houseReference = CKRecord.Reference(recordID: self.homeCreated!, action: .none)
                userRecord.setObject(houseReference, forKey: "house")
                
                self.container.publicCloudDatabase.save(userRecord, completionHandler: { (_, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    
                    self.fetchUserData()
                })
            })
        }
    }
    
}


