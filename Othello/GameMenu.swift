//
//  GameMenu.swift
//  Othello
//
//  Created by warunporn intarachana on 15/12/2566 BE.
//

import SwiftUI

struct GameMenu: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Othello")
                    .font(.largeTitle)
                    .padding()

                NavigationLink(destination: GaneView()) {
                    Text("Start Game")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct GameMenu_Previews: PreviewProvider {
    static var previews: some View {
        GameMenu()
    }
}
