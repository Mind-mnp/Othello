//
//  GameMenu.swift
//  Othello
//
//  Created by warunporn intarachana on 15/12/2566 BE.
//

import SwiftUI

struct GameMenu: View {
    let screenSize = UIScreen.main.bounds.size
    
    var body: some View {
        NavigationView {
                
                
                VStack {
                    DrawCircle(color: .black).position(CGPoint(x: 350.0, y: 60.0))
                    DrawCircle(color: .white).position(/*@START_MENU_TOKEN@*/CGPoint(x: 10.0, y: 10.0)/*@END_MENU_TOKEN@*/)
                    DrawCircle(color: .white).position(CGPoint(x: 80.0, y: 500.0))
                    DrawCircle(color: .black).position(CGPoint(x: 350.0, y: 670.0))
                    DrawCircle(color: .white).position(CGPoint(x: 350.0, y: 230.0))
                    DrawCircle(color: .black).position(CGPoint(x: 30.0, y: 70.0))
                    
                    
                    
                    Image("Othello_pic")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 350)
                        .padding([.top, .leading, .trailing])
                    
                    Text("OTHELLO")
                        .font(.system(size: 80))
                        .bold()
                        
                    
                    NavigationLink(destination: GameView()) {
                        Text("Start Game")
                            .frame(width: 200, height: 30)
                            .font(.title)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(50)
                            .offset(y: -20)
                        
                    }
                    .padding([.bottom, .leading, .trailing])
                    
                    NavigationLink(destination: GameTutorial()) {
                        Text("Tutorial")
                            .frame(width: 200, height: 30)
                            .font(.title)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(50)
                            .offset(y: -20)
                        
                    }
                    .padding([.bottom, .leading, .trailing])
                    
                    Button(action: {
                        exit(0)
                    }) {
                        Text("Quit")
                            .frame(width: 200, height: 30)
                            .font(.title)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(50)
                        
                    }
                    .padding([.bottom, .leading, .trailing])
                    .offset(y: -20)

                    
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 10)) //button
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 236/255, green: 220/255, blue: 197/255))
                .ignoresSafeArea()
            }.navigationBarBackButtonHidden(true)
        }
    }


struct DrawCircle: View{
    let color: Color

    var body: some View {
        if color != .clear{
            ZStack{
                Circle()
                    .frame(width: 150, height: 150)
                    .foregroundColor(color)

            }
                             
        }
                             
    }
}

struct GameMenu_Previews: PreviewProvider {
    static var previews: some View {
        GameMenu()
    }
}
