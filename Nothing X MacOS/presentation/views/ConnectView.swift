//
//  ConnectView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 14/02/23.
//

import SwiftUI

struct ConnectView: View {
    
    @State var title: String? = "Failed to connect"
    @State var text: String? = "Make sure device is on and in discovery mode."
    @State var topButtonText: String? = "Retry"
    @State var bottomButtonText: String? = "Cancel"
    
    @StateObject private var viewModel = ConnectViewViewModel(nothingRepository: NothingRepositoryImpl.shared, nothingService: NothingServiceImpl.shared)
    
    var body: some View {
        
        
        ZStack(alignment: .bottom) {
            
            
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
            
            // Bottom sheet overlay
            if viewModel.isFailedToConnectPresented {
                Color.black.opacity(0.4) // Background dimming
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            viewModel.isFailedToConnectPresented = false
                        }
                    }
                    .zIndex(2)
                
                ModalSheetView(isPresented: $viewModel.isFailedToConnectPresented, title: $title, text: $text, topButtonText: $topButtonText, bottomButtonText: $bottomButtonText, action: {
                    viewModel.retryConnect()
                })
                .animation(.easeInOut, value: viewModel.isFailedToConnectPresented) // Animate the appearance
                .offset(y: viewModel.isFailedToConnectPresented ? 0 : 180) // Slide in from the bottom
                .zIndex(3)
                
            }
            
        }
        
        .padding(.top, 4)
        .padding(.leading, 4)
        .padding(.trailing, 4)
        .padding(.bottom, 0)
        .background(.black)
        .frame(width: 250,height: 230)
        .navigationBarBackButtonHidden(true)
        
        
        
    }
        
        
        
}


struct ConnectView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectView()
    }
}
