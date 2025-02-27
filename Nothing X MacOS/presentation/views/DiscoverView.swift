//
//  DiscoverView.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/21.
//


import SwiftUI

struct DiscoverView : View {
    var body : some View {
        VStack {
            
            HStack {
                Spacer()
                
                // Settings
                SettingsButtonView()
                
                // Quit
                QuitButtonView()
            }
            
        }
    }
}



struct DiscoverView_Preview: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
