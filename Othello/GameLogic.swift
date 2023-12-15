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
        valueBoard[2][2] = .white
        valueBoard[3][3] = .white
        valueBoard[2][3] = .black
        valueBoard[3][2] = .black
    }

    func handleTap(row: Int, column: Int) {
        if isValidMove(row: row, column: column, player: currentTurn) {
            makeMove(row: row, column: column, player: currentTurn)
            currentTurn = currentTurn == .black ? .white : .black
            updateCounts()
        }
    }

    func isValidMove(row: Int, column: Int, player: Player) -> Bool {
        guard valueBoard[row][column] == .clear else { return false }
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
        let isBoardFull = !valueBoard.flatMap { $0 }.contains(.clear)
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
