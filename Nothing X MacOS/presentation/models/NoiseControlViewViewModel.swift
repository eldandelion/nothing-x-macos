//
//  HomeViewViewModel.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/18.
//

import Foundation
import SwiftUI

class NoiseControlViewViewModel : ObservableObject {
    
    private let nothingService: NothingService
    
    @Published var noiseSelectionOffset: CGFloat = 61
    @Published var anc: NoiseControlOptions = .off
    
    init(nothingService: NothingService) {
        
 
        
        self.nothingService = nothingService
        
       
       
        NotificationCenter.default.addObserver(forName: Notification.Name(DataNotifications.REPOSITORY_DATA_UPDATED.rawValue), object: nil, queue: .main) { notification in
            
            if let device = notification.object as? NothingDeviceEntity {
                
                
                
                withAnimation {
                    self.anc = self.ancToNoiseControlOptions(anc: device.anc)
                    switch self.anc {
                    case .off:
                        self.noiseSelectionOffset = 61
                    case .transparency:
                        self.noiseSelectionOffset = 0
                    case .anc:
                        self.noiseSelectionOffset = -61
                    }
                }
            }
        }
        
        
    }
        
    

    
    func ancToNoiseControlOptions(anc: ANC) -> NoiseControlOptions {
        
        
        switch anc {
        case .OFF:
            return .off
        case .TRANSPARENCY:
            return .transparency
        case .ON_LOW:
            return .anc
        case .ON_HIGH:
            return .anc
        default:
            return .off
        }
        
        
    }
    
    func noiseControlOptionsToAnc(option: NoiseControlOptions) -> ANC{
        
        switch option {
        case .off:
            return .OFF
        case .transparency:
            return .TRANSPARENCY
        case .anc:
            return .ON_LOW
            
            
        }
    }
    
    func switchANC(anc: ANC) {
        nothingService.switchANC(mode: anc)
       
    }
    
    
    
}
