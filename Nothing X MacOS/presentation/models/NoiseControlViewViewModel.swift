//
//  HomeViewViewModel.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/18.
//

import Foundation

class NoiseControlViewViewModel : ObservableObject {
    
    let repository: Repository = RepositoryImpl()
    
    
    init() {
        NotificationCenter.default.addObserver(forName: Notification.Name(Notifications.REPOSITORY_DATA_UPDATED.rawValue), object: nil, queue: .main) { notification in
            
            if let device = notification.object as? NothingDevice {
                self.anc = device.anc
                
            }
        }
    }
        
    
    @Published var anc: ANC = .TRANSPARENCY
    
    
    func switchANC(anc: ANC) {
        repository.switchANC(mode: anc)
    }
    
    
    
}
