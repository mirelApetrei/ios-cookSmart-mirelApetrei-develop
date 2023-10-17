//
//  UserViewModel.swift
//  FinalProjectiOS
//
//  Created by Apetrei Mirel on 11.10.23.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {

    @Published var userId: String?
     var userRepository = UserRepository.shared

    init() {
        // Subscribe to user updates from UserRepository
        userRepository.user
            .sink { user in
                self.userId = user?.id
            }
            .store(in: &cancellable)
    }

    // Store subscription Cancellables
    private var cancellable = Set<AnyCancellable>()
}

