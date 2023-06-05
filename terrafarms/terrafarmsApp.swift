//
//  terrafarmsApp.swift
//  terrafarms
//
//  Created by azzam on 19/04/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
//import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        //GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        return true
    }
}

@main
struct terrafarmsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

