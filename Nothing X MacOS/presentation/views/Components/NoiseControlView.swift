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
    
    @State private var noiseDetailsButtonOffset: CGFloat = 24
    @State private var noiseDetailsText: String = "High"
    
    
    
    var body: some View {
        // NOISE CONTROL

        VStack(alignment: .center) {
            
            if viewModel.anc == .anc {
                
                HStack(alignment: .center) {
                    
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 100)
                            .fill(Color(#colorLiteral(red: 0.10980392247438431, green: 0.11372549086809158, blue: 0.12156862765550613, alpha: 1)))
                            .frame(width: 60, height: 12)
                        
                        
                        HStack {
                            
                            ZStack(alignment: .leading) {
                                
                                Rectangle()
                                    .fill(Color(#colorLiteral(red: 0.10980392247438431, green: 0.11372549086809158, blue: 0.12156862765550613, alpha: 1)))
                                    .frame(width: 20, height: 11)
                                    .padding(.leading, 4)
                                    .onTapGesture {
                                        withAnimation {
                                            noiseDetailsButtonOffset = -24
                                            noiseDetailsText = "Low"
                                            viewModel.switchANC(anc: .ON_LOW)
                                        }
                                    }
                                
                                
                                
                                // Set a larger frame for the button
                                Circle()
                                    .fill(Color(#colorLiteral(red: 0.7568627595901489, green: 0.7607843279838562, blue: 0.7686274647712708, alpha: 1)))
                                    .frame(width: 3, height: 3)
                                    .padding(.leading, 4)
                                    .onTapGesture {
                                        withAnimation {
                                            noiseDetailsButtonOffset = -24
                                            noiseDetailsText = "Low"
                                            viewModel.switchANC(anc: .ON_LOW)
                                        }
                                    }
                            }
                            
                            
                            
                            Spacer()
                            
                            //                        Circle()
                            //                            .fill(Color(#colorLiteral(red: 0.7568627595901489, green: 0.7607843279838562, blue: 0.7686274647712708, alpha: 1)))
                            //                            .frame(width: 3, height: 3)
                            //
                            //
                            //
                            //                        Spacer()
                            
                            ZStack(alignment: .trailing) {
                                
                                Rectangle()
                                    .fill(Color(#colorLiteral(red: 0.10980392247438431, green: 0.11372549086809158, blue: 0.12156862765550613, alpha: 1)))
                                    .frame(width: 20, height: 11)
                                    .padding(.trailing, 4)
                                    .onTapGesture {
                                        withAnimation {
                                            noiseDetailsButtonOffset = 24
                                            noiseDetailsText = "High"
                                            viewModel.switchANC(anc: .ON_HIGH)
                                        }
                                    }
                                
                                
                                
                                // Set a larger frame for the button
                                Circle()
                                    .fill(Color(#colorLiteral(red: 0.7568627595901489, green: 0.7607843279838562, blue: 0.7686274647712708, alpha: 1)))
                                    .frame(width: 3, height: 3)
                                    .padding(.trailing, 4)
                                    .onTapGesture {
                                        withAnimation {
                                            noiseDetailsButtonOffset = 24
                                            noiseDetailsText = "High"
                                            viewModel.switchANC(anc: .ON_HIGH)
                                        }
                                    }
                            }
                            
                            
                            
                        }
                        
                        .frame(width: 60, height: 12)
                        
                        
                        Circle()
                            .fill(Color(#colorLiteral(red: 0.7568627595901489, green: 0.7607843279838562, blue: 0.7686274647712708, alpha: 1)))
                            .frame(width: 8, height: 8)
                            .offset(x: noiseDetailsButtonOffset, y: 0)
                            .animation(.bouncy(duration: 0.3), value: noiseDetailsButtonOffset)
                        
                    }
                    
                    
                    Text(noiseDetailsText)
                        .font(.system(size: 10, weight: .light))
                        .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                        .textCase(.uppercase)
                }
                .frame(width: 180)
            } else {
                Text("NOISE CONTROL").font(.custom("5by7", size: 12)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8))).multilineTextAlignment(.center)
                    .padding(.top, 2)
            }
            

          
            
            Spacer()
            
            //ANC Buttons
            VStack {
                
                ZStack {
                    // Background
                    RoundedRectangle(cornerRadius: 100)
                        .fill(Color(#colorLiteral(red: 0.10980392247438431, green: 0.11372549086809158, blue: 0.12156862765550613, alpha: 1)))
                        .frame(width: 180, height: 34)

                    Capsule()
                        .frame(width: 52, height: 28)
                        .foregroundColor(Color(#colorLiteral(red: 0.7568627595901489, green: 0.7607843279838562, blue: 0.7686274647712708, alpha: 1)))
                        .offset(x: viewModel.noiseSelectionOffset, y: 0)
                        .animation(.bouncy(duration: 0.3), value: viewModel.noiseSelectionOffset)
                        .zIndex(0)
               
                    // 3 buttons
                    HStack(spacing: 5) {
                      
                        ForEach(NoiseControlOptions.allCases) { option in
                            Button(action: {
                                // Update the ViewModel's ANC state
                                
                                withAnimation {
                                    switch option {
                                    case .anc:
                                        selectedIndex = 0
                                    case .transparency:
                                        selectedIndex = 1
                                    case .off:
                                        selectedIndex = 2
                                    }
                                }
                              
                                viewModel.switchANC(anc: viewModel.noiseControlOptionsToAnc(option: option))
                                
                    
                            }) {
                                                          
                                Image(systemName: option.icon)
                                    
                                    
                            }
                            .contentShape(Capsule())
                           
                            .buttonStyle(ANCButton(selected: viewModel.anc == option))
                            

                        }
            
                        
                    }
                    .fixedSize()
                    .frame(width: 180, height: 34)
                
                
                }
                
            }
            
        }
        .frame(height: 64)
    }
}

struct NoiseControlView_Previews: PreviewProvider {
    static let store = Store()
   
    static var previews: some View {
        NoiseControlView(selection: .constant(NoiseControlOptions.transparency.rawValue)).environmentObject(store)
    }
}
