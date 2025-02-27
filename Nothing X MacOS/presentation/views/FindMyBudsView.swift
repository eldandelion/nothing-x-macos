//
//  FindMyBudsView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 15/02/23.
//

import SwiftUI

struct FindMyBudsView: View {
    var body: some View {
        VStack {
            
            // Back - Heading - Settings | Quit
            HStack {
                // Back
                BackButtonView()
                
                Spacer()
                
                // Quit
                QuitButtonView()
            }
            
            VStack(alignment: .center) {
                
                HStack {
                    // Heading
                    Text("FIND MY EARBUDS")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                }
                
                Spacer()
                
                VStack(alignment: .center) {
                    // Description
                    Text("Click below to play a sound in the buds.")
                        .lineLimit(1)
                        .font(.system(size: 10, weight: .light))
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                        .multilineTextAlignment(.leading)
                        
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        // Play Button
                        Button(action: {
                            // Your action code here
                            print("Play Button Pressed!")
                            
                        }) {
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 48))
                                .foregroundColor(Color(#colorLiteral(red: 0.843137264251709, green: 0.09019608050584793, blue: 0.12941177189350128, alpha: 1)))
                        }
                        .buttonStyle(BlackImageButtonCicleLarge())
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    // Disclaimer
                    Text("Make sure your earbuds are not in use before you continue. Activating this feature with earbuds in-ear may cause hearing damage.")
                        .font(.system(size: 10, weight: .light))
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                        .multilineTextAlignment(.center)
    
                }
                
                Spacer()

            }
            .frame(width: 200)
            
        }
        .navigationBarBackButtonHidden(true)
        .padding(4)
        .background(.black)
        .frame(width: 250, height: 230)
        .cornerRadius(8)
    }
}

struct FindMyBudsView_Previews: PreviewProvider {
    static var previews: some View {
        FindMyBudsView()
    }
}
