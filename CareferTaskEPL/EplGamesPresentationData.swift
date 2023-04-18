//
//  EplGamesPresentationData.swift
//  CareferTaskEPL
//
//  Created by Mohamad Shaikhon on 16/04/2023.
//

import Foundation

struct EplDatedGamePresentationData: Identifiable {
    var id = UUID()
    var date: String
    var datedGames: EplGamesPresentationData
}
struct EplGamePresentationData: Identifiable{
    let id: Int
    let homeTeamName: String
    let awayTeamName: String
    let homeTeamScore: String
    let awayTeamScore: String
    let shouldShowMatchTimeInsteadOfScore: Bool
    let matchTime: String
}

typealias EplGamesPresentationData = [EplGamePresentationData]
typealias EplDatedGamesPresentationData = [EplDatedGamePresentationData]

//extension Date: Identifiable{
//    public var id: Date { self }
//
//}
