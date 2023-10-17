//
//  UserRepository.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 30.08.23.
//
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore
import Combine


class UserRepository: ObservableObject {

    init() {
        Self.initialize()
    }


    static func initialize() {
            if FirebaseApp.app() == nil {
                FirebaseApp.configure()
            }
        }

// MARK: - Functions

    // MARK: - checkAuth()
    func checkAuth() {
        guard let currentUser = auth.currentUser else {
            print("Not logged in")
            return
        }

        // Check Firestore if user is logged in
        self.firestoreDataBase.collection("users").document(currentUser.uid).getDocument { document, error in
            if let document = document, document.exists, let data = document.data(), let loggedIn = data["loggedIn"] as? Bool, loggedIn {
                // User is logged in
                self.userIsLoggedIn.send(true)
                print("User is logged in")

            } else {
                print("Not logged in")
            }
        }

        if let storedToken = retrieveAuthToken() {
            // Use the stored authentication token to authenticate the user
            auth.signIn(withCustomToken: storedToken) { authResult, error in
                if let error = error {
                    print("Automatic login failed:", error.localizedDescription)
                    // Handle the error appropriately, e.g., show login screen
                } else {
                    // Authentication successful, update user state
                    self.userIsLoggedIn.send(true)
                    print("User automatically logged in")
                }
            }
        } else {
            print("Not logged in")
        }
    }



    // MARK: - login()
    func login(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                print("Login failed:", error?.localizedDescription ?? "Unknown error")
                return
            }

            // Store the user object
            self.user.send(User(id: user.uid, email: user.email ?? "", password: "", likedRecipes: []))

            // Update user state
            self.userIsLoggedIn.send(true)
            print("User with email '\(email)' is logged in with id '\(user.uid)'")
        }
    }


    // MARK: - register()
    func register(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                print("Registration failed:", error?.localizedDescription ?? "Unknown error")
                return
            }
            print("User with email '\(email)' is registered with id '\(user.uid)'")

            // Save user in Firestore
            self.firestoreDataBase.collection("users").document(user.uid).setData([
                "email": email,
                "loggedIn": true
            ]) { firestoreError in
                if let firestoreError = firestoreError {
                    print("Firestore save failed:", firestoreError.localizedDescription)
                    return
                }

                // Update the user object and login
                self.user.send(User(id: user.uid, email: email, password: "", likedRecipes: []))
                self.userIsLoggedIn.send(true)
            }
        }
    }



    // MARK: - logout()
    func logout() {
        do {
            try auth.signOut()

            // Clear the stored authentication token
            clearAuthToken()

            // Clear the user object
            self.user.send(nil)  // Assuming user is of type User?

            // Update Firestore user state if needed
            if let userId = self.user.value?.id {  // Using `.value` based on your setup; adjust as needed
                firestoreDataBase.collection("users").document(userId).updateData([
                    "loggedIn": false
                ]) { error in
                    if let error = error {
                        print("Error updating Firestore user state:", error.localizedDescription)
                        // Optionally, you might want to show a user alert here
                    }
                }
            }

            // Update user state
            self.userIsLoggedIn.send(false)

            // Clear any user-specific cache, background tasks, etc. if applicable
            // ... (you'll need to implement this based on your app's needs)

            print("User logged out!")

        } catch {
            print("Error signing out:", error.localizedDescription)
            // Consider showing a user alert or feedback UI here
        }
    }


    // MARK: - Variables
    
    static let shared = UserRepository()
    private var auth = Auth.auth()
    @Published var userIsLoggedIn = CurrentValueSubject<Bool, Never>(false)
    @Published var user = CurrentValueSubject<User?, Never>(nil)
    private let firestoreDataBase = Firestore.firestore()


    // MARK: - Token Storage

      private let authTokenKey = "AuthTokenKey"

      private func storeAuthToken(_ token: String) {
          // Store the authentication token securely
          // Example using UserDefaults:
          UserDefaults.standard.set(token, forKey: authTokenKey)
      }

      private func retrieveAuthToken() -> String? {
          // Retrieve the stored authentication token
          // Example using UserDefaults:
          return UserDefaults.standard.string(forKey: authTokenKey)
      }

      private func clearAuthToken() {
          // Clear the stored authentication token
          // Example using UserDefaults:
          UserDefaults.standard.removeObject(forKey: authTokenKey)
      }

}
