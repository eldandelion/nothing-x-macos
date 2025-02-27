//
//  SwitchToggleStyle.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 15/02/23.
//

import Foundation
import SwiftUI

struct SwitchToggleStyle: ToggleStyle {
    func makeBody(configuration: SwitchToggleStyle.Configuration) -> some View {
        return HStack {
            configuration.label
                .font(.system(size: 10, weight: .light))
            Spacer()
            Toggle(configuration)
                .labelsHidden()
                .tint(.white)
                .opacity(1)
                .toggleStyle(.switch)
        }
        .frame(width: 200)
        .padding(2)
        
    }
}
