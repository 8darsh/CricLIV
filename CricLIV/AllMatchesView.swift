//
//  AllMatchesView.swift
//  CricLIV
//
//  Created by Adarsh Singh on 18/06/24.
//

import SwiftUI

struct AllMatchesView: View {
    @StateObject private var AllMatchedViewModel = viewModel()
    var body: some View {
        NavigationStack{
            
            ZStack{
                
                LinearGradient(gradient: Gradient(colors: [Color(red: 45/255, green: 43/255, blue: 58/255), Color(red: 34/255, green: 33/255, blue: 48/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading){
//                    Text("All Matches")
//                        .font(.title)
//                        .foregroundStyle(.white)
//                        .bold()
                    ScrollView(.vertical,showsIndicators: false){
                        
                        UpcomingMatchesView(upcomingMatch: AllMatchedViewModel)
                        
                    }.padding()
                    
                    
                }.task {
                    await AllMatchedViewModel.fetchUpcomingMatches()
                }
            }
            
            .navigationTitle("Matches")
        }.onAppear{
            Task{
              await AllMatchedViewModel.fetchUpcomingMatches()
            }
        }
        
        
        
       
        
    }
}

#Preview {
    NavigationStack{
        AllMatchesView()
    }
}




