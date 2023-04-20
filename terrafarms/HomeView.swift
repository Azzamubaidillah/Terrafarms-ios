//
//  ContentView.swift
//  terrafarms
//
//  Created by azzam on 20/04/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct HomeView: View {
    var body: some View {
        Text("Home")
        Button(action: {
            do {
                try Auth.auth().signOut()
                // Sign out successful, do something
                print("Sign out successful")
            } catch let signOutError as NSError {
                // Handle sign out error
                print("Sign out error: \(signOutError.localizedDescription)")
            }

        }) {
            Text("Sign Out").font(.custom("Urbanist-Medium", size: 16))
                .foregroundColor(.accentColor)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(8).overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.accentColor)
                )
        }
        .padding(.top, 8)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
