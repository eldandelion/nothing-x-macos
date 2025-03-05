//
//  FailedToConnectView.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/4.
//

import Foundation
import SwiftUI

struct ModalSheetView : View {
    @Binding var isPresented: Bool
    @Binding var title: String?
    @Binding var text: String?
    @Binding var topButtonText: String?
    @Binding var bottomButtonText: String?

    let action: () -> Void
    
        var body: some View {
            VStack {
            
                
                VStack {
                    Spacer()
                
                    
                    VStack {
                        
                        if var title = title {
                            Text(title)
                                .font(.custom("5by7", size: 14))
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                                .multilineTextAlignment(.leading)
                                .textCase(.uppercase)
                                .padding(.bottom, 12)
                        }
                        
                        if var text = text {
                            Text(text)
                                .lineLimit(2)
                                .font(.system(size: 10, weight: .light))
                                .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                                .multilineTextAlignment(.center)
                        }
          

                    }
                    .padding(.horizontal, 18)
                    
                    if var topButtonText = topButtonText {
                        Button(topButtonText) {
                            action()
                        }
                        .buttonStyle(OffWhiteConnectButton())
                        .focusable(false)
                        .padding()
                        
                    }
                    
                    if var bottomButtonText = bottomButtonText {
                        Button(bottomButtonText) {
                            withAnimation {
                                isPresented = false
                            }
                        }
                        .buttonStyle(TransparentButton())
                        .focusable(false)
                        .padding(.bottom, 18)
                    }
                  
                }
        
            }
            .frame(width: 250, height: 180)
//            .padding()
            .background(Color(.modalSheet))
//            .cornerRadius(.leading)
            .shadow(radius: 10)
            .clipShape(TopRoundedRectangle(radius: 18))
            
            .transition(.move(edge: .bottom)) // Transition effect
            
        }
}

struct TopRoundedRectangle: Shape {
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Start at the top left corner
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + radius))
        // Draw the top left corner
        path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.minY + radius),
                     radius: radius,
                     startAngle: .degrees(180),
                     endAngle: .degrees(270),
                     clockwise: false)
        // Draw the top edge
        path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
        // Draw the top right corner
        path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius),
                     radius: radius,
                     startAngle: .degrees(270),
                     endAngle: .degrees(0),
                     clockwise: false)
        // Draw the right edge
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        // Draw the bottom edge
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        // Close the path
        path.closeSubpath()

        return path
    }
}


