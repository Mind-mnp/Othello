//
//  GameLogic.swift
//  Othello
//
//  Created by warunporn intarachana on 15/12/2566 BE.
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

class GameLogic: ObservableObject {
    @Published var valueBoard: [[Color]] = Array(repeating: Array(repeating: .clear, count: 6), count: 6)
    @Published var countBlack = 2
    @Published var countWhite = 2
    @Published var currentTurn: Player = .black

    init() {
        setupInitialBoard()
    }
    

    func setupInitialBoard() {
        // Clear the entire board
            for row in 0..<valueBoard.count {
                for column in 0..<valueBoard[row].count {
                    valueBoard[row][column] = .clear
                }
            }
        //Initial state
        valueBoard[2][2] = .white
        valueBoard[3][3] = .white
        valueBoard[2][3] = .black
        valueBoard[3][2] = .black
        
        updateCounts()
    }
    
    func testcase(){
        // test case white win
        valueBoard = [[.black, .white, .white, .white, .white, .clear], [.white, .white, .white, .white, .black, .white],[.white, .black, .white, .white, .black, .white], [.white, .white, .black, .white, .white, .white], [.black, .black, .white, .black, .white, .white], [.black, .white, .white, .white, .white, .white]]
    }
    
    //Use for advice player
    func isPotentialMove(row: Int, column: Int) -> Bool {
    return isValidMove(row: row, column: column, player: currentTurn)
    }
    
    //Count can move or not
    func countPotentialMoves(for player: Player) -> Int {
        var count = 0
        for row in 0..<valueBoard.count {
            for column in 0..<valueBoard[row].count {
                if isValidMove(row: row, column: column, player: player) {
                    count += 1
                }
            }
        }
        return count
    }



    func handleTap(row: Int, column: Int) {
        //Use delay one second for check countPotentialMoves == 0 or not
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 1)  {
                // If the current player has no potential moves left, switch turns
                if self.countPotentialMoves(for: self.currentTurn) == 0 && self.isGameEnded() != true  {
                    self.currentTurn = self.currentTurn == .black ? .white : .black
                }}
        
        //Manage table
        if isValidMove(row: row, column: column, player: currentTurn) {
            makeMove(row: row, column: column, player: currentTurn)
            currentTurn = currentTurn == .black ? .white : .black
            updateCounts()
        }
        
    }
    //Check for game rule
    func isValidMove(row: Int, column: Int, player: Player) -> Bool {
        // Topleft, Top, Topright, Right, Underright, Under, UnderLeft, Left
        let directions = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
        guard valueBoard[row][column] == .clear else { return false }
        let opponentColor = player == .black ? Color.white : Color.black
        
        
        for (dx, dy) in directions {
            var x = row
            var y = column
            var foundOpponent = false
            
            x += dx
            y += dy

            while x >= 0 && x < 6 && y >= 0 && y < 6 && valueBoard[x][y] == opponentColor {
                foundOpponent = true
                x += dx
                y += dy
            }
            
            if foundOpponent && x >= 0 && x < 6 && y >= 0 && y < 6 && valueBoard[x][y] == player.color {
                return true
            }
        }
        
        return false
    }


    func makeMove(row: Int, column: Int, player: Player) {
        // Topleft, Top, Topright, Right, Underright, Under, UnderLeft, Left
        let directions = [(-1, -1), (-1, 0), (-1, 1), (0, 1), (1, 1), (1, 0), (1, -1), (0, -1),  ]
        valueBoard[row][column] = player.color
        for (dx, dy) in directions {
            var x = row + dx
            var y = column + dy
            var path: [(Int, Int)] = []
         // Check Chip is on board and table is clear
            while x >= 0 && x < 6 && y >= 0 && y < 6 && valueBoard[x][y] != .clear {
                // Check near chip on board is the same color
                if valueBoard[x][y] != player.color {
                    path.append((x, y))
                    x += dx
                    y += dy
                } else {
                    // if path is not empty change chip on board with row and coloumn to current player
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
        //Use flatmap for tranform array to single number
        countBlack = valueBoard.flatMap { $0 }.filter { $0 == .black }.count
        countWhite = valueBoard.flatMap { $0 }.filter { $0 == .white }.count
    }

    func isGameEnded() -> Bool {
        // full == don't have .clear => true
        let isBoardFull = !valueBoard.flatMap { $0 }.contains(.clear)
        
        //
        let noValidMovesForBlack = !valueBoard.indices.contains { row in
            valueBoard[row].indices.contains { column in
                isValidMove(row: row, column: column, player: .black)
            }
        }
        
        let noValidMovesForWhite = !valueBoard.indices.contains { row in
            valueBoard[row].indices.contains { column in
                isValidMove(row: row, column: column, player: .white)
                
            }
        }
        
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
