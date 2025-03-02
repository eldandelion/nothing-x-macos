//
//  ProgressViewStyles.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 14/02/23.
//

import Foundation
import SwiftUI

struct NothingProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: LinearProgressViewStyle.Configuration) -> some View {
        ProgressView(configuration)
            .padding(4)
            .frame(width: 52, alignment: .center)
            .tint(.white)
            .font(.system(size: 12, weight:.light)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
    }
}
