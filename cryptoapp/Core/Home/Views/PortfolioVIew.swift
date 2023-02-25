//
//  PortfolioView.swift
//  cryptoapp
//
//  Created by Nazareno Cavazzon on 20/11/2022.
//

import SwiftUI

struct PortfolioView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: Coin? = nil
    @State private var quantityText: String = ""

    var body: some View {
        
        let allowSave: Bool = selectedCoin?.currentHoldings != Double(quantityText)
        
        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing: 0){
                    SearchBarView(searchText: $vm.searchText)
                    coinIconList
                    
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    XMarkButton(dismiss: dismiss)
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        saveButtonPressed()
                        dismiss()
                    } label: {
                        Text("Save".uppercased())
                            .font(.headline)
                            .foregroundColor(allowSave ? Color.blue : Color.theme.accent)
                            .animation(.easeIn(duration: 0.2))
                    }
                }
            }
            .onChange(of: vm.searchText) { newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
}

extension PortfolioView {
    private var coinIconList : some View{
        ScrollView(.horizontal, showsIndicators: false){
            LazyHStack(spacing: 10){
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinIconView(coin: coin)
                        .frame(width: 65)
                        .padding()
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.theme.background)
                                .shadow(
                                    color:
                                        selectedCoin?.id == coin.id ?
                                    Color.theme.green.opacity(0.6) : Color.clear,
                                    radius: 4, y: 1.5)
                        )
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
    }
    
    private func updateSelectedCoin(coin: Coin) {
        selectedCoin = coin
        
         if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
            let amount = portfolioCoin.currentHoldings {
             quantityText = "\(amount)"
         } else {
             quantityText = ""
         }
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioInputSection: some View{
            VStack(spacing: 20){
                HStack{
                    Text("Current price of \(selectedCoin?.symbol.uppercased() ?? "")")
                    Spacer()
                    Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
                }
                Divider()
                HStack {
                    Text("Amount holding:")
                    Spacer()
                    TextField("Ex: 1.4", text: $quantityText)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }
                Divider()
                HStack{
                    Text("Current value:")
                    Spacer()
                    Text(getCurrentValue().asCurrencyWith2Decimals())
                }
            }
            .transaction { transaction in
                transaction.animation = nil
            }
            .padding()
            .font(.headline)
    }
    
    private func saveButtonPressed() {
        
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else { return }
        
        // save to portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        // unselect coin
        withAnimation(.easeIn){
            removeSelectedCoin()
            quantityText = ""
        }
        
        // hide keyboard
        UIApplication.shared.endEditing()

//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            withAnimation(.easeOut) {
//                show
//            }
//        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
    
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}
