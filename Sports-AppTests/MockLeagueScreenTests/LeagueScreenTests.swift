//
//  League Screen Tests.swift
//  Sports-AppTests
//
//  Created by MESHO on 14/02/2023.
//

import XCTest
@testable import Sports_App

final class League_Screen_Tests: XCTestCase {

    var network: GET_LEAGUES?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        network = LeaguesService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        network = nil
    }

    func testLoadDataForFootball(){
        LeaguesService.fetchLeagues(endPoint: "football") { league in
            XCTAssertNotNil(league)
            XCTAssertNotEqual(league?.count, 0,"APi Failed")
        }
        XCTFail("failed")
    }
    
    
    func testLoadDataForFootball2(){

        let expectation = expectation(description: "waitinng for data")
        LeaguesService.fetchLeagues(endPoint: "football") { league in
            guard let league = league else{
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotNil(league)
            XCTAssertNotEqual(league.count, 0, "API failed")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    


    func testLoadDataForBasketball(){

        let expectation = expectation(description: "waitinng for data")
        LeaguesService.fetchLeagues(endPoint: "basketball") { league in
            guard let league = league else{
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotNil(league)
            XCTAssertNotEqual(league.count, 0, "API failed")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testLoadDataForTennis(){

        let expectation = expectation(description: "waitinng for data")
        LeaguesService.fetchLeagues(endPoint: "tennis") { league in
            guard let league = league else{
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotNil(league)
            XCTAssertNotEqual(league.count, 0, "API failed")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
    func testLoadDataForCricket(){

        let expectation = expectation(description: "waitinng for data")
        LeaguesService.fetchLeagues(endPoint: "cricket") { league in
            guard let league = league else{
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotNil(league)
            XCTAssertNotEqual(league.count, 0, "API failed")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
    func testLoadDataForBaseball(){

        let expectation = expectation(description: "waitinng for data")
        LeaguesService.fetchLeagues(endPoint: "baseball") { league in
            guard let league = league else{
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotNil(league)
            XCTAssertNotEqual(league.count, 0, "API failed")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testLoadDataForAmericanFootball(){

        let expectation = expectation(description: "waitinng for data")
        LeaguesService.fetchLeagues(endPoint: "american-football") { league in
            guard let league = league else{
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotNil(league)
            XCTAssertNotEqual(league.count, 0, "API failed")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
}
