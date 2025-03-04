//
//  NoiseControlView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 15/02/23.
//

import SwiftUI

struct NoiseControlView<SelectedANC: Hashable>: View {
    
    
    @StateObject private var viewModel = NoiseControlViewViewModel(nothingService: NothingServiceImpl.shared)
    
    @Binding var selection: SelectedANC
    
    @State private var selectedIndex: Int = 0 // Track the selected index
       private let buttonWidth: CGFloat = 60 // Width of each button
       private let buttonCount: CGFloat = CGFloat(NoiseControlOptions.allCases.count)
    
    var body: some View {
        // NOISE CONTROL
        VStack(alignment: .center) {
            
            Text("NOISE CONTROL").font(.custom("5by7", size: 12)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8))).multilineTextAlignment(.center)
                .padding(.top, 2)
            
            Spacer()
            
            //ANC Buttons
            VStack {
                
                ZStack {
                    // Background
                    RoundedRectangle(cornerRadius: 100)
                        .fill(Color(#colorLiteral(red: 0.10980392247438431, green: 0.11372549086809158, blue: 0.12156862765550613, alpha: 1)))
                        .frame(width: 180, height: 34)
//                        .offset(x: CGFloat(selectedIndex) * (buttonWidth + 5)) // Adjust offset based on selected index
//                        .animation(.easeInOut(duration: 0.3), value: selectedIndex)
                    
                    
                    // 3 buttons
                    HStack(spacing: 5) {
                        ForEach(NoiseControlOptions.allCases) { option in
                            Button(action: {
                                // Update the ViewModel's ANC state
                                
                                viewModel.anc = option
                                switch option {
                                case .anc:
                                    selectedIndex = 0
                                case .transparency:
                                    selectedIndex = 1
                                case .off:
                                    selectedIndex = 2
                                }
                                viewModel.switchANC(anc: viewModel.noiseControlOptionsToAnc(option: option))
                                
                    
                            }) {
                                Image(systemName: option.icon)
                            }
                            .buttonStyle(ANCButton(selected: viewModel.anc == option))
                        }
                    }
                    .fixedSize()
                    .frame(width: 180, height: 34)
                
                }
                
            }
            
        }
        .frame(width: 200, height: 60)
    }
}

struct NoiseControlView_Previews: PreviewProvider {
    static let store = Store()
   
    static var previews: some View {
        NoiseControlView(selection: .constant(NoiseControlOptions.transparency.rawValue)).environmentObject(store)
    }
}
