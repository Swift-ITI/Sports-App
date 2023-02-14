//
//  MockLeagueDetailsTests.swift
//  Sports-AppTests
//
//  Created by MESHO on 15/02/2023.
//

import XCTest

final class MockLeagueDetailsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    
    func testLoadDataFromTeams(){
        MockLeagueDetailsService.fetchTeams(completionHandler: { team in
            guard let team = team else {
                            XCTAssertNil(team)
                            return
                        }
                        XCTAssertNotNil(team , "API Error")
                    }, leagueId: 4, sportId: "football")
    }
    
    func testLoadDataFromEvents(){
        MockLeagueDetailsService.fetchEvents(completionHandler: { event in
            guard let event = event else {
                            XCTAssertNil(event)
                            return
                        }
                        XCTAssertNotNil(event , "API Error")
                    }, leagueId: 4, sportId: "football")

    }
        
    func testLoadDataFromResults(){
        MockLeagueDetailsService.fetchResults(completionHandler: { result in
            guard let result = result else {
                            XCTAssertNil(result)
                            return
                        }
                        XCTAssertNotNil(result , "API Error")
                    }, leagueId: 4, sportId: "football")
    }
    
        
}
