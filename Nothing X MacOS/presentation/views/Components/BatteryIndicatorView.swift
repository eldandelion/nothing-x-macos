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
            
            if viewModel.isLeftConnected {
                
                ZStack {
                    
                    ProgressView("\(Int(viewModel.leftBattery))% L", value: Float(viewModel.leftBattery), total: 100)
                        .progressViewStyle(NothingProgressViewStyle())
                    if viewModel.isLeftCharging {
                        Capsule()
                            .fill(Color.black)
                            .frame(width: 9, height: 12)
                            .padding(.top, 14)
                        Image(systemName: "bolt.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            .scaleEffect(0.7)
                            .padding(.top, 14)
                    }
                }
            }
                
            
            if viewModel.isCaseConnected {
                
                ZStack {
                    // Case Battery
                    ProgressView("\(Int(viewModel.caseBattery))% C", value: Float(viewModel.caseBattery), total: 100)
                        .progressViewStyle(NothingProgressViewStyle())
                    if viewModel.isCaseCharging {
                        Capsule()
                            .fill(Color.black)
                            .frame(width: 9, height: 12)
                            .padding(.top, 14)
                        
                        Image(systemName: "bolt.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            .scaleEffect(0.7)
                            .padding(.top, 14)
                        
                    }
                    
                }
                
            }
      
            if viewModel.isRightConnected {
                
                ZStack {
                    
                    // Right Battery
                    ProgressView("\(Int(viewModel.rightBattery))% R", value: Float(viewModel.rightBattery), total: 100)
                        .progressViewStyle(NothingProgressViewStyle())
                    if viewModel.isRightCharging
                    {
                        Capsule()
                            .fill(Color.black)
                            .frame(width: 9, height: 12)
                            .padding(.top, 14)
                        Image(systemName: "bolt.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            .scaleEffect(0.7)
                            .padding(.top, 14)
                    }
                }
                
            }
        }
        .frame(width: 180, height: 40)
    }
}

struct BatteryIndicatorView_Previews: PreviewProvider {
    static let store = Store()
    static var previews: some View {
        BatteryIndicatorView().environmentObject(store)
    }
}
