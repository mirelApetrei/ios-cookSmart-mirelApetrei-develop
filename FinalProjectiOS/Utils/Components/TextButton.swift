//
//  TextButton.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 30.08.23.
//

import SwiftUI

struct TextButton: View {

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color("secondaryButtonColor"))
        }
    }

// MARK: - Variables
    let title: String
    let action: () -> Void
}

struct TextButton_Previews: PreviewProvider {
    static var previews: some View {
        TextButton(title: "Anmelden") { }
    }
}
