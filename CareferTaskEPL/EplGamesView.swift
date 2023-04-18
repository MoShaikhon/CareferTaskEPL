//
//  ContentView.swift
//  CareferTaskEPL
//
//  Created by Mohamad Shaikhon on 15/04/2023.
//

import SwiftUI

struct EplGamesView: View {
    @StateObject var viewModel: EplGamesViewModel = EplGamesViewModel(interactor: EplGamesInteractor(repo: LeagueGamesRepository(provider: LeagueGamesProvider())))
    var body: some View {
        VStack{
            ControlGroup {
                Text("All games")
                    .font(.title)
                    .padding()
                Text("Favorites")
                    .onTapGesture {
//                        viewModel.
                    }
                
            }
            List {
                ForEach($viewModel.eplGames, id: \.date) { $eplGame in
                    Section {
                        Text(eplGame.date)
                        ForEach($eplGame.datedGames){ game in
                            EplGameRow(game: game)
                            
                            
                        }
                    }
                }
            }.task{
                await viewModel.getEplGames()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EplGamesView()
        //            .previewLayout(.fixed (width: 300, height: 90))
        
    }
}
