//
//  EqualizerViewViewModel.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/19.
//

import Foundation

class EqualizerViewViewModel : ObservableObject {
    
    
    private let nothingService: NothingService
    @Published var eq: EQProfiles = .BALANCED
    
    
    init(nothingService: NothingService) {
        
        self.nothingService = nothingService
        
        
        NotificationCenter.default.addObserver(forName: Notification.Name(DataNotifications.REPOSITORY_DATA_UPDATED.rawValue), object: nil, queue: .main) { notification in
            
            if let device = notification.object as? NothingDeviceEntity {
                
                if self.eq != device.listeningMode {
                    self.eq = device.listeningMode
                }
               
                
            }
        }
    }
    
   
    
    func switchEQ(eq: EQProfiles) {
    
        nothingService.switchEQ(mode: eq)
    }
    
}
