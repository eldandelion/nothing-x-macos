//
//  EqualizerView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 14/02/23.
//

import SwiftUI

struct EqualizerView: View {
    var body: some View {
        VStack {
            // Back - Heading - Settings | Quit
            HStack {
                // Back
                BackButtonView()
                
                Spacer()
                
                // Settings
                SettingsButtonView()
                
                // Quit
                QuitButtonView()
            }
            
            VStack(alignment: .center) {
                
                VStack(alignment: .leading) {
                    // Heading
                    Text("EQUALISER")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 4)
                    
                    // Desc
                    Text("Customise your sound by selecting your favourite preset.")
                        .font(.system(size: 10, weight: .light))
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                        .multilineTextAlignment(.leading)
                }
                .padding(.leading, 8)
                
                Spacer()
                
                //HStack - Balanced | MORE BASS
                HStack(spacing: 5) {
                    //BALANCED
                    Button("BALANCED") {
                        print("BALANCED Button pressed!")
                    }
                    .buttonStyle(GreyButton())
                    
                    //MORE BASS
                    Button("MORE BASS") {
                        print("MORE BASS Button pressed!")
                    }
                    .buttonStyle(GreyButton())
                }
                
                //HStack - MORE TREBLE | Controls
                HStack(spacing: 5) {
                    //MORE TREBLE
                    Button("MORE TREBLE") {
                        print("MORE TREBLE Button pressed!")
                    }
                    .buttonStyle(GreyButton())
                    
                    //VOICE
                    Button("VOICE") {
                        print("VOICE Button pressed!")
                    }
                    .buttonStyle(GreyButton())
                }
                
                Spacer()

            }
            
        }
        .navigationBarBackButtonHidden(true)
        .padding(4)
        .background(.black)
        .frame(width: 250, height: 230)
        .cornerRadius(8)
    }
}

struct EqualizerView_Previews: PreviewProvider {
    static var previews: some View {
        EqualizerView()
    }
}
