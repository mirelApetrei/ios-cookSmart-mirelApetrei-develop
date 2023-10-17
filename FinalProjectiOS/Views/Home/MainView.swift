//
//  MainView.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 11.10.23.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0

      var body: some View {

          TabView(selection: $selectedTab) {
              NavigationView {
                  HomeView()
              }
                  .tabItem {
                      Image(systemName: "house.fill")
                      Text("Home")
                  }
                  .tag(0)

              FavoritesView()
                  .tabItem {
                      Image(systemName: "star.fill")
                      Text("Favorites")
                  }
                  .tag(1)

              SettingsView()
                  .tabItem {
                      Image(systemName: "gearshape.fill")
                      Text("Settings")
                  }
                  .tag(2)
          }
          .background(.gray)
          .opacity(1)
      }
}

#Preview {
    MainView()
}
