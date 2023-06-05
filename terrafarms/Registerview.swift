//
//  ContentView.swift
//  terrafarms
//
//  Created by azzam on 19/04/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct RegisterView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showPasswordWarning = false
    @State private var showErrorAlert = false
    @State private var errorMassage = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var passwordsMatch: Bool {
            return password == confirmPassword
        }

    var body: some View {
        VStack {
            Spacer()
            Image("terrafarms-logo").resizable().frame(width: 300.0, height: 75.0)
            Spacer()
            VStack(alignment: .leading) {
                Text("Selamat datang di Terrafarms!").font(.custom("Urbanist-Medium", size: 20)).padding(.bottom, 4)

                Text("Silahkan masuk dengan akun anda").font(.custom("Urbanist", size: 13))

                TextField("Username", text: $username).font(.custom("Urbanist", size: 13))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8).padding(.top)
                
                TextField("Email", text: $email).font(.custom("Urbanist", size: 13))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)

                SecureField("Password", text: $password).font(.custom("Urbanist", size: 13)).padding().background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                SecureField("Confirm Password", text: $confirmPassword).font(.custom("Urbanist", size: 13)).padding().background(Color(.secondarySystemBackground))
                    .cornerRadius(8).onChange(of: confirmPassword, perform: { value in
                        showPasswordWarning = !passwordsMatch
                    })
                
                if !passwordsMatch && showPasswordWarning {
                                Text("Passwords do not match")
                                    .foregroundColor(.red).font(.custom("Urbanist", size: 13))
                            }

                Button(action: {
                    if (username.isEmpty){
                        errorMassage = "Username belum diisi!"
                        showErrorAlert = true
                        
                    } else if (email.isEmpty){
                        errorMassage = "Email belum diisi!"
                        showErrorAlert = true
                    } else if (password.isEmpty){
                        errorMassage = "Password belum diisi!"
                        showErrorAlert = true
                    } else {
                        registerUser()
                    }
                }) {
                    Text("Daftar").font(.custom("Urbanist-Medium", size: 16))
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
                    // Perform login action
                }) {
                    Text("Daftar dengan Google").font(.custom("Urbanist-Medium", size: 16))
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
            HStack{
                Text("Sudah mempunyai akun?").font(.custom("Urbanist", size: 14))
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }){
                    Text("Login").font(.custom("Urbanist", size: 14))
                }
            }
            Spacer()
        }
    }
    
    func registerUser() {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print("Error registering user: \(error.localizedDescription)")
                    showErrorAlert = true
                    errorMassage = error.localizedDescription
                } else if let user = authResult?.user {
                    saveUserData(user: user)
                }
            }
        }
        
        func saveUserData(user: User) {
            let db = Firestore.firestore()
            let userData = [
                "username" : username,
                "email": user.email ?? "",
                // Add more user data fields as needed
            ]
            
            db.collection("users").document(user.uid).setData(userData) { error in
                if let error = error {
                    print("Error saving user data: \(error.localizedDescription)")
                } else {
                    print("User data saved successfully!")
                }
            }
        }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
