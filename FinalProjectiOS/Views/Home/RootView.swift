//
//  RootView.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 12.10.23.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var userRepository: UserRepository

    var body: some View {
        Group {
            if userRepository.userIsLoggedIn.value {
                MainView()
            } else {
                AuthenticationView()
            }
        }
    }
}


//#Preview {
//    RootView()
//}
