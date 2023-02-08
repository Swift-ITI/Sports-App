//
//  APIServices.swift
//  Sports-App
//
//  Created by Adham Samer on 08/02/2023.
//

import Foundation
protocol GET_SPORTS {
    static func fetchSports(completionHandler: @escaping (SportsResult?) -> Void)
}
