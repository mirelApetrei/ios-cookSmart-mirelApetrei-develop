//
//  AuthenticationViewModel.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 30.08.23.
//

import Foundation
import FirebaseAuth

class AuthenticationViewModel: ObservableObject {

    // MARK: - Variables
    let userRepository = UserRepository.shared

    @Published var mode: AuthenticationMode = .login
    @Published var email = ""
    @Published var password = ""
    @Published var isAuthenticated = false

    // MARK: - Computed Properties

    var disableAuthentication: Bool {
        email.isEmpty || password.isEmpty
    }

    // MARK: - Functions

    func switchAuthenticationMode() {
        mode = mode == .login ? .register : .login
    }

    func authenticate() {
        switch mode {
        case .login: userRepository.login(email: email, password: password)
        case .register: userRepository.register(email: email, password: password)
        }
//        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
//            if let error = error {
//                // Handle the error appropriately
//                print("Authentication failed with error: \(error.localizedDescription)")
//                return
//            }

            // If authentication is successful, set isAuthenticated to true
            self.isAuthenticated = true
        }
    }
