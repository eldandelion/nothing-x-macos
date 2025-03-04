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
    @StateObject private var viewModel = MainViewViewModel(bluetoothService: BluetoothServiceImpl(), nothingRepository: NothingRepositoryImpl.shared, nothingService: NothingServiceImpl.shared) // Observe the ViewModel
    @State private var path = NavigationPath()
    
    
    var body: some Scene {
        MenuBarExtra {
            NavigationStack(path: $path.animation(.default)) {
        
                    HomeView()
                    .navigationDestination(for: Destination.self) { destination in
                        switch(destination) {
                        case .home: HomeView()
                        case .equalizer: EqualizerView(eqMode: $viewModel.eqProfiles)
                        case .controls: ControlsView()
                        case .controlsTripleTap: ControlsDetailView(destination: .controlsTripleTap)
                        case .controlsTapHold: ControlsDetailView(destination: .controlsTapHold)
                        case .settings: SettingsView()
                        case .findMyBuds: FindMyBudsView().task {
                            if #available(macOS 14.0, *) {
                                try? Tips.resetDatastore()
                                try? Tips.configure([.displayFrequency(.immediate)
                                                    ])
                            }
                        }
                        case .discover: DiscoverView()
                        default: ConnectView()
                        }
                    }
                    .navigationDestination(isPresented: $viewModel.isDeviceNotConnected) {
                        ConnectView()
                            .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                            
                    }
                    .navigationDestination(isPresented: $viewModel.areDevicesNotSaved) {
                        DiscoverView()
                            .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                    }
                
            }
            .environmentObject(store)
            .environmentObject(viewModel)
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
