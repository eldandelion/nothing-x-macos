//
//  FindMyBudsView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 15/02/23.
//

import SwiftUI
import TipKit
struct FindMyBudsView: View {
    
    @StateObject private var viewModel = FindMyBudsViewViewModel(nothingService: NothingServiceImpl())
    private let popoverTip = HearingLossToolTip()
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    
                    BackButtonView()
                    Spacer()
                    // Quit
                    QuitButtonView()
                    
                }
                .padding(.top, 4)
                .padding(.leading, 4)
                .padding(.trailing, 4)
                
                // Heading
                HStack() {
                    VStack(alignment: .leading) {
                        
                        if true {
                            
                            Text("Find my buds")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                                .multilineTextAlignment(.leading)
                                .textCase(.uppercase)
                            
                            Spacer()
                            
                            
                            
                            // Description
                            HStack {
                                Text("Click above to play sound.")
                                    .lineLimit(1)
                                    .font(.system(size: 10, weight: .light))
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom, 12)
                                
                                Spacer()
                                
                            }
                        }
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 8)
                    Spacer()
                }
                
            }
            .frame(width: 250, height: 230)
            .zIndex(1)
            
            
            VStack {
                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        VStack {
                            if viewModel.isRinging {
                                
                                HStack {
                                    Image(systemName: "stop.fill")
                                        .font(.system(size: 18, weight: .light))
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .foregroundColor(.white)
                                }
                                .frame(width: 60, height: 60)
                                .background(Color(#colorLiteral(red: 0.843137264251709, green: 0.09019608050584793, blue: 0.12941177189350128, alpha: 1)))
                                .clipShape(Circle())
                                .onTapGesture {
                                    viewModel.stopRingingBuds()
                                }
                                
                            } else {
                                if #available(macOS 14.0, *) {
                                    
                                    HStack {
                                        Image(systemName: "play.fill")
                                            .font(.system(size: 18, weight: .light))
                                            .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                            .foregroundColor(.white)
                                    }
                                    .frame(width: 60, height: 60)
                                    .background(Color(#colorLiteral(red: 0.843137264251709, green: 0.09019608050584793, blue: 0.12941177189350128, alpha: 1)))
                                    .clipShape(Circle())
                                    .popoverTip(popoverTip)
                                    .onTapGesture {
                                        viewModel.ringBuds()
                                    }
                                } else {
                                    HStack {
                                        Image(systemName: "play.fill")
                                            .font(.system(size: 18, weight: .light))
                                            .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                            .foregroundColor(.white)
                                    }
                                    .frame(width: 60, height: 60)
                                    .background(Color(#colorLiteral(red: 0.843137264251709, green: 0.09019608050584793, blue: 0.12941177189350128, alpha: 1)))
                                    .clipShape(Circle())
                                    .onTapGesture {
                                        viewModel.ringBuds()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(.black)
        .frame(width: 250, height: 230)
        .onDisappear {
            viewModel.stopRingingBuds()
        }
    }
}



struct FindMyBudsView_Previews: PreviewProvider {
    static var previews: some View {
        FindMyBudsView()
    }
}


struct HearingLossToolTip : Tip {
    
    var id: String {
        "Hearing loss tool tip"
    }
    
    var title: Text {
        Text("Important hearing damage information")
    }
    
    var message: Text? {
        Text("Make sure your earbuds are not in use before you continue. Activating this feature with earbuds in-ear may cause hearing damage.")
    }
    
    var image: Image? {
        Image(systemName: "ear.trianglebadge.exclamationmark")
    }
    
    
}
