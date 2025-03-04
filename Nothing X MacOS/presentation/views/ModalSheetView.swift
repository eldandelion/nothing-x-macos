//
//  FailedToConnectView.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/4.
//

import Foundation
import SwiftUI

struct ModalSheetView : View {
    @Binding var isPresented: Bool
    @Binding var title: String?
    @Binding var text: String?
    @Binding var topButtonText: String?
    @Binding var bottomButtonText: String?

    let action: () -> Void
    
        var body: some View {
            VStack {
            
                
                VStack {
                    Spacer()
                
                    
                    VStack {
                        
                        if var title = title {
                            Text(title)
                                .font(.custom("5by7", size: 14))
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                                .multilineTextAlignment(.leading)
                                .textCase(.uppercase)
                                .padding(.bottom, 12)
                        }
                        
                        if var text = text {
                            Text(text)
                                .lineLimit(2)
                                .font(.system(size: 10, weight: .light))
                                .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                                .multilineTextAlignment(.center)
                        }
          

                    }
                    .padding(.horizontal, 18)
                    
                    if var topButtonText = topButtonText {
                        Button(topButtonText) {
                            action()
                        }
                        .buttonStyle(OffWhiteConnectButton())
                        .focusable(false)
                        .padding()
                        
                    }
                    
                    if var bottomButtonText = bottomButtonText {
                        Button(bottomButtonText) {
                            withAnimation {
                                isPresented = false
                            }
                        }
                        .buttonStyle(TransparentButton())
                        .focusable(false)
                        .padding(.bottom, 18)
                    }
                  
                }
        
            }
            .frame(width: 250, height: 180)
//            .padding()
            .background(Color(.modalSheet))
//            .cornerRadius(.leading)
            .shadow(radius: 10)
            
            .transition(.move(edge: .bottom)) // Transition effect
            
        }
}


