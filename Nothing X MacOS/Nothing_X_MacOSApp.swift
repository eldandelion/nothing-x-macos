//
//  Nothing_X_MacOSApp.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 07/01/23.
//

import SwiftUI
import TipKit

@main
struct Nothing_X_MacOSApp: App {
    @StateObject var store = Store()
    @StateObject private var viewModel = MainViewViewModel(bluetoothService: BluetoothServiceImpl(), nothingRepository: NothingRepositoryImpl(), nothingService: NothingServiceImpl()) // Observe the ViewModel
    

    
    var body: some Scene {
        MenuBarExtra {
            NavigationStack {
                // Use the ViewModel's currentDestination for navigation
                if let destination = viewModel.currentDestination {
                    switch destination {
                    case .home:
                        HomeView()
                            .navigationDestination(for: Destination.self) { destination in
                                                   switch(destination) {
                                                       case .home: HomeView()
                                                       case .equalizer: EqualizerView()
                                                       case .controls: ControlsView()
                                                       case .controlsTripleTap: ControlsDetailView(destination: .controlsTripleTap)
                                                       case .controlsTapHold: ControlsDetailView(destination: .controlsTapHold)
                                                       case .settings: SettingsView()
                                                   case .findMyBuds: FindMyBudsView().task {
                                                       if #available(macOS 14.0, *) {
                                                           try? Tips.resetDatastore()
                                                           try? Tips.configure([.displayFrequency(.immediate)
                                                                               ])
                                                       } else {
                                                           // Fallback on earlier versions
                                                       }
                                                   }
                                                   case .discover: DiscoverView()
                                                       
                                                    default: ConnectView()
                                                           
                                                           
                                                       
                                                   }
                                               }
            
             
                    case .settings:
                        SettingsView()
                    case .connect:
                        ConnectView()
                    
                    case .discover:
                        DiscoverView()
                            
                    default:
                        DiscoverView()
                            
                    }
                    
                } else {
                    // Default view if no destination is set
                    DiscoverView()
                        
                }
            
           
                
            }
            .environmentObject(store)
            .environmentObject(viewModel)
            .onChange(of: viewModel.currentDestination) { newDestination in
                // Handle any additional logic when the destination changes, if needed
            }
            .frame(width: 250, height: 230)
            
            

            
            
        } label: {
            
            if (viewModel.rightBattery != nil && viewModel.rightBattery != nil) {
                Label("\(Double((viewModel.leftBattery ?? 0.0) + (viewModel.rightBattery ?? 0.0)) / 2.0, specifier: "%.0f")%", image: "nothing.ear.1")
                    .labelStyle(.titleAndIcon)
            } else {
                Label("", image: "nothing.ear.1")
                    .labelStyle(.titleAndIcon)
            }

        }
        .menuBarExtraStyle(.window)
        
        
    
    }
}
