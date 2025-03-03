//
//  ConnectView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 14/02/23.
//

import SwiftUI

struct ConnectView: View {
    
    @StateObject private var viewModel = ConnectViewViewModel(nothingRepository: NothingRepositoryImpl(), nothingService: NothingServiceImpl.shared)
    
    var body: some View {
        
        
            ZStack {
                
                
                // ear (1)
                
                HStack {
                    DeviceNameDotTextView()
                    Spacer()
                }
                
                .zIndex(1)
                
            
                
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
                            .overlay(
                                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                                    .blendMode(.darken) // Blend mode to darken the image
                            )
                            
                        
                        Spacer(minLength: 15)
                        
                        if viewModel.isLoading {
                            // Show loading spinner
                            ProgressView() // You can customize the text
                                .progressViewStyle(CircularProgressViewStyle())
                                .tint(Color.white)
                                .colorInvert()
                                .scaleEffect(0.6)
                            
                                
                        } else {
                            // Connect Button
                            Button("CONNECT") {
                                viewModel.connect()
                            }
                            .buttonStyle(OffWhiteConnectButton())
                            .focusable(false)
                            
                           
                        }
                        Spacer(minLength: 15)
                    }
                    
                    
                }
                
            }
        .padding(4)
        .background(.black)
        .frame(width: 250,height: 230)
        
        
        
    }
        
        
        
}


struct ConnectView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectView()
    }
}
