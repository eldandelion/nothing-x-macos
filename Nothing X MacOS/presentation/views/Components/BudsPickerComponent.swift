//
//  BudsPickerComponent.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/5.
//

import SwiftUI

struct BudsPickerComponent: View {
    
    @EnvironmentObject var viewModel: BudsPickerComponentViewModel
    let action: (_ selection: DeviceType) -> Void
    

    var body: some View {
        ZStack(alignment: .center) {
            
            HStack {
                
                Button(action: {
                    viewModel.selection = .LEFT
                    action(.LEFT)
                }) {
                }
                .buttonStyle(BudsPickerButton(isDarkened: $viewModel.isLeftDarken, scale: $viewModel.scaleButtonLeft, offset: $viewModel.leftButtonOffset, imageName: "ear_1_left", imageNameDarken: "ear_1_left_darken"))
                .padding(.leading, 50)
                Spacer()
            }
            .zIndex(2)
            
            HStack {
                
                Spacer()
                
                Button(action: {
                    viewModel.selection = .RIGHT
                    action(.RIGHT)
                }) {
                    
                }
                .padding(.trailing, 50)
                .buttonStyle(BudsPickerButton(isDarkened: $viewModel.isRightDarken, scale: $viewModel.scaleButtonRight, offset: $viewModel.rightButtonOffset, imageName: "ear_1_right",
                                              imageNameDarken: "ear_1_right_darken"))
                
            }
            .zIndex(3)
        }
        
        VStack(alignment: .center) {
            
            Text(viewModel.selectedBudText)
                .font(.custom("5by7", size: 12))
            
                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                .multilineTextAlignment(.center)
                .textCase(.uppercase)
                .padding(.top, 12)
                .padding(.bottom, 8)
        }
    }
    
}

struct BudsPickerComponent_Previews: PreviewProvider {
 
    struct PreviewWrapper: View {
        @State var selection: DeviceType = .LEFT
        @State var viewModel: BudsPickerComponentViewModel = BudsPickerComponentViewModel()
        var body: some View {
            BudsPickerComponent(action: {selection in })
                .environmentObject(viewModel)
                .previewDisplayName("BudsPickerComponent View Preview")
        }
    }

    static var previews: some View {
        PreviewWrapper() // Use the wrapper to create an instance
    }
}


