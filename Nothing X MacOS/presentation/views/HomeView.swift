//
//  HomeView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 14/02/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var store: Store
//    @EnvironmentObject var viewModel: MainViewViewModel
    
    
    var body: some View {
        ZStack {
            
            HStack {
                DeviceNameDotTextView()
                Spacer()
            }
            
            .zIndex(1)
       

            VStack(alignment: .center) {
                
                // Settings | Quit
                HStack {
                    Spacer()
                    
                    // Settings
                    SettingsButtonView()
                    
                    // Quit
                    QuitButtonView()
                }
                
                
                VStack {
                    Spacer()
                    
                    //HStack - Equaliser | Controls
                    HStack(spacing: 5) {
                        
                        
                        
                        //EQUALISER
                        
                       
                        
                        NavigationLink("EQUALISER", value: Destination.equalizer)
                                .buttonStyle(GreyButton())
                                .focusable(false)
                                
                            
                        //CONTROLS
                        NavigationLink("CONTROLS", value: Destination.controls)
                            .buttonStyle(GreyButton())
                            .focusable(false)
                        
                    }
                    
                    Spacer()
                    
                    // NOISE CONTROL
                    NoiseControlView(selection: $store.noiseControlSelected)
                    
                    Spacer()
                    
                    // Battery Indicator
                    BatteryIndicatorView()
                    
                    Spacer()
                }
                // Compensates for Leading side Spacer + DotTextView
                
                
                
            }
                    
        }
        .padding(4)
        .background(.black)
        .frame(width: 250, height: 230)
        .navigationBarBackButtonHidden(true)
    
    }
        
}

struct HomeView_Previews: PreviewProvider {
    static let store = Store()

    @State static var currentDestination: Destination? = .home
    @ObservedObject var viewModel: MainViewViewModel = MainViewViewModel(bluetoothService: BluetoothServiceImpl(), nothingRepository: NothingRepositoryImpl.shared, nothingService: NothingServiceImpl.shared)

    
    static var previews: some View {
            // Use a Group to allow for multiple previews if needed
        
        HomeView() // Pass the binding
                    .environmentObject(store)
//                    .environmentObject(viewModel)
                    .previewDisplayName("Home View Preview") // Optional: Name the preview
            
        }

}
