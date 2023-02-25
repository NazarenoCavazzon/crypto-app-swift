//
//  ContentView.swift
//  cryptoapp
//
//  Created by Nazareno Cavazzon on 15/11/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            VStack{
                Text("Accent color")
                    .foregroundColor(Color.theme.accent)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
