//
//  ContentView.swift
//  Othello
//
//  Created by Mind Nichapa on 23/11/2566 BE.
//

import SwiftUI

enum Player: Int {
    case none
    case black
    case white
    
    var color: Color {
        switch self {
        case .black:
            return .black
        case .white:
            return .white
        case .none:
            return .clear
        }
    }
}

struct GaneView: View {
    
    
    
    @State private var currentTurn: Player = .black
    
    
    // Define valueBoard as a 2D array of Color
    //     @State private var valueBoard: [[Color]] = {
    //         var board = Array(repeating: Array(repeating: Color.clear, count: 6), count: 6)
    //         board[2][2] = .black
    //         board[3][3] = .black
    //         board[2][3] = .white
    //         board[3][2] = .white
    //         return board
    //     }()
    @State var valueBoard : [[Color]] = Array(repeating: Array(repeating: .clear, count: 6),count: 6)
    @State var countBlack = 2
    @State var countWhite = 2
    
    
    
    
    
    var body: some View {
        let primary_color = Color.black
        
        
        //header
        Text("🎴OTHELLO")
            .font(.system(size: 55))
            .padding(.horizontal).bold()
            .foregroundColor(primary_color)
        HStack{
            Text("Turn")
                .font(.system(size: 30))
                .padding(.horizontal)
                .foregroundColor(primary_color)
            Chip(color: currentTurn.color)
            
        }
        
        //Board
        VStack {
            VStack(spacing: 1) {
                ForEach(0..<6, id: \.self) { row in
                    HStack(spacing: 1) {
                        ForEach(0..<6, id: \.self) { column in
                            CardView(value: valueBoard[row][column])
                                .foregroundColor(primary_color) // Use primary_color here
                                .onTapGesture {
                                    // Check if the cell is clear and the move is valid
                                    if valueBoard[row][column] == .clear && isValidMove(row: row, column: column, player: currentTurn) {
                                        makeMove(row: row, column: column, player: currentTurn)
                                        currentTurn = (currentTurn == .black) ? .white : .black
                                        updateCounts()
                                    }
                                }
                        }
                    }
                }
            }
            .padding()
            .background(Color.black)
            .padding()
        }
        .onAppear {
            // Set initial values for valueBoard when the view appears
            setupInitialBoard()
        }
        
        
        // Check if the game has ended and display the result
        if isGameEnded() {
                    Text(determineWinner())
                        .font(.system(size: 40, weight: .bold, design: .rounded)) // Bold, rounded font
                        .foregroundColor(.white) // White text color for better contrast
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.green.opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing)) // Gradient background
                        .cornerRadius(15) // Rounded corners
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white, lineWidth: 2) // White border
                        )
                        .shadow(radius: 10) // Shadow for a 3D effect
                        .padding()
                        .transition(.move(edge: .top).combined(with: .opacity)) // Transition effect
                        .animation(.easeInOut(duration: 1.0), value: isGameEnded()) // Updated animation syntax
                }



        
        //footer
        HStack{
            VStack{
                HStack{
                    Text("White")
                        .font(.system(size: 30))
                        .padding(.horizontal)
                        .foregroundColor(primary_color)
                    Chip(color: .white)
                }
                
                Text(String(countWhite))
                    .font(.system(size: 30))
                    .padding(.horizontal)
                    .foregroundColor(primary_color)
            }
            
            Spacer()
            
            VStack{
                HStack{
                    Text("Black")
                        .font(.system(size: 30))
                        .foregroundColor(primary_color)
                    Chip(color: .black)
                }
                
                Text(String(countBlack))
                    .font(.system(size: 30))
                    .padding(.horizontal)
                    .foregroundColor(primary_color)
            }.padding()
        }
        
    }
    func setupInitialBoard() {
            // Set the initial configuration for the board
            valueBoard[2][2] = .white
            valueBoard[3][3] = .white
            valueBoard[2][3] = .black
            valueBoard[3][2] = .black
        }

    func handleTap(row: Int, column: Int) {
        // Only proceed if the move is valid
        if isValidMove(row: row, column: column, player: currentTurn) {
            makeMove(row: row, column: column, player: currentTurn)
            currentTurn = currentTurn == .black ? .white : .black
            updateCounts()
        }
    }



        func isValidMove(row: Int, column: Int, player: Player) -> Bool {
        guard valueBoard[row][column] == .clear else { return false }

        // Check all eight directions
        let directions = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
        for (dx, dy) in directions {
            var x = row + dx
            var y = column + dy
            var foundOpponent = false

            while x >= 0 && x < 6 && y >= 0 && y < 6 && valueBoard[x][y] != .clear {
                if valueBoard[x][y] != player.color {
                    foundOpponent = true
                    x += dx
                    y += dy
                } else {
                    if foundOpponent {
                        return true
                    }
                    break
                }
            }
        }

        return false
    }


    func makeMove(row: Int, column: Int, player: Player) {
        let directions = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
        valueBoard[row][column] = player.color

        for (dx, dy) in directions {
            var x = row + dx
            var y = column + dy
            var path: [(Int, Int)] = []

            while x >= 0 && x < 6 && y >= 0 && y < 6 && valueBoard[x][y] != .clear {
                if valueBoard[x][y] != player.color {
                    path.append((x, y))
                    x += dx
                    y += dy
                } else {
                    if !path.isEmpty {
                        for (px, py) in path {
                            valueBoard[px][py] = player.color
                        }
                    }
                    break
                }
            }
        }
    }


    func updateCounts() {
        countBlack = valueBoard.flatMap { $0 }.filter { $0 == .black }.count
        countWhite = valueBoard.flatMap { $0 }.filter { $0 == .white }.count
    }
    
    func isGameEnded() -> Bool {
        // Check if the board is full
        let isBoardFull = !valueBoard.flatMap { $0 }.contains(.clear)
        
        // Check if neither player has a valid move
        let noValidMovesForBlack = !valueBoard.indices.contains(where: { row in
            valueBoard[row].indices.contains(where: { column in
                isValidMove(row: row, column: column, player: .black)
            })
        })

        let noValidMovesForWhite = !valueBoard.indices.contains(where: { row in
            valueBoard[row].indices.contains(where: { column in
                isValidMove(row: row, column: column, player: .white)
            })
        })

        return isBoardFull || (noValidMovesForBlack && noValidMovesForWhite)
    }
    
    func determineWinner() -> String {
        if countBlack > countWhite {
            return "Black wins!"
        } else if countWhite > countBlack {
            return "White wins!"
        } else {
            return "It's a tie!"
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
    //let content: String
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
    var onClose: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text(message)
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.green.opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(15)
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 2))
                .shadow(radius: 10)

            Button(action: onClose) {
                Text("Close")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(20)
        .shadow(radius: 20)
        .padding(40)
    }
}




#Preview {
    GaneView()
}
