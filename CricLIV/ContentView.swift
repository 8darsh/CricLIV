//
//  ContentView.swift
//  CricLIV
//
//  Created by Adarsh Singh on 18/06/24.
//

import SwiftUI
import Firebase
struct ContentView: View {
     var matches: LiveMatch
    @State private var isSignedIn = false
    @Binding var username:String
    @Binding var email:String
    @Binding var jwtToken: String
    var body: some View {
        NavigationStack{
            if isSignedIn{
                
                MainTabbedView(isSignedIn: $isSignedIn, username: $username, email: $email)
                
            }else{
                SignInView(isSignedIn: $isSignedIn,username: $username)
            }
            
        }.navigationBarBackButtonHidden(true)
//        }.onAppear(perform: {
//            checkAuth()
//        })
    }
}

extension ContentView{
//    func checkAuth(){
//        if Auth.auth().currentUser != nil{
//            isSignedIn = true
//        }else{
//            isSignedIn = false
//        }
//    }
}

#Preview {
    ContentView(matches: LiveMatch(matchId: 1, matchNumberVenue: "dsvdf", battingTeam: "ds", battingTeamScore: "dsf", bowlTeam: "sfd", bowlTeamScore: "sfd", liveText: "fgg"), username: .constant("username"), email: .constant(""), jwtToken: .constant(""))
}
