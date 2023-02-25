//
//  HomeView.swift
//  cryptoapp
//
//  Created by Nazareno Cavazzon on 15/11/2022.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false // animate right
    @State private var showPorfolioView: Bool = false // new sheet
    @State private var showSettingsView: Bool = false
    
    
    var body: some View {
        ZStack{
            /// Background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPorfolioView, content: {
                    PortfolioView()
                        .environmentObject(vm)
                })
            
            /// Content layer
            VStack(){
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                
                columnTitles
                if vm.allCoins.isEmpty {
                    Spacer()
                    ProgressView()
                } else {
                    if !showPortfolio {
                        allCoinList
                        .transition(.move(edge: .leading))
                    } else {
                        portFolioCoinsList
                            .transition(.move(edge: .trailing))
                    }
                }
                
                Spacer(minLength: 0)
            }
            .onAppear {
                print(vm.isLoading)
            }
        }
        .sheet(isPresented: $showSettingsView, content: {
            SettingsView()
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .toolbar(.hidden)
        }
        .environmentObject(dev.homeVM)
    }
}

extension HomeView {
    private var homeHeader: some View{
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .transaction { transaction in
                    transaction.animation = nil
                }
                .onTapGesture {
                    if showPortfolio {
                        showPorfolioView.toggle()
                    } else {
                        showSettingsView.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .transaction { transaction in
                    transaction.animation = nil
                }
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()){
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                NavigationLink(destination: LazyView{ DetailView(coin: coin) }){
                    CoinRowView(coin: coin, showHoldingsColumn: false)
                }
                .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                .buttonStyle(.plain)
            }
        }
        .listStyle(PlainListStyle())
        .refreshable {
            vm.reloadData()
            do{
                while vm.isLoading {
                    try await Task.sleep(nanoseconds: 500_000_000)
                }
            } catch {}
        }
    }
    
    private var portFolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                NavigationLink(destination: LazyView{ DetailView(coin: coin) }){
                    CoinRowView(coin: coin, showHoldingsColumn: true)
                }
                .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                .buttonStyle(.plain)
            }
        }
        .listStyle(PlainListStyle())
        .refreshable {
            vm.reloadData()
            do{
                while vm.isLoading {
                    try await Task.sleep(nanoseconds: 500_000_000)
                }
            } catch {}
        }
    }
    
    private var columnTitles: some View {
        HStack{
            HStack(spacing: 4){
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default){
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            if showPortfolio{
                HStack(spacing: 4){
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default){
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            HStack(spacing: 4){
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default){
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
