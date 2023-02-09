//
//  SportsService.swift
//  Sports-App
//
//  Created by Adham Samer on 08/02/2023.
//

import Alamofire
import Foundation
class SportsService: GET_SPORTS {
    static func fetchSports(completionHandler: @escaping (SportsResult?) -> Void) {
        let headers = [
            "X-RapidAPI-Key": "60ebcd3a19mshf2d7cb17fffa6fcp146ef4jsn18c35c7f3230",
            "X-RapidAPI-Host": "sportscore1.p.rapidapi.com",
        ]
        AF.request("https://sportscore1.p.rapidapi.com/sports", method: .get, headers: HTTPHeaders(headers)).response { response in
            switch response.result {
            case let .success(data):
                do {
                    let json = try JSONDecoder().decode(SportsResult?.self, from: data!)
                    completionHandler(json)
                } catch {
                    print(String(describing: error))
                    completionHandler(nil)
                }
            case let .failure(error):
                print(String(describing: error))
                completionHandler(nil)
            }
        }
    }
}
