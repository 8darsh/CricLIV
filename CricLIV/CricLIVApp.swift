//
//  CricLIVApp.swift
//  CricLIV
//
//  Created by Adarsh Singh on 18/06/24.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn
import SDWebImageSVGCoder
class AppDelegate: NSObject, UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if GIDSignIn.sharedInstance.handle(url){
            return true
        }
        return false
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
}


@main
struct CricLIVApp: App {
    
    
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init(){
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                ContentView(matches: LiveMatch(matchId: 1, matchNumberVenue: "asb", battingTeam: "sda", battingTeamScore: "djc", bowlTeam: "dcv", bowlTeamScore: "dv", liveText: "dv"), username: .constant("username"), email: .constant("email"), jwtToken: .constant(""))
            }
        }
    }
}
