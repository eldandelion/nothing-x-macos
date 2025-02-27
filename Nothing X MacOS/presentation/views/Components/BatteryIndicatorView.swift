//
//  BatteryIndicatorView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 15/02/23.
//

import SwiftUI

struct BatteryIndicatorView: View {
    @EnvironmentObject var store: Store
    @StateObject private var viewModel =  BatteryIndicatorViewViewModel()
    
    
    
    var body: some View {
        HStack(spacing: 10) {
            // Left Battery
            ProgressView("\(Int(viewModel.leftBattery))% L", value: Float(viewModel.leftBattery), total: 100)
                .progressViewStyle(NothingProgressViewStyle())
            
            // Case Battery
            ProgressView("\(Int(viewModel.caseBattery))% C", value: Float(viewModel.caseBattery), total: 100)
                .progressViewStyle(NothingProgressViewStyle())
            
            // Right Battery
            ProgressView("\(Int(viewModel.rightBattery))% R", value: Float(viewModel.rightBattery), total: 100)
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
