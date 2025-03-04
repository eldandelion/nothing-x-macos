//
//  BudsSidePickerView.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 21/02/23.
//

import SwiftUI

struct BudsSidePickerView<SelectedBud: Hashable>: View {
    @Binding var selection: SelectedBud
    
    var body: some View {
        HStack(spacing: 40) {
            ForEach(EarBudSide.allCases) { side in
                VStack(spacing: 4) {
                    Text(side.rawValue.uppercased())
                        .padding(0)
                        .font(.custom("5by7", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)))
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 50, height: 2)
                        .foregroundColor(selection == side.id as! SelectedBud ? .white : .black )
                }
                .background(.black)
                .onTapGesture {
                    selection = side.id as! SelectedBud
                }
            }
        }
    }
}

struct BudsSidePickerView_Previews: PreviewProvider {
    static var previews: some View {
        BudsSidePickerView(selection: .constant(EarBudSide.left.rawValue))
    }
}
