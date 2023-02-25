import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    let swiftfulThinkingChannel = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
    let githubURL = URL(string: "https://github.com/NazarenoCavazzon")!
    let linkedInURL = URL(string: "https://www.linkedin.com/in/cavazzon")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    
    var body: some View {
        NavigationView {
            List {
                swiftfulThinking
                coinGeckoSection
                developerSection
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton(dismiss: dismiss)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    
    private var swiftfulThinking: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made by following a @SwiftulThinkong course on Youtube. It uses MVVM Architechture, Combine and CoreData!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link("Youtube channel", destination: swiftfulThinkingChannel)
        } header: {
            Text("SWIFTFUL THINKING")
        }
    }
    
    private var coinGeckoSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link("Homepage", destination: coingeckoURL)
        } header: {
            Text("CoinGecko")
        }
    }
    
    private var developerSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("photo")
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was developed by Nazareno Cavazzon. It uses SwiftUI and is written 100% in Swift. The project benefits from multi-threading, publishers/subscribers and data persistence.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link("LinkedIn", destination: linkedInURL)
            Link("Github", destination: githubURL)
        } header: {
            Text("ABOUT ME")
        }
    }
    
}
