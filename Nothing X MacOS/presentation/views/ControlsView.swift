//
//  ControlsView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 14/02/23.
//

import SwiftUI




struct ControlsView: View {
    @EnvironmentObject var store: Store
    @State private var scaleButtonRight: CGFloat = 0.9
    @State private var scaleButtonLeft: CGFloat = 1.2
    @State private var isLeftDarken = false
    @State private var isRightDarken = true
    @State private var leftButtonOffset: CGFloat = 5
    @State private var rightButtonOffset: CGFloat = 5
    @State private var selectedBudText = "Left"

    @EnvironmentObject var mainViewModel: MainViewViewModel
    
    
    
    
    var body: some View {
        VStack(spacing: 0) {
            // Back - Heading - Settings | Quit
            
                
            ZStack(alignment: .top) {
                
           
            HStack {
                
                // Back
                BackButtonView()
             
                
                Spacer()
                
            }
            .background(
                      LinearGradient(gradient: Gradient(colors: [Color.black.opacity(1.0), Color.black.opacity(0.0)]), startPoint: .top, endPoint: .bottom)
                  )
//            .background(
//                        ZStack {
//                            // Background Color
//                            Color.black.opacity(0.05) // More transparent base color for the glass effect
//                                .edgesIgnoringSafeArea(.all)
//                            
//                            // Blur Effect
//                           // Use the behindWindow blur effect
//                            
//                            // Optional: Add a semi-transparent overlay
//                            Color.black.opacity(0.1) // More transparent overlay for glass effect
////                            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(1.0), Color.black.opacity(0.0)]), startPoint: .top, endPoint: .bottom)
//                        }
//                    )
            .zIndex(1)
                
        
          
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    BudsPickerComponent(action: {selection in })
                        
                }
                .padding(.top, 32)
          

                
                Spacer()
                
                
                VStack(alignment: .center) {
                    // Left - Right
//                    BudsSidePickerView(selection: $store.earBudSelectedSide)
                   
                    
                    Spacer()
                    
                    // Control Menu
                    ControlMenuView()
                    
                    Spacer()
                }
                .padding(.bottom, 20)
            }
            }
           
            
            
        }
        .navigationBarBackButtonHidden(true)
        .padding(.bottom, 0)
//        .padding(.horizontal, 4)
        .padding(.top, 0)
        .background(.black)
        .frame(width: 250, height: 230)
        .onAppear {
            
        }
        
    }
        
}

struct VisualEffectBlur: NSViewRepresentable {
    var blurStyle: NSVisualEffectView.BlendingMode

    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.blendingMode = blurStyle
        view.state = .active
        return view
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        nsView.blendingMode = blurStyle
        nsView.state = .active
    }
}

struct ControlsView_Previews: PreviewProvider {
    static let store = Store()
    static var previews: some View {
        ControlsView().environmentObject(store)
            .environmentObject(MainViewViewModel(bluetoothService: BluetoothServiceImpl(), nothingRepository: NothingRepositoryImpl.shared, nothingService: NothingServiceImpl.shared))
    }
}

