//
//  CoreDataProtocols.swift
//  Sports-App
//
//  Created by MESHO on 12/02/2023.
//

import Foundation
import CoreData

protocol SAVE_CORE{
    static func saveData(appDelegate: AppDelegate, League: League)
}

protocol FETCH_CORE{
    static func fetchData(appDelegate: AppDelegate)-> [NSManagedObject]
}

protocol DELETE_CORE{
    static func deleteLeagueFromFavourites(appDelegate: AppDelegate, League: League)
}
