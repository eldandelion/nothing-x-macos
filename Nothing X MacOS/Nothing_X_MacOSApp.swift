//
//  Nothing_X_MacOSApp.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 07/01/23.
//

import SwiftUI


@main
struct Nothing_X_MacOSApp: App {
    @StateObject private var store = Store()
    @StateObject private var viewModel = MainViewViewModel(bluetoothService: BluetoothServiceImpl(), nothingRepository: NothingRepositoryImpl.shared, nothingService: NothingServiceImpl.shared)
    @StateObject private var budsPickerViewModel = BudsPickerComponentViewModel()

    var body: some Scene {
        MenuBarExtra {
            NavigationStack(path: $viewModel.navigationPath.animation(.default)) {
                
                HomeView()
                    .navigationDestination(for: Destination.self) { destination in
                        switch(destination) {
                        case .home: HomeView()
                                .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                        case .equalizer: EqualizerView(eqMode: $viewModel.eqProfiles)
                        case .controls: ControlsView()
                        case .controlsTripleTap: ControlsDetailView(destination: .controlsTripleTap, leftTripleTapAction: $viewModel.leftTripleTapAction, rightTripleTapAction: $viewModel.rightTripleTapAction, leftTapAndHoldAction: $viewModel.leftTapAndHoldAction, rightTapAndHoldAction: $viewModel.rightTapAndHoldAction)
                        case .controlsTapHold: ControlsDetailView(destination: .controlsTapHold,
                                                                  leftTripleTapAction: $viewModel.leftTripleTapAction, rightTripleTapAction: $viewModel.rightTripleTapAction, leftTapAndHoldAction: $viewModel.leftTapAndHoldAction, rightTapAndHoldAction: $viewModel.rightTapAndHoldAction
                        )
                        case .settings: SettingsView()
                        case .findMyBuds: FindMyBudsView()
                        case .discover: DiscoverView()
                                .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                        case .connect: ConnectView()
                            //                                .animation(nil)
                                .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                        case .discover_started: DiscoverStartedView()
                        case .bluetooth_off: BluetoothIsOffView()
                            
                        }
                        
                        
                    }
                    
            }
            .environmentObject(store)
            .environmentObject(viewModel)
            .environmentObject(budsPickerViewModel)
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
