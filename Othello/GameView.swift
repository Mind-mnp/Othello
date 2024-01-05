//
//  ContentView.swift
//  Othello
//
//  Created by Mind Nichapa on 23/11/2566 BE.
//

import SwiftUI

struct GameView: View {
    @StateObject private var gameLogic = GameLogic()
    @State private var showWinnerPopup = false
    @State private var winnerMessage = ""

    var body: some View {
        let primary_color = Color.black
        let secondary_color = Color(red: 37/255, green: 33/255, blue: 34/255)
        let boardgame_color = Color(red: 49/255, green: 48/255, blue: 48/255)

        ZStack{
            VStack(spacing: 4) {
                
                // Header
                Text("OTHELLO")
                    .font(.system(size: 70))
                    .padding(.horizontal).bold()
                    .foregroundColor(primary_color)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 40, trailing: 10))
                  //Use for check Potential Moves
                //Text("Potential Moves: \(gameLogic.countPotentialMoves(for: gameLogic.currentTurn))")
                       //.font(.headline)
                       // .foregroundColor(.primary)
                VStack(spacing: 4) {
                    // White Score
                    VStack {
                        HStack {
                            Text(String(gameLogic.countWhite) + " - White" )
                                .font(.system(size: 40))
                                .padding(.horizontal)
                                .foregroundColor(.white)
                            
                            // Chip(color: .white)
                        }
                        .frame(width: 300, height: 30)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(gameLogic.currentTurn.color == .white ? .gray : .clear)
                                .blur(radius: 4)
                                .offset(x: 3, y: 4)
                        )
                        
                    }
                    Spacer()
                            .frame(height: 10)
                    
                    
                    // Green
                    ForEach(0..<6, id: \.self) { row in
                           HStack(spacing: 1) {
                               //Config this loop for advice
                               ForEach(0..<6, id: \.self) { column in
                                   // set potentialMove
                                   let potentialMove = gameLogic.isPotentialMove(row: row, column: column)

                                   // Create board with value and advice
                                   CardView(value: gameLogic.valueBoard[row][column], isPotentialMove: potentialMove)
                                       .onTapGesture {
                                           gameLogic.handleTap(row: row, column: column)
                                       }
                               }
                           }
                       }
                    Spacer()
                            .frame(height: 10)

                    
                    // Black Score
                    HStack {
                        Text(String(gameLogic.countBlack) + " - Black" )
                            .font(.system(size: 40))
                            //.padding(.horizontal)
                            .foregroundColor(.white)
                    }
                    .frame(width: 300, height: 30)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(gameLogic.currentTurn.color == .black ? .gray : .clear)
                            .blur(radius: 4)
                            
                    )
                    
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                    .fill(boardgame_color)
                )
                
                
            } //container
            
            if gameLogic.isGameEnded() {
                ResultPopup(message: gameLogic.determineWinner(), onRestart: 
                                gameLogic.setupInitialBoard)
                    .transition(.scale)
                    .onAppear {
                        winnerMessage = gameLogic.determineWinner()
                        showWinnerPopup = true
                    }
                
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 236/255, green: 220/255, blue: 197/255))
        .ignoresSafeArea()
        .onAppear {
            gameLogic.setupInitialBoard()
//            gameLogic.testcase()
        }
    }
}

struct Chip: View {
    let color: Color

    var body: some View {
        if color != .clear{
            ZStack{
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(color)
                    
                Circle()
                    .frame(width: 40, height: 50)
                    .foregroundColor(color)
                    .overlay(Circle().stroke(color == .white ? .black: .gray))
                    .blur(radius: 2)
                    .offset(x: 2, y: 2)
                    .clipShape(Circle())
            }
                             
        }
                             
    }
}

struct CardView: View {
    var value: Color
    var isPotentialMove: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 55, height: 55)
                // if player can place chip its will be blue color
                .foregroundColor(isPotentialMove ? Color(red: 144/255, green: 238/255, blue: 144/255).opacity(0.3) : Color(red: 11/255, green: 102/255, blue: 90/255))

            
            // Chip
            Chip(color: value)
        }
    }
}


struct ResultPopup: View {
    let message: String
    let onRestart: () -> Void

    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray)
                .ignoresSafeArea()
                .opacity(0.5)
            VStack(spacing: 30) {
                Text("🏆 " + message)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .padding()
                    .cornerRadius(15)

                Button("Play Again", action: onRestart)
                    .font(.system(size: 30))
                    .frame(width: 200, height: 30)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 20)
            .opacity(1)
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(.gray)
//        .opacity(0.5)
//        .ignoresSafeArea()
        
        
    }
}

// Preview
struct GaneView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
