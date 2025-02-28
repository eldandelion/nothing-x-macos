//
//  BackButtonView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 15/02/23.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button(action: {
            print("Back Button Pressed!")
            dismiss()
        }) {
            Image(systemName: "arrow.backward")
                .colorInvert()
                .font(.system(size: 16))
        }
        .buttonStyle(BlackImageButtonCicle())
        .focusable(false)
  
    }
}

struct BackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BackButtonView()
    }
}
