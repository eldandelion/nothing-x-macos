//
//  EqualizerView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 14/02/23.
//

import SwiftUI

struct EqualizerView: View {
    
    @EnvironmentObject var mainViewModel: MainViewViewModel
    @ObservedObject var viewModel = EqualizerViewViewModel(nothingService: NothingServiceImpl())
    
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
                        viewModel.switchEQ(eq: .BALANCED)
                    }
                    
                    .buttonStyle(EQButton(selected: viewModel.eq == .BALANCED))
                    
                    
                    
                    //MORE BASS
                    Button("MORE BASS") {
                        viewModel.switchEQ(eq: .MORE_BASE)
                    }
                    .buttonStyle(EQButton(selected: viewModel.eq == .MORE_BASE))                }
                
                //HStack - MORE TREBLE | Controls
                HStack(spacing: 5) {
                    //MORE TREBLE
                    Button("MORE TREBLE") {
                        viewModel.switchEQ(eq: .MORE_TREBEL)
                    }
                    .buttonStyle(EQButton(selected: viewModel.eq == .MORE_TREBEL))
                    
                    //VOICE
                    Button("VOICE") {
                        viewModel.switchEQ(eq: .VOICE)
                    }
                    .buttonStyle(EQButton(selected: viewModel.eq == .VOICE))                }
            
            
            
            Spacer()
            
        }
    
        }
        .navigationBarBackButtonHidden(true)
        .padding(4)
        .background(.black)
        .frame(width: 250, height: 230)
        .cornerRadius(8)
        .onAppear {
            viewModel.eq = mainViewModel.nothingDevice?.listeningMode ?? .BALANCED
        }
    }
}




struct EqualizerView_Previews: PreviewProvider {
    static var previews: some View {
        EqualizerView()
    }
}
