//
//  CoinIconView.swift
//  cryptoapp
//
//  Created by Nazareno Cavazzon on 20/11/2022.
//

import SwiftUI

struct CoinIconView: View {
    
    let coin: Coin
    
    var body: some View {
        VStack{
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline )
                .foregroundColor(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .lineLimit(12)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

struct CoinIconView_Previews: PreviewProvider {
    static var previews: some View {
        CoinIconView(coin: dev.coin)
            .previewLayout(.sizeThatFits)
    }
}
