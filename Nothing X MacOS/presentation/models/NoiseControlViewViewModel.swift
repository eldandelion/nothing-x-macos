//
//  HomeViewViewModel.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/18.
//

import Foundation

class NoiseControlViewViewModel : ObservableObject {
    
    private let nothingService: NothingService
    
    init(nothingService: NothingService) {
        
        self.nothingService = nothingService
        
       
       
        NotificationCenter.default.addObserver(forName: Notification.Name(DataNotifications.REPOSITORY_DATA_UPDATED.rawValue), object: nil, queue: .main) { notification in
            
            if let device = notification.object as? NothingDeviceEntity {
                self.anc = self.ancToNoiseControlOptions(anc: device.anc)
                
            }
        }
    }
        
    
    @Published var anc: NoiseControlOptions = .off
    
    func ancToNoiseControlOptions(anc: ANC) -> NoiseControlOptions {
        
        
        switch anc {
        case .OFF:
            return .off
        case .TRANSPARENCY:
            return .transparency
        case .ON_LOW:
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
