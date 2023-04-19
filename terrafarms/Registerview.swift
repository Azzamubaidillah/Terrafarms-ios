//
//  ContentView.swift
//  terrafarms
//
//  Created by azzam on 19/04/23.
//

import SwiftUI

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Spacer()
            Image("terrafarms-logo")
            Spacer()
            VStack(alignment: .leading) {
                Text("Selamat datang di Terrafarms!").font(.custom("Urbanist-Medium", size: 20)).padding(.bottom, 4)

                Text("Silahkan masuk dengan akun anda").font(.custom("Urbanist", size: 13))

                TextField("Username", text: $email).font(.custom("Urbanist", size: 13))
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
                SecureField("Confirm Password", text: $password).font(.custom("Urbanist", size: 13)).padding().background(Color(.secondarySystemBackground))
                    .cornerRadius(8)

                Button(action: {
                    // Perform login action
                }) {
                    Text("Daftar").font(.custom("Urbanist-Medium", size: 16))
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(8)
                }
                .padding(.top, 16)
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
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
