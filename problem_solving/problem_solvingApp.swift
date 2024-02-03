//
//  problem_solvingApp.swift
//  problem_solving
//
//  Created by Sviatoslav Gladyshev on 23/11/2023.
//

import SwiftUI
import Firebase


@main
struct problem_solvingApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            GetStarted()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


