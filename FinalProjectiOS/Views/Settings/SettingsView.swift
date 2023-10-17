//
//  SettingsView.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 11.10.23.
//

import SwiftUI

struct SettingsView: View {

    var body: some View {
           VStack {
               Text("Welcome, \(userRepository.user.value?.email ?? "User")")
                   .padding()
                   .fontWeight(.heavy)

               Image(systemName: "person.fill")
                   .resizable()
                   .scaledToFit()
                   .frame(width: 100, height: 100)
                   .padding()

               Button(action: {
                   userRepository.logout()
               }) {
                   Text("Log Out")
                       .bold()
                       .foregroundColor(.white)
                       .padding()
                       .background(Color.red)
                       .cornerRadius(10)
               }
           }
       }

    // MARK: - Variables:

    @ObservedObject var userRepository = UserRepository()
}

#Preview {
    SettingsView()
}
