//
//  URLs.swift
//  Sports-App
//
//  Created by MESHO on 09/02/2023.
//

import Foundation

struct URLService {
    var endPoint: String = ""
    var url: String{
        return "https://apiv2.allsportsapi.com/\(endPoint)/?met=Leagues&APIkey=6006e0bee72004ccef17f23f6ab68d967e8deb5c4340ab2b656fa19f0497cb5a"
    }
    
}

