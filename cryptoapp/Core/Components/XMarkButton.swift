//
//  XMarkButton.swift
//  cryptoapp
//
//  Created by Nazareno Cavazzon on 20/11/2022.
//

import SwiftUI

struct XMarkButton: View {
    
    var dismiss: DismissAction?
    
    var body: some View {
        Button {
            dismiss!()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .foregroundColor(Color.theme.accent)
        }
    }
}

struct XMarkButton_Previews: PreviewProvider {
    
    static var previews: some View {
        XMarkButton()
    }
}
