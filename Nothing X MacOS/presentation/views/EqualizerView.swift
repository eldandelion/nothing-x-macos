//
//  EqualizerView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 14/02/23.
//

import SwiftUI

struct EqualizerView: View {
    
    
    @ObservedObject var viewModel = EqualizerViewViewModel(nothingService: NothingServiceImpl.shared)
    @Binding var eqMode: EQProfiles
    
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
                        .font(.custom("5by7", size: 16))
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 4)
                        .textCase(.uppercase)
                        .padding(.top, 4)
                    
                    // Desc
                    Text("Customise your sound by selecting your favourite preset.")
                        .font(.system(size: 10, weight: .light))
                        .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                        .multilineTextAlignment(.leading)
                }
                .padding(.leading, 8)
                
                Spacer()
                
                //HStack - Balanced | MORE BASS
                HStack(spacing: 5) {
                    //BALANCED
                    Button("Balanced") {
                        viewModel.switchEQ(eq: .BALANCED)
                    }
                    
                    .buttonStyle(EQButton(selected: eqMode == .BALANCED))
                    
                    
                    
                    //MORE BASS
                    Button("More bass") {
                        viewModel.switchEQ(eq: .MORE_BASE)
                    }
                    .buttonStyle(EQButton(selected: eqMode == .MORE_BASE))                }
                
                //HStack - MORE TREBLE | Controls
                HStack(spacing: 5) {
                    //MORE TREBLE
                    Button("More trebel") {
                        viewModel.switchEQ(eq: .MORE_TREBEL)
                    }
                    .buttonStyle(EQButton(selected: eqMode == .MORE_TREBEL))
                    
                    //VOICE
                    Button("Voice") {
                        viewModel.switchEQ(eq: .VOICE)
                    }
                    .buttonStyle(EQButton(selected: eqMode == .VOICE))                }
            
            
            Spacer()
            
        }
    
        }
        .navigationBarBackButtonHidden(true)
        .padding(4)
        .background(.black)
        .frame(width: 250, height: 230)
       
    }
}


struct EqualizerView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var eqMode: EQProfiles = .BALANCED // State variable for preview

        var body: some View {
            EqualizerView(eqMode: $eqMode) // Pass the binding
                .environmentObject(MainViewViewModel(bluetoothService: BluetoothServiceImpl(), nothingRepository: NothingRepositoryImpl(), nothingService: NothingServiceImpl.shared))
                .previewDisplayName("Equalizer View Preview")
        }
    }

    static var previews: some View {
        PreviewWrapper() // Use the wrapper to create an instance
    }
}
