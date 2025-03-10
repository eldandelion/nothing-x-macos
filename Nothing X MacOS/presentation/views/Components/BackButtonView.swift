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
//            withAnimation {
                dismiss()
//            }
       
        }) {
            Image(systemName: "arrow.backward")
                
                .font(.system(size: 16))
                .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
        }
        .buttonStyle(TransparentButton())
        .focusable(false)
        .padding(.vertical, 10)
        .padding(.leading, 8)
    
  
    }
}

struct BackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BackButtonView()
    }
}
