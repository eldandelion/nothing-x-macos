//
//  BatteryIndicatorViewViewModel.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/18.
//

import Foundation
import SwiftUI


class BatteryIndicatorViewViewModel : ObservableObject {
    
    
    init() {
        
        NotificationCenter.default.addObserver(forName: Notification.Name(DataNotifications.REPOSITORY_DATA_UPDATED.rawValue), object: nil, queue: .main) { notification in
            
            if let device = notification.object as? NothingDeviceEntity {
                
                #warning("gotta fix the flickering")
                
                if self.leftBattery != device.leftBattery {
                    self.leftBattery = device.leftBattery
                }
                
                if self.caseBattery != device.caseBattery {
                    self.caseBattery = device.caseBattery
                }
                
                if self.rightBattery != device.rightBattery {
                    self.rightBattery = device.rightBattery
                }
               
                
                
                if self.isRightCharging != device.isRightCharging {
                    withAnimation {
                        self.isRightCharging = device.isRightCharging
                    }
                }
                
                if self.isLeftCharging != device.isLeftCharging {
                    withAnimation {
                        self.isLeftCharging = device.isLeftCharging
                    }
                }
                
                if self.isCaseCharging != device.isCaseCharging {
                    withAnimation {
                        self.isCaseCharging = device.isCaseCharging
                    }
                }
                
                if self.isRightConnected != device.isRightConnected {
                    withAnimation {
                        self.isRightConnected = device.isRightConnected
                    }
                    
                }
                
                if self.isLeftConnected != device.isLeftConnected {
                    withAnimation {
                        self.isLeftConnected = device.isLeftConnected
                    }
                    
                }
                
                if self.isCaseConnected != device.isCaseConnected {
                    withAnimation {
                        self.isCaseConnected = device.isCaseConnected
                    }
                    
                }
                
            }
        }
    }
        
    
    
    @Published var leftBattery: Int = 0;
    @Published var rightBattery: Int = 0;
    @Published var caseBattery: Int = 0;
    @Published var isLeftCharging = false;
    @Published var isRightCharging = false;
    @Published var isCaseCharging = false;
    @Published var isLeftConnected = false;
    @Published var isRightConnected = false;
    @Published var isCaseConnected = true;
}
