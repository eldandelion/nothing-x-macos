//
//  DiscoverView.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/21.
//


import SwiftUI

struct DiscoverView : View {
    
    
    @StateObject private var viewModel = DiscoverViewViewModel(nothingService: NothingServiceImpl.shared, bluetoothService: BluetoothServiceImpl())
    
    
    
    var body : some View {
        ZStack {
            
            VStack {
                HStack {
                    
                    
                    if false {
                        BackButtonView()
                    }
               
                    Spacer()
                    
                    
                    // Quit
                    QuitButtonView()
                    
                }
         
                
                // Heading
                HStack() {
                    VStack(alignment: .leading) {
                        
        
                            Text("Add new device")
                                .font(.custom("5by7", size: 16))
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
                        
                            
                        NavigationLink(value: viewModel.destination) {
                                HStack {
                                    Image(systemName: "plus")
                                        .font(.system(size: 18, weight: .light))
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .foregroundColor(.white)
                                }
                                .frame(width: 60, height: 60)
                                .background(Color(#colorLiteral(red: 0.843137264251709, green: 0.09019608050584793, blue: 0.12941177189350128, alpha: 1)))
                                .clipShape(Circle())
                                
                            }
                             // Optional: to remove default button styling
                            .buttonStyle(TransparentButton())
                            
        
                    }
                    
                }
                .frame(width: 250, height: 230)
                
            }
            
            .navigationBarBackButtonHidden(true)
            .background(.black)
            .frame(width: 250, height: 230)
            .onAppear {
                viewModel.checkBluetoothStatus()
            }

        }
        
    }
}



struct DiscoverView_Preview: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
