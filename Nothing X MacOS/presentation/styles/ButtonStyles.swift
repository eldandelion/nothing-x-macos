//
//  ButtonStyles.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 13/02/23.
//

import Foundation
import SwiftUI


struct GreyButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(4)
            .frame(width: 90, height: 34)
            .background(Color(#colorLiteral(red: 0.10980392247438431, green: 0.11372549086809158, blue: 0.12156862765550613, alpha: 1)))
            .font(.system(size: 10, weight:.light)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
            .clipShape(Capsule())
            
    }
}


struct GreyImageButtonCicle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 28, height: 28)
            .background(Color(#colorLiteral(red: 0.10980392247438431, green: 0.11372549086809158, blue: 0.12156862765550613, alpha: 1)))
            .clipShape(Circle())
    }
}

struct GreyButtonLarge: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(4)
            .frame(width: 210, height: 32)
            .background(Color(#colorLiteral(red: 0.10980392247438431, green: 0.11372549086809158, blue: 0.12156862765550613, alpha: 1)))
            .font(.system(size: 10, weight:.light)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
            .clipShape(Capsule())
            .textCase(.uppercase)
    }
}


struct BlackImageButtonCicle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 28, height: 28)
            .background(.black)
            .clipShape(Circle())
    }
}

struct BlackImageButtonCicleLarge: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 50, height: 50)
            .background(.black)
            .clipShape(Circle())
    }
}


struct OffWhiteConnectButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(4)
            .frame(width: 210, height: 32)
            .background(Color(#colorLiteral(red: 0.7568627595901489, green: 0.7607843279838562, blue: 0.7686274647712708, alpha: 1)))
            .font(.system(size: 10, weight:.regular)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8)))
            .clipShape(Capsule())
            .textCase(.uppercase)
    }
}

struct TransparentButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .buttonStyle(PlainButtonStyle())
            
            .font(.system(size: 10, weight:.regular)).foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
            .clipShape(Capsule())
            .textCase(.uppercase)
    }
}


struct EQButton: ButtonStyle {
    var selected: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        if(selected) {
            configuration.label
                .padding(4)
                .frame(width: 90, height: 34)
                .background(Color(#colorLiteral(red: 0.10980392247438431, green: 0.11372549086809158, blue: 0.12156862765550613, alpha: 1)))
                .font(.system(size: 10, weight:.light)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                .clipShape(Capsule())
                .colorInvert()
                .focusable(false)
                .textCase(.uppercase)
        }
        else {
            configuration.label
                .padding(4)
                .frame(width: 90, height: 34)
                .background(Color(#colorLiteral(red: 0.10980392247438431, green: 0.11372549086809158, blue: 0.12156862765550613, alpha: 1)))
                .font(.system(size: 10, weight:.light)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                .clipShape(Capsule())
                .focusable(false)
                .textCase(.uppercase)
        }
    }
    
}
struct ANCButton: ButtonStyle {
    var selected: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        if(selected) {
            configuration.label
                .padding(4)
                .frame(width: 56, height: 34)
                .background(Color(#colorLiteral(red: 0.7568627595901489, green: 0.7607843279838562, blue: 0.7686274647712708, alpha: 1)))
                .font(.system(size: 14, weight:.regular)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8)))
                .clipShape(Capsule())
//                .animation(.easeInOut, value: configuration.isPressed)
//                .offset(x: CGFloat(selectedIndex) * (buttonWidth + 5)) // Adjust offset based on selected index
                .animation(.easeInOut(duration: 0.3), value: configuration.isPressed)
        }
        else {
            configuration.label
                .padding(4)
                .frame(width: 56, height: 34)
                .background(Color(#colorLiteral(red: 0.10980392247438431, green: 0.11372549086809158, blue: 0.12156862765550613, alpha: 1)))
            
                .font(.system(size: 14, weight:.regular)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                .clipShape(Capsule())
                .animation(.easeInOut, value: configuration.isPressed)
        }
    }
}

struct FindMyTransparentButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            configuration.label
                .font(.system(size: 10, weight: .light))
            Spacer()
            Image(systemName: "arrow.right")
                .padding(.trailing, 10)
        }
        .frame(width: 200, height: 24)
        .background(.black)
        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
        .padding(0)
    }
}

struct ControlTapButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .padding(.leading, 6)
            .background(Color(#colorLiteral(red: 0.10980392247438431, green: 0.11372549086809158, blue: 0.12156862765550613, alpha: 1)))
            .font(.system(size: 10, weight:.light)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            .cornerRadius(10)
    }
}



