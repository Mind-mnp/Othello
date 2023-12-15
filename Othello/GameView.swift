//
//  ContentView.swift
//  Othello
//
//  Created by Mind Nichapa on 23/11/2566 BE.
//

import SwiftUI

struct GaneView: View {
    @StateObject private var gameLogic = GameLogic()
    @State private var showWinnerPopup = false
    @State private var winnerMessage = ""

    var body: some View {
        let primary_color = Color.black

        VStack {
            // Header
            Text("🎴OTHELLO")
                .font(.system(size: 55))
                .padding(.horizontal).bold()
                .foregroundColor(primary_color)

            HStack {
                Text("Turn")
                    .font(.system(size: 30))
                    .padding(.horizontal)
                    .foregroundColor(primary_color)

                Chip(color: gameLogic.currentTurn.color)
            }

            // Board
            VStack(spacing: 1) {
                ForEach(0..<6, id: \.self) { row in
                    HStack(spacing: 1) {
                        ForEach(0..<6, id: \.self) { column in
                            CardView(value: gameLogic.valueBoard[row][column])
                                .foregroundColor(primary_color)
                                .onTapGesture {
                                    gameLogic.handleTap(row: row, column: column)
                                }
                        }
                    }
                }
            }
            .padding()
            .background(Color.black)
            .padding()

            if gameLogic.isGameEnded() {
                ResultPopup(message: gameLogic.determineWinner(), onRestart: gameLogic.setupInitialBoard)
                    .transition(.scale)
                    .onAppear {
                        winnerMessage = gameLogic.determineWinner()
                        showWinnerPopup = true
                    }
            }

            // Footer
            HStack {
                // White Score
                VStack {
                    HStack {
                        Text("White")
                            .font(.system(size: 30))
                            .padding(.horizontal)
                            .foregroundColor(primary_color)
                        Chip(color: .white)
                    }

                    Text(String(gameLogic.countWhite))
                        .font(.system(size: 30))
                        .padding(.horizontal)
                        .foregroundColor(primary_color)
                }

                Spacer()

                // Black Score
                VStack {
                    HStack {
                        Text("Black")
                            .font(.system(size: 30))
                            .foregroundColor(primary_color)
                        Chip(color: .black)
                    }

                    Text(String(gameLogic.countBlack))
                        .font(.system(size: 30))
                        .padding(.horizontal)
                        .foregroundColor(primary_color)
                }.padding()
            }
        }
        .onAppear {
            gameLogic.setupInitialBoard()
        }
    }
}

struct Chip: View {
    let color: Color

    var body: some View {
        Circle()
            .frame(width: 50, height: 50)
            .foregroundColor(color)
            .overlay(Circle().stroke(Color.black, lineWidth: 1))
            .clipShape(Circle())
    }
}

struct CardView: View {
    var value: Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 65, height: 65)
                .foregroundColor(.green)
            Circle()
                .frame(width: 60, height: 60)
                .foregroundColor(value)
        }
    }
}

struct ResultPopup: View {
    let message: String
    let onRestart: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text(message)
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(15)

            Button("Play Again", action: onRestart)
                .font(.system(size: 30))
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(15)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}

// Preview
struct GaneView_Previews: PreviewProvider {
    static var previews: some View {
        GaneView()
    }
}
