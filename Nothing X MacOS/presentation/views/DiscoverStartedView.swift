//
//  DiscoverStartedView.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/9.
//

import SwiftUI

struct DiscoverStartedView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject private var viewModel = DiscoverStartedViewViewModel(nothingService: NothingServiceImpl.shared)
    
    @ObservedObject private var animation = PulsingCirclesAnimation.shared

    
    var body: some View {
   
        
        ZStack {
            
            
            VStack {
                HStack(alignment: .top) {
                    BackButtonView()
                    Spacer()
                }
         
                HStack() {
                    
               
                    
                    VStack(alignment: .leading) {
                        if viewModel.shouldShowDiscoveryMessage {
                            
                            Text("Scanning")
                                .font(.custom("5by7", size: 16))
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                                .multilineTextAlignment(.leading)
                                .textCase(.uppercase)
                            
                            
                            Spacer()
                            Text("Ensure device is in pairing mode.")
                                .lineLimit(1)
                                .font(.system(size: 10, weight: .light))
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 12)
                        } else {
                            
                            //these are hidden
                            Text("Scanning")
                                .font(.custom("5by7", size: 16))
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                                .multilineTextAlignment(.leading)
                                .textCase(.uppercase)
                                .hidden()
                            
                            
                            Spacer()
                            Text("Ensure device is in pairing mode.")
                                .lineLimit(1)
                                .font(.system(size: 10, weight: .light))
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 12)
                                .hidden()
                        }
                        
                    }
                    .padding(.leading, 16)
                    Spacer()
                  
                }
            }
            .navigationBarBackButtonHidden(true)
            .background(.black)
            .frame(width: 250, height: 230)
           
            ZStack(alignment: .bottom) {
                
                if viewModel.shouldPresentModalSheet {
                    
             
                    Color.black.opacity(0.4) // Background dimming
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                viewModel.startDiscovery()
                            }
                        }
                        .zIndex(2)
                    
                    ModalSheetView(isPresented: $viewModel.shouldPresentModalSheet, title: $viewModel.title, text: $viewModel.text, topButtonText: $viewModel.topButtonText, bottomButtonText: $viewModel.bottomButtonText, action: {
                        viewModel.startDiscovery()
                    }, onCancelAction: {
                        dismiss()
                    })
                    .animation(.easeInOut, value: viewModel.shouldPresentModalSheet) // Animate the appearance
                    .offset(y: viewModel.shouldPresentModalSheet ? 0 : 180) // Slide in from the bottom
                    .zIndex(3)
                }
                
            }
            .zIndex(4)
        
            VStack(alignment: .center) {
                
                HStack(alignment: .center) {
                    ZStack {
                        
                        if viewModel.shouldShowDiscoveryCircles {
                            
                            Circle()
                                .stroke(Color.red.opacity(1.0), lineWidth: 0.8)
                                .scaleEffect(animation.scale) // Scale effect based on the scale state
                                .opacity(animation.opacity) // Opacity effect based on the opacity state
                                .onAppear {
                                    animation.isRunning = true
                                    animation.startAnimation()
                                }
                                .onDisappear {
                                    animation.stopAnimation()
                                }
                                .frame(width: 56, height: 56)
                                .offset(x: 0, y: viewModel.discoveryCirclesOffset)
                            
                            Circle()
                                .stroke(Color.red.opacity(1.0), lineWidth: 0.8)
                                .scaleEffect(animation.secondCircleScale) // Scale effect for the second circle
                                .opacity(animation.secondCircleOpacity) // Opacity effect for the second circle
                                .frame(width: 56, height: 56)
                                .offset(x: 0, y: viewModel.discoveryCirclesOffset)
                            
                            HStack {
                                
                            }
                            .frame(width: 56, height: 56)
                            .background(Color(#colorLiteral(red: 0.843137264251709, green: 0.09019608050584793, blue: 0.12941177189350128, alpha: 1)))
                            .clipShape(Circle()
                            )
                            .offset(x: 0, y: viewModel.discoveryCirclesOffset)
                        
                        }
                            
                        
                        if viewModel.shouldShowDevice {
                            
                            if viewModel.shouldShowBudsBackground {
                                
                                HStack {
                                    
                                }
                                .frame(width: 76, height: 76)
                                .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                                .clipShape(Circle()
                                )
                                .offset(x: viewModel.budsBackgroundOffsetX, y: viewModel.budsBackgroundsOffsetY)
                                
                            }
                            
                            
                            Image("ear_1")
                                .scaledToFit()
                                .scaleEffect(viewModel.budsScale)
                                .offset(x: viewModel.budsOffsetX, y: viewModel.budsOffsetY)
                                .onTapGesture {
                                    viewModel.onDeviceSelectClick()
                                }
                            
                            if viewModel.shouldShowDeviceName {
                                
                                Text(viewModel.deviceName)
                                    .lineLimit(1)
                                    .font(.custom("5by7", size: viewModel.deviceNameFontSize))
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                                    .multilineTextAlignment(.leading)
                                    .offset(x: viewModel.deviceNameOffsetX, y: viewModel.deviceNameOffsetY)
                            }

                        }
                        
                    }
                
                
                }
                
            }
            .zIndex(2)
            
            if viewModel.showSetUpButton {
                
                VStack {
                    Spacer()
                    
                    if viewModel.viewState == .connecting {
                        // Show loading spinner
                        ProgressView() // You can customize the text
                            .progressViewStyle(CircularProgressViewStyle())
                            .tint(Color.white)
                            .colorInvert()
                            .scaleEffect(0.6)
                        
                        
                    } else {
                        // Connect Button
                        Button("Set up this device") {
                            viewModel.connectToDevice()
                        }
                        .buttonStyle(OffWhiteConnectButton())
                        .focusable(false)
                        
                        
                    }
                    
                }
                .padding(.bottom, 15)
            }
            
        }
        .frame(width: 250, height: 230)
        .background(Color.black)
        .onAppear {
            viewModel.startDiscovery()
        }
        .onDisappear {
            viewModel.stopDeviceDiscovery()
            
        }
        
    }

}

#Preview {
    DiscoverStartedView()
}
