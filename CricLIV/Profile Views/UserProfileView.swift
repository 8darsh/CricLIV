//
//  UserProfileView.swift
//  CricLIV
//
//  Created by Adarsh Singh on 20/06/24.
//

import SwiftUI

struct UserProfileView: View {
    @StateObject private var userViewModel = viewModel()

    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Text("Name: \(userViewModel.signup?.userName ?? "dgsg")")
                        .bold()
                        .font(.custom("arial", size: 16))
                    Text("Email: \(userViewModel.signup?.email ?? "dgdg")")
                        .bold()
                        .font(.custom("arial", size: 16))
                    
                }
            }
        }.navigationTitle("User")
            
    }
}

#Preview {
    UserProfileView()
}
