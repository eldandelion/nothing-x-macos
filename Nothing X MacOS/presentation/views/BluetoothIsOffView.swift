//
//  BluetoothIsOffView.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/10.
//

import SwiftUI

struct BluetoothIsOffView: View {
    
    @State private var viewModel = BluetoothIsOffViewViewModel()
    
    
    var body: some View {
     
        
        ZStack {
           
            VStack(alignment: .center) {
                HStack(alignment: .center) {
                    ZStack {
                
                        Circle()
                            .stroke(Color.red.opacity(1.0), lineWidth: 0.8)
                            .scaleEffect(1.0) // Scale effect based on the scale state
                            .opacity(0.6) // Opacity effect based on the
                            .frame(width: 90, height: 90)
                        
                        Circle()
                            .stroke(Color.red.opacity(1.0), lineWidth: 0.8)
                            .scaleEffect(1.0) // Scale effect based on the scale state
                            .opacity(0.4) // Opacity effect based on the
                            .frame(width: 120, height: 120)
                        
                        Circle()
                            .stroke(Color.red.opacity(1.0), lineWidth: 0.8)
                            .scaleEffect(1.0) // Scale effect based on the scale state
                            .opacity(0.2) // Opacity effect based on the
                            .frame(width: 150, height: 150)
                            
                        
                        HStack {
                            Image("bluetooth_disabled")
                                .resizable() // Make the image resizable
                                .scaledToFit()
                                .scaleEffect(0.3)
                                .font(.system(size: 18, weight: .light))
                                .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                .foregroundColor(.white)
                        }
                        .frame(width: 60, height: 60)
                        .background(Color(#colorLiteral(red: 0.843137264251709, green: 0.09019608050584793, blue: 0.12941177189350128, alpha: 1)))
                        .clipShape(Circle())
                            
                        
                    }
                    
                }
            }
            .zIndex(0)
            
            VStack {
                HStack {
                    BackButtonView()
                    Spacer()
                }
                .zIndex(1)
                
                
                VStack {
                    
                    HStack {
                        
                        Text("Your bluetooth is off")
                            .font(.custom("5by7", size: 16))
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                            .multilineTextAlignment(.leading)
                            .textCase(.uppercase)
                        Spacer()
                    }
                        
                    
                    Spacer()
                    
                }
                .padding(.leading, 16)
                .padding(.trailing, 8)
                .zIndex(1)
                
                Button("Turn on bluetooth") {
                    viewModel.openBluetoothPreferences()
                }
                .buttonStyle(OffWhiteConnectButton())
                .focusable(false)
                .padding(.bottom, 15)
                .zIndex(1)
            }
        }
        .frame(width: 250, height: 230)
        .background(Color.black)
        
          
       
            
         
            
       
    }
}

#Preview {
    BluetoothIsOffView()
}
