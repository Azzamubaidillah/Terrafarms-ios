//
//  ContentView.swift
//  terrafarms
//
//  Created by azzam on 20/04/23.
//

import Firebase
import FirebaseAuth
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = AuthViewModel()

    var body: some View {
        Group {
            if viewModel.isUserAuthenticated {
                HomeView()
            } else {
                LoginView()
            }
        }
        .onAppear {
            viewModel.setupAuthStateListener()
        }
    }
}

class AuthViewModel: ObservableObject {
    @Published var isUserAuthenticated = false

    func setupAuthStateListener() {
        Auth.auth().addStateDidChangeListener { _, user in
            self.isUserAuthenticated = user != nil
        }
    }
}
