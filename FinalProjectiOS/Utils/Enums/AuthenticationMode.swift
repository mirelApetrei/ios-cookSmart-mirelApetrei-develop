//
//  AuthenticationMode.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 30.08.23.
//

import Foundation

enum AuthenticationMode {
    case login, register

    var title: String {
        switch self {
        case .login: return "Login"
        case .register: return "Sign Up"
        }
    }

    var alternativeTitle: String {
        switch self {
        case .login: return "You have no account? Sign Up →"
        case .register: return "Already registered? Login →"
        }
    }
}
