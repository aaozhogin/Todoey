//
//  AppDelegate.swift
//  Todoey
//
//  Created by Aleksandr Ozhogin on 10/9/19.
//  Copyright © 2019 Aleksandr Ozhogin. All rights reserved.
//

import UIKit
import RealmSwift
//import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        do {
        _ = try Realm()
        } catch {
            print("\(error)")}
//        print(Realm.Configuration.defaultConfiguration.fileURL)
//        
//        let data = Data()
//             data.name = "Alex"
//             data.age = 36
//        
//        do {
//            let realm = try Realm()
//            try realm.write {
//                realm.add(data)
//            }
//        } catch {
//            print("Error initializing new realm, \(error)")
//        }
        
     
        
        
        
        
        return true
    }


//    func applicationWillTerminate(_ application: UIApplication) {
//
//        self.saveContext()
//    }
    
    // MARK: - Core Data stack
    
//    lazy var persistentContainer: NSPersistentContainer = {
//
//        let container = NSPersistentContainer(name: "DataModel")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
    
    // MARK: - Core Data Saving support
    
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
    
}

