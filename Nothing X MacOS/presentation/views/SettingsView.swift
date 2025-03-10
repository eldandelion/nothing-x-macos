//
//  SettingsView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 15/02/23.
//

import SwiftUI

struct SettingsView: View {
    
    @State var title: String? = "Forget This Device?"
    @State var text: String? = nil
    @State var topButtonText: String? = "Forget"
    @State var bottomButtonText: String? = "Cancel"
    
    
    @StateObject private var viewModel = SettingsViewViewModel(nothingService: NothingServiceImpl.shared, nothingRepository: NothingRepositoryImpl.shared)
    
    @EnvironmentObject private var mainViewModel: MainViewViewModel
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            VStack(spacing: 0) {
                
                // Back - Heading - Settings | Quit
                HStack {
                    // Back
                    BackButtonView()
                 
                    Spacer()
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading) {
                        
                        HStack {
                            // Heading
                            Text("Device settings")
                                .font(.custom("5by7", size: 16))
                            
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                                .multilineTextAlignment(.center)
                                .textCase(.uppercase)
                            
                            Spacer()
                        }
                        .padding(.vertical, 6)
                        
                        VStack(alignment: .leading) {
                        
                        if viewModel.isNothingDeviceAccessible {
                            
                     
                                Text("Advanced features")
                                    .font(.system(size: 10, weight: .medium))
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    .textCase(.uppercase)
                                    .padding(.top, 16)
                                // IN-EAR DETECT
                                
                                VStack(alignment: .leading) {
                                    Toggle("In-ear detection", isOn: $viewModel.inEarSwitch)
                                        .onChange(of: viewModel.inEarSwitch) { newValue in
                                            // Call the function when the toggle changes
                                            viewModel.switchInEarDetection(mode: newValue)
                                        }
                                    
                                    Text("Automatically play audio when earbuds are in and pause when removed.")
                                        .font(.system(size: 10, weight: .light))
                                        .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                        .padding(.trailing, 64)
                                }
                                .padding(.vertical, 6)
                                
                                VStack(alignment: .leading) {
                                    Toggle("Low lag mode", isOn: $viewModel.latencySwitch)
                                        .onChange(of: viewModel.latencySwitch) { newValue in
                                            // Call the function when the toggle changes
                                            viewModel.switchLatency(mode: newValue)
                                        }
                                    
                                    Text("Minimize latency for an improved gaming experience.")
                                        .font(.system(size: 10, weight: .light))
                                        .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                        .padding(.trailing, 64)
                                }
                                .padding(.vertical, 6)
                                
                                
                                // LOW LAG MODE
                                
                                
                                // Find My Earbuds
                                NavigationLink("FIND MY EARBUDS", value: Destination.findMyBuds)
                                    .buttonStyle(FindMyTransparentButton())
                                    .padding(.bottom, 8)
                                
                                Rectangle()
                                    .fill(Color(#colorLiteral(red: 0.07009194046, green: 0.07611755282, blue: 0.08425947279, alpha: 1))) // Set the color of the line
                                    .frame(height: 0.8)
                            }
                            
                            Text("Device details")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .textCase(.uppercase)
                                .padding(.top, 8)
                                
                            
                            VStack(alignment: .leading) {
                                Text("Device name")
                                    .font(.system(size: 10, weight: .light))
                                    .textCase(.uppercase)
                                    .padding(.bottom, 1)
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                                    
                                
                                Text(viewModel.name)
                                    .font(.system(size: 10, weight: .light))
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    
                            }
                            .padding(.top, 8)
                            .padding(.vertical, 6)
                            
                            VStack(alignment: .leading) {
                                Text("Bluetooth address")
                                    .font(.system(size: 10, weight: .light))
                                    .textCase(.uppercase)
                                    .padding(.bottom, 1)
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                                
                                Text(viewModel.mac)
                                    .font(.system(size: 10, weight: .light))
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    .textCase(.uppercase)
                                    
                            }
                            .padding(.vertical, 6)
                            
                            VStack(alignment: .leading) {
                                Text("Serial number")
                                    .font(.system(size: 10, weight: .light))
                                    .textCase(.uppercase)
                                    .padding(.bottom, 1)
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                                
                                Text(viewModel.serial)
                                    .font(.system(size: 10, weight: .light))
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    
                            }
                            .padding(.vertical, 6)
                            
                            VStack(alignment: .leading) {
                                Text("Firmware version")
                                    .font(.system(size: 10, weight: .light))
                                    .textCase(.uppercase)
                                    .padding(.bottom, 1)
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                                
                                Text(viewModel.firmware)
                                    .font(.system(size: 10, weight: .light))
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    
                            }
                            .padding(.vertical, 6)
                           
                                
                        }
                        .toggleStyle(SwitchToggleStyle())
                        
                        Spacer()
                        
                        Button("Forget") {
                            withAnimation {
                                viewModel.shouldShowForgetDialog = true
                            }
                        }
                        .buttonStyle(GreyButtonLarge())
                        .focusable(false)
                        .padding(.vertical, 16)
                    }
                }
                .frame(width: 200)
                
                
                
            }
            .navigationBarBackButtonHidden(true)
            
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
            if viewModel.shouldShowForgetDialog {
                Color.black.opacity(0.4) // Background dimming
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            viewModel.shouldShowForgetDialog = false
                        }
                    }
                    .zIndex(2)
                
                ModalSheetView(isPresented: $viewModel.shouldShowForgetDialog, title: $title, text: $text, topButtonText: $topButtonText, bottomButtonText: $bottomButtonText, action: {
                    
                    
                    //notify app that there is no devices saved anymore
                    
                    withAnimation {
                        viewModel.forgetDevice()
                        viewModel.shouldShowForgetDialog = false
                    }

                }, onCancelAction: {})
                .animation(.easeInOut, value: viewModel.shouldShowForgetDialog) // Animate the appearance
                .offset(y: viewModel.shouldShowForgetDialog ? 0 : 180) // Slide in from the bottom
                .zIndex(2)
            }
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    
    @State private var viewModel = SettingsViewViewModel(nothingService: NothingServiceImpl.shared,
                                                         nothingRepository: NothingRepositoryImpl.shared)
    
    static var previews: some View {
        
        let mainViewModel = MainViewViewModel(bluetoothService: BluetoothServiceImpl(), nothingRepository: NothingRepositoryImpl.shared, nothingService: NothingServiceImpl.shared)
        
        SettingsView()
            .environmentObject(mainViewModel)
    }
}
