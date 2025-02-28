//
//  BatteryIndicatorViewViewModel.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/18.
//

import Foundation


class BatteryIndicatorViewViewModel : ObservableObject {
    
    
    
    
    init() {
        
        NotificationCenter.default.addObserver(forName: Notification.Name(DataNotifications.REPOSITORY_DATA_UPDATED.rawValue), object: nil, queue: .main) { notification in
            
            if let device = notification.object as? NothingDeviceEntity {
                
                if self.leftBattery != device.leftBattery {
                    self.leftBattery = device.leftBattery
                }
                
                if self.caseBattery != device.caseBattery {
                    self.caseBattery = device.caseBattery
                }
                
                if self.rightBattery != device.rightBattery {
                    self.rightBattery = device.rightBattery
                }
               
                
            }
        }
    }
        
    
    
    @Published var leftBattery: Int = 0;
    @Published var rightBattery: Int = 0;
    @Published var caseBattery: Int = 0;
}
