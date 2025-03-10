//
//  QuitButtonView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 15/02/23.
//

import SwiftUI

struct QuitButtonView: View {
    
    
    @State var title: String? = "Close Application?"
    @State var text: String? = "The application won't be able to communicate with your device."
    @State var topButtonText: String? = "Close"
    @State var bottomButtonText: String? = "Cancel"
    
    @State private var shouldShowCloseAppWarning = false
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            Button(action: {
               
//                shouldShowCloseAppWarning = true
                NSApplication.shared.terminate(nil)
                
            }) {
                Image(systemName: "power.dotted")
                    .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                    .font(.system(size: 16))
            }
            .buttonStyle(TransparentButton())
            .keyboardShortcut("q")
            .focusable(false)
            .padding(.vertical, 8)
            .padding(.trailing, 8)
            
            if shouldShowCloseAppWarning {
                Color.black.opacity(0.4) // Background dimming
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            shouldShowCloseAppWarning = false
                        }
                    }
                    .zIndex(3)
                
                ModalSheetView(isPresented: $shouldShowCloseAppWarning, title: $title, text: $text, topButtonText: $topButtonText, bottomButtonText: $bottomButtonText, action: {
                    
                    NSApplication.shared.terminate(nil)

                }, onCancelAction: {})
                .animation(.easeInOut, value: shouldShowCloseAppWarning) // Animate the appearance
                .offset(y: shouldShowCloseAppWarning ? 0 : 180) // Slide in from the bottom
                .zIndex(4)
            }
        }
        // Quit
        
        
        
    }
        
}

struct QuitButtonView_Previews: PreviewProvider {
    static var previews: some View {
        QuitButtonView()
    }
}
