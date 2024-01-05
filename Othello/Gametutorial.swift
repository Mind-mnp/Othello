//
//  Gametutorial.swift
//  Othello
//
//  Created by warunporn intarachana on 6/1/2567 BE.
//

import Foundation
import SwiftUI

struct GameTutorial: View {
    let screenSize = UIScreen.main.bounds.size

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 5) {
                Text("")
                    .font(.system(size: 60))
                    .bold()

                
                Text("Welcome to the Othello Tutorial!")
                    .font(.title)
                    .padding()

                VStack {
                    Text("Placement of Discs")
                        .font(.title2)
                        .bold()
                        .padding(.top)

                    Text("Players alternate placing their colored discs (black and white) on the board. Each turn involves placing one disc on the board with an aim to capture the opponent's discs.")
                        .padding([.bottom, .leading, .trailing])
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(20)
                .padding()

                VStack {
                    Text("Capturing Opponent's Discs")
                        .font(.title2)
                        .bold()
                        .padding(.top)

                    Text("If a player places a disc and forms a line (horizontal, vertical, or diagonal) with another disc of their own color at the other end, any opponent's discs in between are flipped to become the player's color.")
                        .padding([.bottom, .leading, .trailing])
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(20)
                .padding()
                
                VStack {
                    Text("Valid Moves")
                        .font(.title2)
                        .bold()
                        .padding(.top)

                    Text("A player must place their disc adjacent to an opponent's disc so that it forms a line (including diagonals) with another disc of their own color. If a player has no valid moves, they skip their turn.")
                        .padding([.bottom, .leading, .trailing])
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(20)
                .padding()
                
                VStack {
                    Text("Game End")
                        .font(.title2)
                        .bold()
                        .padding(.top)

                    Text("The game ends when the board is filled or neither player can make a valid move. The player with the majority of discs in their color on the board at the end of the game wins.")
                        .padding([.bottom, .leading, .trailing])
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(20)
                .padding()
                
                VStack {
                    Text("Strategy")
                        .font(.title2)
                        .bold()
                        .padding(.top)

                    Text("The key to Othello is strategic placement of discs, controlling corners and edges of the board, and planning moves to limit the opponent's options and flip multiple rows of discs.")
                        .padding([.bottom, .leading, .trailing])
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(20)
                .padding()

                
                NavigationLink(destination: GameMenu()) {
                    Text("Back to Menu")
                        .frame(width: 200, height: 30)
                        .font(.title)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(50)
                }
            }
            .navigationBarBackButtonHidden(true)
            .frame(maxWidth: .infinity)
            .padding()
        }
        .background(Color(red: 236/255, green: 220/255, blue: 197/255))
        .ignoresSafeArea()
    }
}

struct GameTutorial_Previews: PreviewProvider {
    static var previews: some View {
        GameTutorial()
    }
}
