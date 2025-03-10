//
//  BluetoothIsOffViewViewModel.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/10.
//

import Foundation
import AppKit

class BluetoothIsOffViewViewModel : ObservableObject {
    
    
    func openBluetoothPreferences() {
        // Open the Bluetooth preferences pane directly
        if let url = URL(string: "x-apple.systempreferences:com.apple.preference.bluetooth") {
            NSWorkspace.shared.open(url)
        }
    }
    
}
