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
            VStack (spacing: 1){
                ForEach(0..<6, id: \.self){row in
                    HStack(spacing: 1){
                        ForEach(0..<6, id: \.self){column in
                            
                            CardView(value: valueBoard[row][column])
                                .foregroundColor(primary_color)
                                .onTapGesture {
                                    print(valueBoard[row][column])
                                    if valueBoard[row][column] == .clear{
                                        valueBoard[row][column] = currentTurn.color
                                        if currentTurn == .black {
                                            countBlack += 1
                                        } else {
                                            countWhite += 1
                                        }
                                        currentTurn = (currentTurn == .black) ? .white : .black
                                    }
                                    print("Count of .clear: \(countWhite)")
                                    // print(type(of: currentTurn))
                                    
                                    
                                    
                                }
                        }
                    }
                }
                
            }.padding()
            
        }
        .background(.black)
        .padding()
        .onAppear {
            // Set initial values for valueBoard when the view appears
            valueBoard[2][2] = .black
            valueBoard[3][3] = .black
            valueBoard[2][3] = .white
            valueBoard[3][2] = .white
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


#Preview {
    GaneView()
}
