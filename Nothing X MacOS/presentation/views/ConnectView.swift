//
//  ConnectView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 14/02/23.
//

import SwiftUI

struct ConnectView: View {
    var body: some View {
        HStack {
            Spacer(minLength: 5)
            
            // ear (1)
            DeviceNameDotTextView()
            
            VStack {
                
                HStack {
                    Spacer()
                    
                    // Settings
                    SettingsButtonView()
                    
                    // Quit
                    QuitButtonView()
                }
                
                VStack {
                    // Ear 1 Image
                    Image("ear_1")
                    
                    Spacer(minLength: 15)
                    
                    // Connect Button
                    Button("CONNECT") {
                        print("CONNECT Button pressed!")
                    }
                    .buttonStyle(OffWhiteConnectButton())
                    
                    Spacer(minLength: 15)
                }
                
            }
        }
        .padding(4)
        .background(.black)
        .frame(width: 250, height: 230)
        .cornerRadius(8)
    }
        
}

struct ConnectView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectView()
    }
}
