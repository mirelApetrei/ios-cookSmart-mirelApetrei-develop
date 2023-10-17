//
//  AuthenticationView.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 30.08.23.
//

import SwiftUI

struct AuthenticationView: View {

    var body: some View {
        ZStack {
            Color("backgroundColor")
                .edgesIgnoringSafeArea(.all)
            NavigationStack {
                VStack(spacing: 48) {
                    VStack(spacing: 12) {
                        ZStack(alignment: .bottom) {
                            TextField("E-Mail", text: $authenticationViewModel.email)
                                .frame(minHeight: 36)
                            Divider()
                        }
                        ZStack(alignment: .bottom) {
                            SecureField("Passwort", text: $authenticationViewModel.password)
                                .frame(minHeight: 36)
                            Divider()
                        }
                    }
                    .font(.headline)
                    .textInputAutocapitalization(.never)
                    PrimaryButton(title: authenticationViewModel.mode.title, action: authenticationViewModel.authenticate)
                        .disabled(authenticationViewModel.disableAuthentication)
                    TextButton(title: authenticationViewModel.mode.alternativeTitle, action: authenticationViewModel.switchAuthenticationMode)
                    NavigationLink("", destination: HomeView(), isActive: $authenticationViewModel.isAuthenticated)
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 24)
                .background(.regularMaterial)
                .cornerRadius(12)
                .padding(.horizontal, 36)
                .background(
                    Image("background")
                        .scaledToFill()
                )
            }
        }
    }

    // MARK: - Variables
    @StateObject private var authenticationViewModel = AuthenticationViewModel()
    @StateObject private var ingredientViewModel = IngredientViewModel()

}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
