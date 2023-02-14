//
//  MockLeaguesTest.swift
//  Sports-AppTests
//
//  Created by MESHO on 14/02/2023.
//

import XCTest
@testable import Sports_App

final class MockLeaguesServicesTest: XCTestCase {
    
    var network: GET_LEAGUES?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        network = MockLeagueService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        network = nil
    }


    func testLoadDataFromURL(){
        MockLeagueService.fetchLeagues(endPoint: "football") { league in
            guard let league = league else {
                XCTAssertNil(league)
                return
            }
            XCTAssertNotNil(league , "API Error")
        }
    }
    
    
}
