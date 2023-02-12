//
//  CoreDataProtocols.swift
//  Sports-App
//
//  Created by MESHO on 12/02/2023.
//

import Foundation
import CoreData

protocol DBSavingProtocol{
    static func saveData(appDelegate: AppDelegate, League: League)
}

protocol DBReadingProtocol{
    static func fetchData(appDelegate: AppDelegate)-> [NSManagedObject]
}

protocol DBDeletingProtocol{
    static func deleteLeagueFromFavourites(appDelegate: AppDelegate, League: League)
}
