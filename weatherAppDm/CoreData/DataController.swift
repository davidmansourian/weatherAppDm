//
//  DataController.swift
//  weatherAppDm
//
//  Created by David on 2022-11-12.
//

import CoreData
import Foundation

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "Datamodel")
    
    
    init(){
        container.loadPersistentStores(completionHandler: {
            description, error in
            if let error = error{
                print("Core Data failed to load:  \(error.localizedDescription)")
            }
        })
    }
}
