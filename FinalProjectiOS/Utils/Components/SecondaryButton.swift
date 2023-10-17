//
//  SecondaryButton.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 19.09.23.
//

import SwiftUI

struct SecondaryButton: View {
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: 160)
                .foregroundColor(.white)
        }
        .padding(.vertical, 8)
        .background(Color("primaryButtonColor"))
        .cornerRadius(50)
    

    }

    // MARK: Variables
    let title: String
    let action: () -> Void
}

#Preview {
    SecondaryButton(title: "Search", action: {})
}
