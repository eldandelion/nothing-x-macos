//
//  ControlMenuView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 22/02/23.
//

import SwiftUI

struct ControlMenuView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack(spacing: 16) {
            NavigationLink(value: Destination.controlsTripleTap) {
                HStack {
                    VStack(alignment: .leading) {
                        HStack{
                            Text("TRIPLE TAP")
                            Text("🔴🔴🔴").font(.system(size: 4, weight:.light))
                        }
                        
                        Spacer(minLength: 2)

                        Text(self.store.selectedTripleTapOp[store.earBudSelectedSide == EarBudSide.left.rawValue ? 0 : 1].rawValue.capitalized)
                                .fontWeight(.ultraLight)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                        
                }
            }
            .frame(width: 180, height: 42)
            .buttonStyle(ControlTapButton())
            
            NavigationLink(value: Destination.controlsTapHold) {
                HStack {
                    VStack(alignment: .leading) {
                        HStack{
                            Text("TAP & HOLD")
                            Text("📍")
                                .rotationEffect(.degrees(-90))
                                .font(.system(size: 8, weight:.light))
                        }
                        
                        Spacer(minLength: 2)
                        
                        Text(self.store.selectedtapAndHoldOp[store.earBudSelectedSide == EarBudSide.left.rawValue ? 0 : 1].rawValue.capitalized)
                            .fontWeight(.ultraLight)
                        
                        Spacer(minLength: 2)
                        
                        Text(self.store.fixedtapAndHoldOp.capitalized)
                            .fontWeight(.ultraLight)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                        
                }
            }
            .frame(width: 180, height: 58)
            .buttonStyle(ControlTapButton())
        }
    }
}

struct ControlMenuView_Previews: PreviewProvider {
    static let store = Store()
    static var previews: some View {
        ControlMenuView().environmentObject(store)
    }
}
