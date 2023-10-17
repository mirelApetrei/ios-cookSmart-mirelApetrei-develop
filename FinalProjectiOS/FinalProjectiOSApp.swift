//
//  FinalProjectiOSApp.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 22.08.23.
//

import SwiftUI
import Firebase

@main
struct FinalProjectiOSApp: App {
    
    init() {
        // Set up the Firebase app
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        _userRepository = StateObject(wrappedValue: UserRepository.shared)
    }
    var body: some Scene {
            WindowGroup {
                RootView()
                    .environmentObject(UserRepository.shared)
            }
        }


    // MARK: - Variables
    @StateObject var userRepository = UserRepository.shared
}
