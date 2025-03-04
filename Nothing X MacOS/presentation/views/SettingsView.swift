//
//  SettingsView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 15/02/23.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewViewModel(nothingService: NothingServiceImpl.shared)
    
    @EnvironmentObject private var mainViewModel: MainViewViewModel
    
    var body: some View {
        VStack {
            
            // Back - Heading - Settings | Quit
            HStack {
                // Back
                BackButtonView()
                
                Spacer()
                
                // Quit
                QuitButtonView()
            }
            
            VStack(alignment: .center) {
                
                HStack {
                    // Heading
                    Text("Device settings")
                        .font(.custom("5by7", size: 16))
                        
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                        .multilineTextAlignment(.center)
                        .textCase(.uppercase)
                    
                    Spacer()
                }
                .padding(.vertical, 4)
                
                VStack(alignment: .center) {
                    // IN-EAR DETECT
                    Toggle("In-ear detection 􀅴", isOn: $viewModel.inEarSwitch)
                        .help(Text("Automatically play audio when earbuds are in and pause when removed"))
                        .onChange(of: viewModel.inEarSwitch) { newValue in
                            // Call the function when the toggle changes
                            viewModel.switchInEarDetection(mode: newValue)
                        }
                    
                    
                    
                    // LOW LAG MODE
                    Toggle("Low lag mode 􀅴", isOn: $viewModel.latencySwitch).help(Text("Minimize latency for an improved gaming experience."))
                        .onChange(of: viewModel.latencySwitch) { newValue in
                            // Call the function when the toggle changes
                            viewModel.switchLatency(mode: newValue)
                        }
                    
                    // Find My Earbuds
                    NavigationLink("FIND MY EARBUDS", value: Destination.findMyBuds)
                        .buttonStyle(FindMyTransparentButton())
                }
                .toggleStyle(SwitchToggleStyle())
                
                Spacer()
                
            }
            .frame(width: 200)
            
        }
        .navigationBarBackButtonHidden(true)
        .padding(4)
        .background(.black)
        .frame(width: 250, height: 230)
        .onAppear {
            if let device = mainViewModel.nothingDevice {
                print("Settings View latency \(device.isLowLatencyOn)")
                print("Settings View in ear \(device.isInEarDetectionOn)")
                viewModel.inEarSwitch = device.isInEarDetectionOn
                viewModel.latencySwitch = device.isLowLatencyOn
            }
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    
    @State private var viewModel = SettingsViewViewModel(nothingService: NothingServiceImpl.shared)
    
    static var previews: some View {
        
        let mainViewModel = MainViewViewModel(bluetoothService: BluetoothServiceImpl(), nothingRepository: NothingRepositoryImpl(), nothingService: NothingServiceImpl.shared)
        
        SettingsView()
            .environmentObject(mainViewModel)
    }
}
