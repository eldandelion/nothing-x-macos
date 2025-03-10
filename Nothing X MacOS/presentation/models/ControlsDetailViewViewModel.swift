//
//  ControlsDetailViewViewModel.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/9.
//

import Foundation
class ControlsDetailViewViewModel : ObservableObject {
    
    private let switchControlsUseCase: SwitchControlsUseCaseProtocol

    
    init(nothingService: NothingService) {
        self.switchControlsUseCase = SwitchControlsUseCase(nothingService: nothingService)
    }
    

    func switchTripleTapAction(device: DeviceType, action: TripleTapOptions) {
 
        var convertedAction: TripleTapGestureActions = .NO_EXTRA_ACTION
        
        switch action {
        case .no_action:
            convertedAction = .NO_EXTRA_ACTION
        case .skip_back:
            convertedAction = .SKIP_BACK
        case .skip_forward:
            convertedAction = .SKIP_FORWARD
        case .voice_assistant:
            convertedAction = .VOICE_ASSISTANT
        }
        
        switchControlsUseCase.switchGesture(device: device, gesture: .TRIPLE_TAP, action: convertedAction.rawValue)
    }
    
    func switchTapAndHoldAction(device: DeviceType, action: TapAndHoldOptions) {
        var convertedAction: TapAndHoldGestureActions = .NO_EXTRA_ACTION
        
        switch action {
        case .no_extra_action:
            convertedAction = .NO_EXTRA_ACTION
        case .noise_control:
            convertedAction = .NOISE_CONTROL
        }
        switchControlsUseCase.switchGesture(device: device, gesture: .TAP_AND_HOLD, action: convertedAction.rawValue)
    }
    
    func convertTripleTapActionToOption(action: TripleTapGestureActions) -> TripleTapOptions {
        
        var convertedOption: TripleTapOptions = .no_action
        
        switch action {
        case .NO_EXTRA_ACTION:
            convertedOption = .no_action
        case .SKIP_BACK:
            convertedOption = .skip_back
        case .SKIP_FORWARD:
            convertedOption = .skip_forward
        case .VOICE_ASSISTANT:
            convertedOption = .voice_assistant
        }
        
        return convertedOption
    }
    
    func convertTapAndHoldActionToOption(action: TapAndHoldGestureActions) -> TapAndHoldOptions {
        
        var convertedOption: TapAndHoldOptions = .no_extra_action
        
        switch action {
        case .NOISE_CONTROL:
            convertedOption = .noise_control
        case .NO_EXTRA_ACTION:
            convertedOption = .no_extra_action
       
        }
        
        return convertedOption
    }
    
}
