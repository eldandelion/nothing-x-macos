//
//  BatteryIndicatorView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 15/02/23.
//

import SwiftUI

struct BatteryIndicatorView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        HStack(spacing: 10) {
            // Left Battery
            ProgressView("\(Int(store.leftBattery))% L", value: store.leftBattery, total: 100)
                .progressViewStyle(NothingProgressViewStyle())
            
            // Case Battery
            ProgressView("\(Int(store.caseBattery))% C", value: store.caseBattery, total: 100)
                .progressViewStyle(NothingProgressViewStyle())
            
            // Right Battery
            ProgressView("\(Int(store.rightBattery))% R", value: store.rightBattery, total: 100)
                .progressViewStyle(NothingProgressViewStyle())
        }
        .frame(width: 170)
    }
}

struct BatteryIndicatorView_Previews: PreviewProvider {
    static let store = Store()
    static var previews: some View {
        BatteryIndicatorView().environmentObject(store)
    }
}
