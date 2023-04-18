//
//  LeagueGamesData.swift
//  CareferTaskEPL
//
//  Created by Mohamad Shaikhon on 16/04/2023.
//

import Foundation

// MARK: - League
struct LeagueGamesData: Codable {
    let matches: [Match]
}

// MARK: - Match
struct Match: Codable {
    let area: Area
    let competition: Competition
    let season: Season
    let id: Int
    let utcDate: String
    let status: Status
    let matchday: Int
    let lastUpdated: String
    let homeTeam, awayTeam: Team
    let score: Score
}

// MARK: - Area
struct Area: Codable {
    let id: Int
    let name, code: String
    let flag: String
}

// MARK: - Team
struct Team: Codable {
    let id: Int
    let name, shortName, tla: String
    let crest: String
}

// MARK: - Competition
struct Competition: Codable {
    let id: Int
    let name, code, type: String
    let emblem: String
}

// MARK: - Score
struct Score: Codable {
    let winner: Winner?
    let duration: String
    let fullTime, halfTime: TimeScore
}

// MARK: - Time
struct TimeScore: Codable {
    let home, away: Int?
}

// MARK: - Season
struct Season: Codable {
    let id: Int
    let startDate, endDate: String
    let currentMatchday: Int
}
enum Winner: String, Codable {
    case awayTeam = "AWAY_TEAM"
    case draw = "DRAW"
    case homeTeam = "HOME_TEAM"
}
enum Status: String, Codable {
    case finished = "FINISHED"
    case postponed = "POSTPONED"
    case scheduled = "SCHEDULED"
    case live = "LIVE"
    case inPlay = "IN_PLAY"
    case paused = "PAUSED"
    case suspended = "SUSPENDED"
    case canceled = "CANCELLED"
    case timed = "TIMED"
}
