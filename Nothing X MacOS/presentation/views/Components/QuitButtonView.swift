//
//  QuitButtonView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 15/02/23.
//

import SwiftUI

struct QuitButtonView: View {
    var body: some View {
        // Quit
        Button(action: {
            // Make sure to close/disconnect the bluetooth channel before quitting.
            print("Quit Button Pressed!")
            NSApplication.shared.terminate(nil)
        }) {
            Image(systemName: "power.dotted")
                .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                .font(.system(size: 16))
        }
        .buttonStyle(BlackImageButtonCicle())
        .keyboardShortcut("q")
        .focusable(false)
    }
}

struct QuitButtonView_Previews: PreviewProvider {
    static var previews: some View {
        QuitButtonView()
    }
}
