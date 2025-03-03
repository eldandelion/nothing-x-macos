//
//  FindMyBudsView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 15/02/23.
//

import SwiftUI
import TipKit
struct FindMyBudsView: View {
    
    @StateObject private var viewModel = FindMyBudsViewViewModel(nothingService: NothingServiceImpl.shared)
    
    @State private var scale: CGFloat = 1.0 // Initial scale for the first circle
    @State private var opacity: Double = 1.0 // Initial opacity for the first circle
    @State private var showSecondCircle: Bool = false // State variable to control the visibility of the second circle
    @State private var secondCircleScale: CGFloat = 1.0 // Initial scale for the second circle
    @State private var secondCircleOpacity: Double = 0.0 // Initial opacity for the second circle

    @State private var isRunning = false
    
    private let popoverTip = HearingLossToolTip()
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    
                    BackButtonView()
                    Spacer()
                    // Quit
                    QuitButtonView()
                    
                }
                .padding(.top, 4)
                .padding(.leading, 4)
                .padding(.trailing, 4)
                
                // Heading
                HStack() {
                    VStack(alignment: .leading) {
                        
                        if true {
                            
                            Text("Find my buds")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                                .multilineTextAlignment(.leading)
                                .textCase(.uppercase)
                            
                            Spacer()
                            
                            
                            
                            // Description
                            HStack {
                                Text("Click above to play sound.")
                                    .lineLimit(1)
                                    .font(.system(size: 10, weight: .light))
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom, 12)
                                
                                Spacer()
                                
                            }
                        }
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 8)
                    Spacer()
                }
                
            }
            .frame(width: 250, height: 230)
            .zIndex(1)
            
            
            VStack {
                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        VStack {
                            if viewModel.isRinging {
                                
                                ZStack {
                                    
                                    Circle()
                                        .stroke(Color.red.opacity(1.0), lineWidth: 0.8)
                                                   .scaleEffect(scale) // Scale effect based on the scale state
                                                   .opacity(opacity) // Opacity effect based on the opacity state
                                                   .onAppear {
                                                       // Start the animation loop when the view appears
                                                      
//
                                                   }
                                                   
                                    
                                    
                                    Circle()
                                        .stroke(Color.red.opacity(1.0), lineWidth: 0.8)
                                        .scaleEffect(secondCircleScale) // Scale effect for the second circle
                                        .opacity(secondCircleOpacity) // Opacity effect for the second circle
                                        .onAppear {
                                            // Start the animation for the second circle

                                        }
                                    
                                    
                                    HStack {
                                        Image(systemName: "stop.fill")
                                            .font(.system(size: 18, weight: .light))
                                            .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                            .foregroundColor(.white)
                                    }
                                    .frame(width: 60, height: 60)
                                    .background(Color(#colorLiteral(red: 0.843137264251709, green: 0.09019608050584793, blue: 0.12941177189350128, alpha: 1)))
                                    .clipShape(Circle()
                                    )
                                    .onTapGesture {
                                        
                                        viewModel.stopRingingBuds()
                                        isRunning = false
                                    }
                                }
                                .frame(width: 60, height: 60)
                           
                                
                            } else {
                                if #available(macOS 14.0, *) {
                                    
                                    HStack {
                                        Image(systemName: "play.fill")
                                            .font(.system(size: 18, weight: .light))
                                            .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                            .foregroundColor(.white)
                                    }
                                    .frame(width: 60, height: 60)
                                    .background(Color(#colorLiteral(red: 0.843137264251709, green: 0.09019608050584793, blue: 0.12941177189350128, alpha: 1)))
                                    .clipShape(Circle())
                                    .popoverTip(popoverTip)
                                    .onTapGesture {
                                        
                                        if (!isRunning) {
                                            isRunning = true
                                            startAnimation()
                                        }
                                        viewModel.ringBuds()
                                    }
                                } else {
                                    HStack {
                                        Image(systemName: "play.fill")
                                            .font(.system(size: 18, weight: .light))
                                            .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                            .foregroundColor(.white)
                                    }
                                    .frame(width: 60, height: 60)
                                    .background(Color(#colorLiteral(red: 0.843137264251709, green: 0.09019608050584793, blue: 0.12941177189350128, alpha: 1)))
                                    .clipShape(Circle())
                                    .onTapGesture {
                                        
                                        if (!isRunning) {
                                            isRunning = true
                                            startAnimation()
                                        }
                                        viewModel.ringBuds()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(.black)
        .frame(width: 250, height: 230)
        .onDisappear {
            viewModel.stopRingingBuds()
        }
    }
    
    private func startAnimation() {
        
        if (!isRunning) {
            return
        }
        // Animate to scale 3 and fade out
        withAnimation(.easeOut(duration: 1)) {
            scale = 3.0
            opacity = 0.0
        }
        
        
        // Show the second circle after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            showSecondCircle = true // Show the second circle
            startSecondCircleAnimation()
            //Start the animation for the second circle
        }
        
        // Delay to allow the scale and fade out to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Reset to original scale and opacity
            
            scale = 1.0
            opacity = 1.0
            
            // Call the function again to create a loop
            startAnimation()
        }
        
        
    }
    
    private func startSecondCircleAnimation() {
        
        if (!isRunning) {
            return
        }
        
        // Animate the second circle to scale 1.5 and fade in
        withAnimation(.easeOut(duration: 1)) {
            secondCircleScale = 3
            secondCircleOpacity = 0.0
        }
        
        // Delay to allow the scale and fade in to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Reset the second circle to original scale and opacity
            
            secondCircleScale = 1.0
            secondCircleOpacity = 1.0
            
        }
    }
}



struct FindMyBudsView_Previews: PreviewProvider {
    static var previews: some View {
        FindMyBudsView()
    }
}


struct HearingLossToolTip : Tip {
    
    var id: String {
        "Hearing loss tool tip"
    }
    
    var title: Text {
        Text("Important hearing damage information")
    }
    
    var message: Text? {
        Text("Make sure your earbuds are not in use before you continue. Activating this feature with earbuds in-ear may cause hearing damage.")
    }
    
    var image: Image? {
        
        let image: Image = Image(systemName: "ear.trianglebadge.exclamationmark")
            
            
        return image
    }
    
    
}
