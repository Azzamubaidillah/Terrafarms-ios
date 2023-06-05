//
//  ContentView.swift
//  terrafarms
//
//  Created by azzam on 19/04/23.
//

import Firebase
import FirebaseAuth
import GoogleSignIn
import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSignedIn = false
    @State private var showErrorAlert = false
    @State private var errorMassage = ""
    @State private var isLoading = false
    private var user: GIDGoogleUser? {
        return GIDSignIn.sharedInstance.currentUser
    }

    var body: some View {
        NavigationView {
            if isSignedIn {
                HomeView()
            } else {
                if isLoading {
                    ProgressView("Loading...")
                } else {
                    VStack {
                        Spacer()
                        Image("terrafarms-logo").resizable().frame(width: 300.0, height: 75.0)
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Selamat datang di Terrafarms!").font(.custom("Urbanist-Medium", size: 20)).padding(.bottom, 4)

                            Text("Silahkan masuk dengan akun anda").font(.custom("Urbanist", size: 13))

                            TextField("Email", text: $email).font(.custom("Urbanist", size: 13))
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(8).padding(.top)

                            SecureField("Password", text: $password).font(.custom("Urbanist", size: 13)).padding().background(Color(.secondarySystemBackground))
                                .cornerRadius(8)

                            Button(action: {
                                print("login")

                                if email.isEmpty || email == "" || password.isEmpty || password == "" {
                                    errorMassage = "Email atau Password belum diisi!"
                                    showErrorAlert = true

                                } else {
                                    isLoading = true
                                    Auth.auth().signIn(withEmail: email, password: password) { _, error in
                                        if let error = error {
                                            // Handle sign in error
                                            errorMassage = error.localizedDescription
                                            showErrorAlert = true
                                            print("Sign in error: \(error.localizedDescription)")
                                        } else {
                                            // Sign in successful, update state variable to reflect sign-in status
                                            isSignedIn = true
                                            print("Sign in successful")
                                        }
                                    }
                                }
                            }) {
                                Text("Masuk").font(.custom("Urbanist-Medium", size: 16))
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.accentColor)
                                    .cornerRadius(8)
                            }
                            .padding(.top, 16).alert(isPresented: $showErrorAlert) {
                                Alert(title: Text("Error"),
                                      message: Text(errorMassage),
                                      dismissButton: .default(Text("OK")))
                            }
                            Button(action: {
                                print("login dengan google")

                            }) {
                                HStack {
                                    Image("google-logo")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                    Text("Masuk dengan Google")
                                        .font(.custom("Urbanist-Medium", size: 16))
                                }
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

                        }.padding(.horizontal)

                        Spacer()
                        HStack {
                            Text("Belum mempunyai akun?").font(.custom("Urbanist", size: 14))

                            NavigationLink(destination: RegisterView().navigationBarBackButtonHidden(true)) {
                                Text("Daftar").font(.custom("Urbanist", size: 14))
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
