//
//  ControlsView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 14/02/23.
//

import SwiftUI


struct ControlsView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack {
            // Back - Heading - Settings | Quit
            HStack {
                // Back
                BackButtonView()
                
                Spacer()
                
                // Settings
                SettingsButtonView()
                
                // Quit
                QuitButtonView()
            }
            
            VStack(alignment: .center) {
                // Left - Right
                BudsSidePickerView(selection: $store.earBudSelectedSide)
                
                Spacer()
                
                // Control Menu
                ControlMenuView()
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .padding(4)
        .background(.black)
        .frame(width: 250, height: 230)
        .cornerRadius(8)
    }
}

struct ControlsView_Previews: PreviewProvider {
    static let store = Store()
    static var previews: some View {
        ControlsView().environmentObject(store)
    }
}
