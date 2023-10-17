//
//  CustomTabBarNav.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 19.09.23.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case house
    case star
    case gear
    
}



struct CustomTabBarNav: View {

    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage: tab.rawValue)
                    Spacer()
                }

            }
            .frame(width: nil, height: 60)
            .background(.thinMaterial)
            .cornerRadius(20)
            .padding()

        }
    }


    // MARK: - Variables

    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }

}

struct CustomTabBarNav_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarNav(selectedTab: .constant(.house))
    }
}
