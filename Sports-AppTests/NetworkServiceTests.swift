//
//  NetworkManagerTests.swift
//  Sports-App
//
//  Created by Adham Samer on 14/02/2023.
//
import XCTest
@testable import Sports_App

final class NetworkManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //MARK: League Details
    func testGetTeams() throws {
        let expectaion = expectation(description: "Waiting for the API to get Teams")
        LeagueDetailsService.fetchTeams(completionHandler: { teams in
            guard let teams = teams?.result else
            {
                XCTFail("No Data")
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(teams.count, 0)
            expectaion.fulfill()
            
        }, leagueId: 4, sportId: "football")
        waitForExpectations(timeout: 3 , handler: nil)
    }
    
    func testGetResults() throws {
        let expectaion = expectation(description: "Waiting for the API to get Results")
        LeagueDetailsService.fetchResults(completionHandler: { results in
            guard let results = results?.result else
            {
                XCTFail("No Data")
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(results.count, 0)
            expectaion.fulfill()
            
        }, leagueId: 3, sportId: "football")
        waitForExpectations(timeout: 3 , handler: nil)
    }
    
    func testGetEvents() throws {
        let expectaion = expectation(description: "Waiting for the API to get Events")
        LeagueDetailsService.fetchEvents(completionHandler: { events in
            guard let events = events?.result else
            {
                XCTFail("No Data")
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(events.count, 0)
            expectaion.fulfill()
            
        }, leagueId: 4, sportId: "football")
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testGetLeagues() throws {
        let expectaion = expectation(description: "Waiting for the API to get Events")
        LeaguesService.fetchLeagues(endPoint: "football", completionHandler: { leagues in
            guard let leagues = leagues?.result else
            {
                XCTFail("No Data")
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(leagues.count, 0)
            expectaion.fulfill()
            
        })
        waitForExpectations(timeout: 3, handler: nil)
    }
}

