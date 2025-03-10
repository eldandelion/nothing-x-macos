//
//  ControlsDetailView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 23/02/23.
//

import SwiftUI

struct ControlsDetailView: View {
    @EnvironmentObject var store: Store
    var destination: Destination
    @State private var selectedTripleAction = TripleTapOptions.skip_forward
    @State private var selectedTapAndHoldAction = TapAndHoldOptions.no_extra_action
    
    @EnvironmentObject var mainViewModel: MainViewViewModel
    @EnvironmentObject var budsPickerViewModel: BudsPickerComponentViewModel
    @State var viewModel: ControlsDetailViewViewModel = ControlsDetailViewViewModel(nothingService: NothingServiceImpl.shared)
    
    @Binding var leftTripleTapAction: TripleTapGestureActions
    @Binding var rightTripleTapAction: TripleTapGestureActions
    @Binding var leftTapAndHoldAction: TapAndHoldGestureActions
    @Binding var rightTapAndHoldAction: TapAndHoldGestureActions
    
    var body: some View {
        VStack {
            
            ZStack(alignment: .top) {
                
            // Back - Heading - Settings | Quit
                HStack {
                    // Back
                    BackButtonView()
                    
                    Spacer()
                    
                }
                .zIndex(1)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(1.0), Color.black.opacity(0.0)]), startPoint: .top, endPoint: .bottom)
                )
                
            
            
            
            ScrollView(.vertical, showsIndicators: false) {
                
                
                VStack {
                    BudsPickerComponent(action: {
                        selection in
                        
                        withAnimation {
                            switch selection {
                            case .LEFT:
                                selectedTripleAction = viewModel.convertTripleTapActionToOption(action: leftTripleTapAction)
                                selectedTapAndHoldAction = viewModel.convertTapAndHoldActionToOption(action: leftTapAndHoldAction)
                                
                            case .RIGHT:
                                selectedTripleAction = viewModel.convertTripleTapActionToOption(action: rightTripleTapAction)
                                selectedTapAndHoldAction = viewModel.convertTapAndHoldActionToOption(action: rightTapAndHoldAction)
                            }
                        }
                    })
                        
                }
                .padding(.top, 32)
                
                
                // Radio Group Option Selection
                VStack {
                    
                    // Option Title
                    HStack{
                        if(destination == .controlsTripleTap) {
                            VStack {
                                HStack(spacing: 2) {
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 4, height: 4)
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 4, height: 4)
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 4, height: 4)
                                    
                                }
                                .padding(.bottom, 2)
                                
                                Text("TRIPLE TAP")
                                    .font(.system(size: 10, weight:.light))
                            }
                        }
                        else {
                            VStack {
                                HStack(spacing: 0) {
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 4, height: 4)
                                    Rectangle()
                                        .fill(Color.red)
                                        .frame(width: 8, height: 1)
                                }
                                .padding(.bottom, 2)
                                Text("TAP & HOLD")
                            }
                        }
                    }
                    .padding(.vertical, 8)
                    
                    if destination == .controlsTripleTap {
                        
                        VStack(spacing: 12) {
                            
                            ForEach(TripleTapOptions.allCases, id: \.self) { option in
                                
                                HStack {
                                    Text(option.rawValue)
                                        .padding(4)
                                        .textCase(.uppercase)
                                    Spacer()
                                    
                                    
                                    Button(action: {
                                    
                                        let device = budsPickerViewModel.selection
                                        viewModel.switchTripleTapAction(device: device, action: option)
                                        withAnimation {
                                            selectedTripleAction = option
                                        }
                                     
                                    }) {
                                        if option == selectedTripleAction {
                                            Image("radio_button_selected_dark")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 16, height: 16)
                                            
                                        } else {
                                            Image("radio_button_not_selected_dark")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 16, height: 16)
                                            
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .padding(.trailing, 2)
                                    
                                    //                                        ZStack {
                                    //
                                    //                                            Circle()
                                    //                                                .stroke(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), lineWidth: 0.7)
                                    //                                                .frame(width: 12, height: 12)
                                    //                                                .padding(4)
                                    //
                                    //                                            if option == selectedTripleAction {
                                    //                                                Circle()
                                    //                                                    .stroke(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), lineWidth: 3.2)
                                    //                                                    .frame(width: 8, height: 8)
                                    //                                                    .padding(4)
                                    //
                                    //                                            }
                                    //
                                    //                                        }
                                    
                                    
                                }
                                
                            }
                        }.padding(.bottom, 18)
                        
                    }
                    else {
                        
                        VStack(spacing: 12) {
                            ForEach(TapAndHoldOptions.allCases, id: \.self) { option in
                                
                                
                                HStack {
                                    Text(option.rawValue)
                                        .padding(4)
                                        .textCase(.uppercase)
                                    Spacer()
                                    
                                    Button(action: {
                               
                                        let device: DeviceType = budsPickerViewModel.selection
                               
                                        viewModel.switchTapAndHoldAction(device: device, action: option)
                                        withAnimation {
                                            selectedTapAndHoldAction = option
                                        }
                                    
                                    }) {
                                        if option == selectedTapAndHoldAction {
                                            Image("radio_button_selected_dark")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 16, height: 16)
                                            
                                        } else {
                                            Image("radio_button_not_selected_dark")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 16, height: 16)
                                            
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .padding(.trailing, 2)
                                    
                                }
                                .buttonStyle(TransparentButton())
                            }
                        }.padding(.bottom, 10)
                        
                        Divider().frame(width: 140)
                        
                        HStack {
                            Text(store.fixedtapAndHoldOp)
                                .padding(4)
                            Spacer()
                        }
                        
                    }
                }
                .pickerStyle(.radioGroup)
                .labelsHidden()
                .frame(width: 200)
                .padding(10)
                .background(Color(#colorLiteral(red: 0.10980392247438431, green: 0.11372549086809158, blue: 0.12156862765550613, alpha: 1)))
                .font(.system(size: 10, weight:.light)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .cornerRadius(6)
                .padding(.bottom, 30)
                
                Spacer()
                
            }
            }

            
            
        }
        .navigationBarBackButtonHidden(true)
        .background(.black)
        .frame(width: 250, height: 230)
        .onAppear {
            switch budsPickerViewModel.selection {
            case .LEFT:
                selectedTripleAction = viewModel.convertTripleTapActionToOption(action: leftTripleTapAction)
                selectedTapAndHoldAction = viewModel.convertTapAndHoldActionToOption(action: leftTapAndHoldAction)
            case .RIGHT:
                selectedTripleAction = viewModel.convertTripleTapActionToOption(action: rightTripleTapAction)
                selectedTapAndHoldAction = viewModel.convertTapAndHoldActionToOption(action: rightTapAndHoldAction)
            }
           
        }
        
    }

}

struct ControlsDetailView_Previews: PreviewProvider {
    static let store = Store()
    
    struct PreviewWrapper: View {
        @State var leftTripleTapAction: TripleTapGestureActions = .NO_EXTRA_ACTION
        @State var rightTripleTapAction: TripleTapGestureActions = .SKIP_BACK
        @State var leftTapAndHoldAction: TapAndHoldGestureActions = .NO_EXTRA_ACTION
        @State var rightTapAndHoldAction: TapAndHoldGestureActions = .NOISE_CONTROL
        
        @State private var viewModel: BudsPickerComponentViewModel = BudsPickerComponentViewModel()
        var body: some View {
            ControlsDetailView(destination: .controlsTripleTap,
                               leftTripleTapAction: $leftTripleTapAction,
                               rightTripleTapAction: $rightTripleTapAction,
                               leftTapAndHoldAction: $leftTapAndHoldAction,
                               rightTapAndHoldAction: $rightTapAndHoldAction
            ).environmentObject(store)
                .environmentObject(MainViewViewModel(bluetoothService: BluetoothServiceImpl(), nothingRepository: NothingRepositoryImpl.shared, nothingService: NothingServiceImpl.shared))
                .environmentObject(viewModel)
        }
    }
    
    static var previews: some View {

        PreviewWrapper()
    }
}
