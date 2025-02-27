//
//  SettingsButtonView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 15/02/23.
//

import SwiftUI

struct SettingsButtonView: View {
    var body: some View {
        // Settings
        NavigationLink(value: Destination.settings) {
            Image(systemName: "gearshape")
                .colorInvert()
                .font(.system(size: 16))
        }
        .buttonStyle(BlackImageButtonCicle())
        .focusable(false)
    }
}

struct SettingsButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButtonView()
    }
}
