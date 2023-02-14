//
//  DBManager.swift
//  Sports-App
//
//  Created by MESHO on 12/02/2023.
//

import CoreData
import Foundation
import UIKit

class DBManager: SAVE_CORE, FETCH_CORE, DELETE_CORE {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext: NSManagedObjectContext!
    let entity: NSEntityDescription!

    private static var DBObj: DBManager?
    public static func getInstance() -> DBManager {
        if let instance = DBObj {
            return instance

        } else {
            DBObj = DBManager()
            return DBObj!
        }
    }

    private init() {
        managedContext = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "Leagues", in: managedContext)
    }

    func saveData(leagueC: League, sportId: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Leagues", in: managedContext) else { return }
        let league = NSManagedObject(entity: entity, insertInto: managedContext)

        league.setValue(leagueC.league_name ?? "", forKey: "name")
        league.setValue(leagueC.country_name ?? "", forKey: "country")
        league.setValue(Int(leagueC.league_key ?? 0), forKey: "id")
        league.setValue(leagueC.league_logo, forKey: "logo")
        league.setValue(sportId, forKey: "sport")
        
        do {
            try managedContext.save()
            print("Saved!")
        } catch{
            print(error.localizedDescription)
        }
    }

    func fetchData() -> [NSManagedObject] {
        var leagues: [NSManagedObject]?
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Leagues")
        do {
            leagues = try managedContext.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
        return leagues ?? []
    }

    func deleteLeagueFromFavourites(leagueId: Int) {
        var leagues = fetchData()
        for league in leagues {
            if league.value(forKey: "id") as! Int == leagueId{
                managedContext.delete(league)
                try? managedContext.save()
            }
        }
    }
}
