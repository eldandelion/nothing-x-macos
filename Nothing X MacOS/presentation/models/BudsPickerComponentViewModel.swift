//
//  BudsPickerComponentViewModel.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/8.
//

import Foundation
import SwiftUI
class BudsPickerComponentViewModel : ObservableObject {
    
    
    @Published var scaleButtonRight: CGFloat = 0.9
    @Published var scaleButtonLeft: CGFloat = 1.2
    @Published var isLeftDarken = false
    @Published var isRightDarken = true
    @Published var leftButtonOffset: CGFloat = 5
    @Published var rightButtonOffset: CGFloat = 5
    @Published var selectedBudText = "Left"
    @Published var selection: DeviceType = .LEFT {
        didSet {
            objectWillChange.send()
            animateSwitch()
        }
    }
    
    private func animateSwitch() {
        if selection == .LEFT {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    self.isRightDarken = true
                    self.isLeftDarken = false
                    self.leftButtonOffset = 5
                    self.rightButtonOffset = 5
                    self.scaleButtonRight = 0.9
                    self.scaleButtonLeft = 1.2
                    self.selectedBudText = "Left"
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    self.isRightDarken = false
                    self.isLeftDarken = true
                    self.leftButtonOffset = -5
                    self.rightButtonOffset = -5
                    self.scaleButtonRight = 1.2 // Scale back to original size
                    self.scaleButtonLeft = 0.9
                    self.selectedBudText = "Right"
                    
                    
                }
            }
        }
    }

   
}
