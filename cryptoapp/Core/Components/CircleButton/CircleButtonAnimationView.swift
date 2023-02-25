//
//  CircleButtonAnimationView.swift
//  cryptoapp
//
//  Created by Nazareno Cavazzon on 16/11/2022.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeInOut(duration: 1) : .none, value: UUID())
    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    
    static var previews: some View {
        CircleButtonAnimationView(animate: .constant(false))
            .foregroundColor(.red)
            .frame(width: 100, height: 100)
    }
}
