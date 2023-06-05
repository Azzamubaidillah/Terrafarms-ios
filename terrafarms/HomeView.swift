//
//  ContentView.swift
//  terrafarms
//
//  Created by azzam on 20/04/23.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore
import SwiftUI
// import GoogleSignIn

func getGreeting() -> String {
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: Date())

    switch hour {
    case 0 ..< 12:
        return "Selamat Pagi!"
    case 12 ..< 17:
        return "Selamat Siang!"
    default:
        return "Selamat Sore!"
    }
}

struct HomeView: View {
    @State private var userID = Auth.auth().currentUser?.uid
    @State private var username = ""
    @State private var isLoading = false

    let greetings = getGreeting()
    var body: some View {
        if isLoading {
            ProgressView("Loading...")
        } else {
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(greetings).font(.custom("Urbanist-Medium", size: 12))
                            .foregroundColor(.gray)
                        Text(username).font(.custom("Urbanist-Medium", size: 16)).fontWeight(.bold)
                            .foregroundColor(.accentColor)
                    }
                    Spacer()
                    Image("shopping-cart")
                    Image("notification")
                }.onAppear(perform: getUsername)

                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1).frame(height: 60)
                    .overlay(
                        HStack {
                            Spacer()
                            HStack {
                                Image("cloud")
                                Text("Berawan").foregroundColor(.green)
                            }
                            Spacer()
                            Text("32°C").fontWeight(.bold)
                            Spacer()
                            HStack {
                                Image(systemName: "map").foregroundColor(.green)
                                Text("Berawan")
                            }
                            Spacer()
                        }.font(.custom("Urbanist-Medium", size: 16))
                            .foregroundColor(.accentColor)
                    ).padding(.vertical)

                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1).frame(height: 80)
                    .overlay(
                        VStack {
                            HStack {
                                Image(systemName: "map").foregroundColor(.green)
                                Text("Lahan Jagung Mandalamekar")
                            }

                            HStack {
                                VStack {
                                    HStack {
                                        Text("6.3")
                                        Image(systemName: "info.circle")
                                    }
                                    Text("pH")
                                }
                                VStack {
                                    HStack {
                                        Text("5%")
                                        Image(systemName: "info.circle")
                                    }
                                    Text("Kelembapan Tanah")
                                }
                                VStack {
                                    HStack {
                                        Text("2000 ppm")
                                        Image(systemName: "info.circle")
                                    }
                                    Text("Tds")
                                }
                            }
                        }.font(.custom("Urbanist", size: 16))
                            .foregroundColor(.accentColor)
                    )

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
                Spacer()
            }.padding(.horizontal, 16.0)
        }
    }

    func getUsername() {
        let db = Firestore.firestore()

        db.collection("users").document(userID ??
            "default").getDocument { document, _ in
            if let document = document, document.exists {
                let data = document.data()
                if let username = data?["username"] as? String {
                    self.username = username
                    isLoading = false
                } else {
                    print("Username field not found")
                }
            } else {
                print("User document not found")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
