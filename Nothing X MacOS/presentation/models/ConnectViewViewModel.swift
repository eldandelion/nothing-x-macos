//
//  ConnectViewViewModel.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/27.
//

import Foundation

class ConnectViewViewModel : ObservableObject {
    
    
    private let nothingRepository: NothingRepository
    private let nothingService: NothingService
    
    @Published var isLoading = false
    
    
    init(nothingRepository: NothingRepository, nothingService: NothingService) {
        
        self.nothingRepository = nothingRepository
        self.nothingService = nothingService
        
        NotificationCenter.default.addObserver(forName: Notification.Name(DataNotifications.REPOSITORY_DATA_UPDATED.rawValue), object: nil, queue: .main) { notification in
            
            self.isLoading = false
            
        }
        
    }
    
    
    func connect() {
        isLoading = true
        let devices = nothingRepository.getSaved()
        
        nothingService.connectToNothing(device: devices[0].bluetoothDetails)
    }
    
    
}
