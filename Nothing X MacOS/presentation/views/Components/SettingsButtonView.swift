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
                .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                .font(.system(size: 16))
        }
        .buttonStyle(TransparentButton())
        .focusable(false)
        .padding(.vertical, 8)
        .padding(.horizontal, 8)
    }
}

struct SettingsButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButtonView()
    }
}
