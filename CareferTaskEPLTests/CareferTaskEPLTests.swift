//
//  CareferTaskEPLTests.swift
//  CareferTaskEPLTests
//
//  Created by Mohamad Shaikhon on 15/04/2023.
//

import XCTest
@testable import CareferTaskEPL

final class CareferTaskEPLTests: XCTestCase {
    var interactor: EplGamesInteractor!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    func testGetPresentAndFutureGames() {
        // Given
        interactor = EplGamesInteractor(repo: LeagueGamesRepository(provider: LeagueGamesProvider()))

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date1 = formatter.date(from: "2023-04-20T12:00:00Z")!
        let date2 = formatter.date(from: "2023-04-20T10:00:00Z")!
        let match1 = Match(area: Area(id: 1, name: "Area 1", code: "A1", flag: ""), competition: Competition(id: 1, name: "Competition 1", code: "C1", type: "", emblem: ""), season: Season(id: 1, startDate: "", endDate: "", currentMatchday: 1), id: 1, utcDate: formatter.string(from: date1), status: Status.finished, matchday: 1, lastUpdated: "", homeTeam: Team(id: 1, name: "Home Team 1", shortName: "", tla: "", crest: ""), awayTeam: Team(id: 2, name: "Away Team 1", shortName: "", tla: "", crest: ""), score: Score(winner: Winner.homeTeam, duration: "", fullTime: TimeScore(home: 2, away: 1), halfTime: TimeScore(home: 1, away: 0)))
        let match2 = Match(area: Area(id: 1, name: "Area 1", code: "A1", flag: ""), competition: Competition(id: 1, name: "Competition 1", code: "C1", type: "", emblem: ""), season: Season(id: 1, startDate: "", endDate: "", currentMatchday: 1), id: 2, utcDate: formatter.string(from: date2), status: Status.finished, matchday: 2, lastUpdated: "", homeTeam: Team(id: 1, name: "Home Team 2", shortName: "", tla: "", crest: ""), awayTeam: Team(id: 2, name: "Away Team 2", shortName: "", tla: "", crest: ""), score: Score(winner: Winner.draw, duration: "", fullTime: TimeScore(home: 1, away: 1), halfTime: TimeScore(home: 1, away: 0)))
        let league = LeagueGamesData(matches: [match1, match2])
        
        // When
        let result = interactor.getPresentAndFutureGames(from: league)
        
        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.id, match2.id)
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
