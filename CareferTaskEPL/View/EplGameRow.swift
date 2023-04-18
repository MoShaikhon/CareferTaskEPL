//
//  EplGameRow.swift
//  CareferTaskEPL
//
//  Created by Mohamad Shaikhon on 18/04/2023.
//

import SwiftUI

struct EplGameRow: View {
    @Binding var game: EplGamePresentationData
    var body: some View {
        VStack{
            HStack {
                VStack {
                    Text(game.homeTeamName)
                        .font(.title2)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                    Text("\(game.homeTeamScore)")
                        .font(.title2)
                }
                .padding()
                Spacer()
                Text("VS")
                    .font(.title)
                    .padding()
                Spacer()
                VStack {
                    Text(game.awayTeamName)
                        .font(.title2)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                    Text(game.awayTeamScore)
                        .font(.title2)
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            if game.shouldShowMatchTimeInsteadOfScore {
                Text("starts at: \(game.matchTime)")
                    .font(.title2)
            }
        }
    }
}

struct EplGameRow_Previews: PreviewProvider {
    static var previews: some View {
        let game = EplGamePresentationData(id: 1, homeTeamName: "man", awayTeamName: "woman", homeTeamScore: "2", awayTeamScore: "3", shouldShowMatchTimeInsteadOfScore: true, matchTime: "14:00")
        EplGameRow(game: .constant(game))
    }
}
