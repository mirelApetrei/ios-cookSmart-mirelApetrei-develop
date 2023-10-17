//
//  PrimaryButton.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 30.08.23.
//

import SwiftUI

struct PrimaryButton: View {
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
        }
        .padding(.vertical, 12)
        .background(Color("primaryButtonColor"))
        .cornerRadius(50)
    }
    // MARK: - Variables
    let title: String
    let action: () -> Void
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(title: "Login") {}
    }
}
