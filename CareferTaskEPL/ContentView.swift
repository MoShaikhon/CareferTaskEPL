//
//  ContentView.swift
//  CareferTaskEPL
//
//  Created by Mohamad Shaikhon on 15/04/2023.
//

import SwiftUI

struct EplGamesView: View {
    let games: Games
    var body: some View {
        VStack{
            ControlGroup {
                Text("All games")
                    .font(.title)
                    .padding()
                Text("All games")
                
            }
            List {
                HStack {
                    VStack {
                        Text("dortm")
                            .font(.title2)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                        Text("2")
                            .font(.title2)

                    }
                    .padding()
                    Spacer()
                    Text("VS")
                        .font(.title)
                        .padding()
                    Spacer()
                    VStack {
                        Text("bayern")
                            .font(.title2)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                        Text("2")
                            .font(.title2)

                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
            }
            
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EplGamesView(games: [GamePresentationData(homeTeamName: "Liverpool", awayTeamName: "Manchester United", homeTeamScore: 2, awayTeamScore: 1, matchTime: "2021-04-15T11:30:00Z")])
        //            .previewLayout(.fixed (width: 300, height: 90))
        
    }
}


struct GamePresentationData{
    let homeTeamName: String
    let awayTeamName: String
    let homeTeamScore: Int
    let awayTeamScore: Int
    let matchTime: String
}
typealias Games = [GamePresentationData]

