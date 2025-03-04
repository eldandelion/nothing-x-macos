//
//  FailedToConnectViewViewModel.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/4.
//

import Foundation

class FailedToConnectViewViewModel : ObservableObject {
    
    
    func notifyRetry() {
        
        NotificationCenter.default.post(name: Notification.Name(Notifications.REQUEST_RETRY.rawValue), object: nil)
        
    }
    
}
