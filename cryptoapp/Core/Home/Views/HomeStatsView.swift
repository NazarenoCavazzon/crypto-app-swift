//
//  HomeStatsView.swift
//  cryptoapp
//
//  Created by Nazareno Cavazzon on 18/11/2022.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
        let phoneWidth = UIScreen.main.bounds.width
        
        HStack {
            ForEach(vm.statistics){ stat in
                StatisticView(stat: stat)
                    .frame(width: phoneWidth / 3)
            }
        }
        .frame(width: phoneWidth, alignment: showPortfolio ? .trailing : .leading)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPortfolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
