//
//  MenuStyles.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 21/02/23.
//

import Foundation
import SwiftUI


struct GreyMenuStyle: MenuStyle {
    func makeBody(configuration: Configuration) -> some View {
        Menu(configuration)
            .border(Color.red)
    }
}
