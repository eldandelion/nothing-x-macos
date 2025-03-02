//
//  DiscoverView.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/21.
//


import SwiftUI

struct DiscoverView : View {
    
    
    @StateObject private var viewModel = DiscoverViewViewModel(nothingService: NothingServiceImpl())
    
    var body : some View {
        ZStack {
            
            VStack {
                HStack {
                    
                    
                    if false {
                        BackButtonView()
                    }
               
                    Spacer()
                    
                    SettingsButtonView()
                    // Quit
                    QuitButtonView()
                    
                }
                .padding(.top, 4)
                .padding(.leading, 4)
                .padding(.trailing, 4)
                
                
                
                // Heading
                HStack() {
                    VStack(alignment: .leading) {
                        
                        if viewModel.viewState == .discovering {
                            
                            Text("Looking for device")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                                .multilineTextAlignment(.leading)
                                .textCase(.uppercase)
                            
                            Spacer()
                            
                            Text("Ensure device is in discovery mode.")
                                .lineLimit(1)
                                .font(.system(size: 10, weight: .light))
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 12)
                            
                            // Description
                           
                            
                        } else if viewModel.viewState == .not_discovering {
                            Text("Add new device")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                                .multilineTextAlignment(.leading)
                                .textCase(.uppercase)
                            
                            Spacer()
                            
                            // Description
                            Text("Click above to add new device.")
                                .lineLimit(1)
                                .font(.system(size: 10, weight: .light))
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 12)
                            
                        } else if viewModel.viewState == .found {
                            Text("Found device")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                                .multilineTextAlignment(.leading)
                                .textCase(.uppercase)
                            
                            Spacer()
                        } else if viewModel.viewState == .connecting {
                            Text("Connecting")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                                .multilineTextAlignment(.leading)
                                .textCase(.uppercase)
                            
                            Spacer()
                        } else if viewModel.viewState == .not_found {
                            Text("Not found")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                                .multilineTextAlignment(.leading)
                                .textCase(.uppercase)
                            
                            Spacer()
                            
                            // Description
                            Text("Click above to repeat.")
                                .lineLimit(1)
                                .font(.system(size: 10, weight: .light))
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 12)
                        } else if viewModel.viewState == .failed_to_connect {
                            Text("Failed to connect")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                                .multilineTextAlignment(.leading)
                                .textCase(.uppercase)
                            
                            Spacer()
                            Text("Click above to repeat.")
                                .lineLimit(1)
                                .font(.system(size: 10, weight: .light))
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 12)
                        }
                        
                        
                        
                        
                    }
                    .padding(.leading, 16)
                    Spacer()
                }

                
            }
            .frame(width: 250, height: 230)
            .zIndex(1)
            
            
    
            
            VStack {
                

                VStack(alignment: .center) {
                    
         
                    HStack(alignment: .center) {
                        
                        if viewModel.viewState == .discovering || viewModel.viewState == .connecting {
                            // Show loading spinner
                            ProgressView() // You can customize the text
                                .progressViewStyle(CircularProgressViewStyle())
                                .tint(Color.white)
                                .colorInvert()
                                .scaleEffect(0.6)
                        
                        } else if viewModel.viewState == .not_discovering {
                            
                            VStack {
                                HStack {
                                    Image(systemName: "plus")
                                        .font(.system(size: 18, weight: .light))
                                    
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .foregroundColor(.white)
                                    
                                }
                                .frame(width: 60, height: 60)
                                .background(Color(#colorLiteral(red: 0.843137264251709, green: 0.09019608050584793, blue: 0.12941177189350128, alpha: 1)))
                                .clipShape(Circle())
                                .onTapGesture {
                                    viewModel.startDiscovery()
                                }
                            }
                            
                         
                        } else if viewModel.viewState == .found {
                            VStack {
                                HStack {
                                    Image(systemName: "earbuds")
                                        .font(.system(size: 24, weight: .light))
                                    
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .foregroundColor(.black)
                                    
                                }.frame(width: 60, height: 60)
                                    .background(.white)
                                    .clipShape(Circle())
                                    .onTapGesture {
                                        viewModel.connectToDevice()
                                    }
                                
                                Text(viewModel.deviceName)
                                    .lineLimit(1)
                                    .font(.system(size: 10, weight: .light))
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                                    .multilineTextAlignment(.leading)
                                
                            }
                        } else if viewModel.viewState == .not_found || viewModel.viewState == .failed_to_connect {
                            VStack {
                                HStack {
                                    Image(systemName: "arrow.trianglehead.clockwise")
                                        .font(.system(size: 18, weight: .light))
                                    
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .foregroundColor(.white)
                                    
                                }
                                .frame(width: 60, height: 60)
                                .background(Color(#colorLiteral(red: 0.843137264251709, green: 0.09019608050584793, blue: 0.12941177189350128, alpha: 1)))
                                .clipShape(Circle())
                                .onTapGesture {
                                    viewModel.startDiscovery()
                                }
                            }
                        }
                        
                        
                    }
             
                    
                    
                }
                .frame(width: 250, height: 230)
                
         
            
                
                
            }
            
            .navigationBarBackButtonHidden(true)
            .background(.black)
            .frame(width: 250, height: 230)

            
            
        }
        
        

    }
}



struct DiscoverView_Preview: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
