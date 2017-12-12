//
//  CoreDataManager.swift
//  iOSTraining82017
//
//  Created by Phong Nguyen on 8/11/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import CoreData
import UIKit

let context = CoreDataManager.getAppContext()

final class CoreDataManager {
    
    // MARK: - Properties the name file CoreData.("CoreDataExample")
    private let modelName: String
    init(modelName: String) {
        self.modelName = modelName
    }
    static func getAppDelegate() -> AppDelegate? {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            return delegate
        }
        return nil
    }
    static func getAppContext() -> NSManagedObjectContext? {
        //return getAppDelegate()?.persistentContainer.viewContext
        return nil
    }
    // MARK: - mainManagedObjectContext
    private(set) lazy var mainManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    // MARK: - privateManagedObjectContext
    private(set) lazy var privateManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    // MARK: - ManagedObjectModel
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        return managedObjectModel
    }()
    // MARK: - PersistenStoreCoordinator
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        let documentDirectoryURL  = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let persistentStoreURL = documentDirectoryURL.appendingPathComponent(storeName)
        do {
            let options = [ NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: options)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        return persistentStoreCoordinator
    }()
}

extension CoreDataManager {
    @objc func saveChanges(_ notification: Notification) {
        saveChanges()
    }
    private func setupNotificationhanding() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveChanges(_:)), name: Notification.Name.UIApplicationWillTerminate, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveChanges(_:)), name: Notification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    private func saveChanges() {
        mainManagedObjectContext.performAndWait {
            do {
                if self.mainManagedObjectContext.hasChanges {
                    try self.mainManagedObjectContext.save()
                }
            } catch {
                let saveError = error as NSError
                print(saveError)
            }
            self.privateManagedObjectContext.perform {
                do {
                    if self.privateManagedObjectContext.hasChanges {
                        try self.privateManagedObjectContext.save()
                    }
                } catch {
                    let saveError = error as NSError
                    print(saveError)
                }
            }
        }
    }
}
