//
//  EplGamesViewModel.swift
//  CareferTaskEPL
//
//  Created by Mohamad Shaikhon on 16/04/2023.
//

import Foundation

@MainActor
class EplGamesViewModel: ObservableObject{
    
    @Published var eplGames: EplDatedGamesPresentationData = []
    @Published var favoriteEplGames: EplDatedGamesPresentationData = []
    
    private let interactor: EplGamesInteracting
    init(interactor: EplGamesInteracting) {
        self.interactor = interactor
    }
    func getEplGames() async {
        guard let eplDomainGames = await interactor.loadGames() else {return}
        guard let adaptedGames = adapt(from: eplDomainGames) else {return}
        eplGames = adaptedGames
    }
    func getfavoriteEplGames(){
        
    }
    func addFavoriteEplGame(){
        
    }
}

extension EplGamesViewModel: Adapting{
    func adapt(from data: LeagueDatedGamesDomainData) -> EplDatedGamesPresentationData? {
        let keys = data.datedGames.keys
        var adaptedData: EplDatedGamesPresentationData = []
        
        keys.forEach{key in
            guard let games = data.datedGames[key]?.map({EplGamePresentationData(id: $0.id, homeTeamName: $0.homeTeam.shortName, awayTeamName: $0.awayTeam.shortName, homeTeamScore: $0.score.fullTime.home == nil ? "-" : String($0.score.fullTime.home!), awayTeamScore: $0.score.fullTime.away == nil ? "-" : String($0.score.fullTime.away!), shouldShowMatchTimeInsteadOfScore: $0.score.fullTime.home == nil, matchTime: $0.utcDate.getTimeString() ?? "unknown")}) else {return }
            adaptedData.append(EplDatedGamePresentationData(date: key.dateStringFromDate() , datedGames: games))
           
        }
        return adaptedData
    }
    
    typealias FromType = LeagueDatedGamesDomainData
    
    typealias ToType = EplDatedGamesPresentationData
    

}

