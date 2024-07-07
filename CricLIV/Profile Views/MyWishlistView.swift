//
//  MyWishlistView.swift
//  CricLIV
//
//  Created by Adarsh Singh on 06/07/24.
//

import SwiftUI

struct MyWishlistView: View {
    @StateObject var bookmarkedModel = viewModel()
    var body: some View {
        NavigationStack{
            
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color(red: 45/255, green: 43/255, blue: 58/255), Color(red: 34/255, green: 33/255, blue: 48/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea(.all)
                ScrollView(.vertical,showsIndicators: false){
                    UpcomingMatchesView(upcomingMatch: bookmarkedModel)
                }.padding()
                    .refreshable {
                        await bookmarkedModel.fetchBookmarkedMatches()
                    }
                .task {
                    
                    await bookmarkedModel.fetchBookmarkedMatches()
                }
                
                
            }
        }.navigationTitle("My wishlist")
            .toolbar{
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        Task{
                            await bookmarkedModel.clearAllBookmark()
                            await bookmarkedModel.fetchBookmarkedMatches()
                        }
                    }label: {
                        Image(systemName: "minus.circle")
                        
                            
                            
                    }
                }
            
            }
            
    }
}
#Preview {
    NavigationStack{
        MyWishlistView()
    }
}


