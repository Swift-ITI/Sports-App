//
//  DBManager.swift
//  Sports-App
//
//  Created by MESHO on 12/02/2023.
//

import Foundation
import CoreData

class DBManager: SAVE_CORE, FETCH_CORE, DELETE_CORE{

    static func saveData(appDelegate: AppDelegate, League: League) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Leagues", in: managedContext)
        let league = NSManagedObject(entity: entity!, insertInto: managedContext)
        league.setValue(League.league_name ?? "", forKey: "name")
        league.setValue(League.country_name ?? "", forKey: "country")
        league.setValue(Int(League.league_key ?? 0), forKey: "id")
        league.setValue(League.league_logo, forKey: "logo")
        //league.setValue(League.isLiked, forKey: "bool")
        do{
            try managedContext.save()
            print("Saved!")
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    static func fetchData(appDelegate: AppDelegate) -> [NSManagedObject] {
        var leagues : [NSManagedObject]?
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Leagues")
        // optional predicate
        //let predicate = NSPredicate(format: "title == %@", "Jobs")
        //fetchRequest.predicate = predicate
        do{
            leagues = try managedContext.fetch(fetchRequest)
        }catch let error{
            print(error.localizedDescription)
        }
        return leagues ?? []
        
    }
    
    static func deleteLeagueFromFavourites(appDelegate: AppDelegate, League: League){
        let managedContext = appDelegate.persistentContainer.viewContext
        do{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Leagues")
            fetchRequest.predicate = NSPredicate(format: "id == %@", League.league_key!)
            let league = try managedContext.fetch(fetchRequest)
            managedContext.delete((league as! [NSManagedObject]).first!)
            try managedContext.save()
            print("league deleted")
        } catch let error as NSError{
            print("Error in deleting")
            print(error.localizedDescription)
        }
    }
    
    
    
}
