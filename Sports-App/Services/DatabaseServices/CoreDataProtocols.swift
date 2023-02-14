//
//  CoreDataProtocols.swift
//  Sports-App
//
//  Created by MESHO on 12/02/2023.
//

import CoreData
import Foundation

protocol SAVE_CORE {
    func saveData(leagueC: League, sportId: String)
}

protocol FETCH_CORE {
    func fetchData() -> [NSManagedObject]
}

protocol DELETE_CORE {
    func deleteLeagueFromFavourites(leagueId: Int)
}
