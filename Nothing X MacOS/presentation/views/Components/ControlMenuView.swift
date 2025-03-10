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
                            HStack(spacing: 2) {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 4, height: 4)
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 4, height: 4)
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 4, height: 4)
                               
                            }
                            
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
            .frame(width: 220, height: 42)
            .buttonStyle(ControlTapButton())
            
            NavigationLink(value: Destination.controlsTapHold) {
            
                HStack {
                    VStack(alignment: .leading) {
                        HStack{
                            Text("TAP & HOLD")
                            HStack(spacing: 0) {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 4, height: 4)
                                Rectangle()
                                    .fill(Color.red)
                                    .frame(width: 8, height: 1)
                            }
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
            .frame(width: 220, height: 58)
            .buttonStyle(ControlTapButton())
            
//            HStack {
//                
//                    VStack(alignment: .leading) {
//                        HStack{
//                            Text("DOUBLE TAP")
//                            HStack(spacing: 2) {
//                                Circle()
//                                    .fill(Color.red)
//                                    .frame(width: 4, height: 4)
//                                Circle()
//                                    .fill(Color.red)
//                                    .frame(width: 4, height: 4)
//                                
//                            }
//                        }
//                        
//                        Spacer(minLength: 2)
//                        
//                        Text("Play / pause")
//                            .fontWeight(.ultraLight)
//                        
//                        Spacer(minLength: 2)
//                        
//                        Text("Answer / hang up calls")
//                            .fontWeight(.ultraLight)
//                    }
//                    
//                    Spacer()
                    
//                    VStack(alignment: .leading) {
//                        HStack{
//                            Text("DOUBLE TAP")
//                            HStack(spacing: 2) {
//                                Circle()
//                                    .fill(Color.red)
//                                    .frame(width: 4, height: 4)
//                                Circle()
//                                    .fill(Color.red)
//                                    .frame(width: 4, height: 4)
//                                
//                            }
//                        }
//                        
//                        Spacer(minLength: 2)
//                        
//                        Text("Play / pause")
//                            .fontWeight(.ultraLight)
//                        
//                        Spacer(minLength: 2)
//                        
//                        Text("Answer / hang up calls")
//                            .fontWeight(.ultraLight)
//                    }
//                    
//                    Spacer()
//
//            }
//            .frame(width: 192, height: 40)
//            .padding(10)
//            .padding(.leading, 6)
//            .background(Color(#colorLiteral(red: 0.10980392247438431, green: 0.11372549086809158, blue: 0.12156862765550613, alpha: 1)))
//            .font(.system(size: 10, weight:.light)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
//            .cornerRadius(6)
            
            
        }
    }
}

struct ControlMenuView_Previews: PreviewProvider {
    static let store = Store()
    static var previews: some View {
        ControlMenuView().environmentObject(store)
    }
}
