//
//  HomeView.swift
//  CricLIV
//
//  Created by Adarsh Singh on 18/06/24.
//

import SwiftUI
import SVGKit
import SDWebImageSwiftUI
import UserNotifications
struct HomeView: View {
    @StateObject private var matchViewModel = viewModel()
    
    

    var body: some View {
        NavigationStack {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    LiveMatchView(matches: matchViewModel)
                }
                .scrollTargetBehavior(.viewAligned)
                .task {
                    
                    await matchViewModel.fetchLiveMatch()
                    await matchViewModel.fetchUpcomingMatches()
                }
            }
            .padding(.leading)
            .refreshable {
               
                await matchViewModel.fetchLiveMatch()
            }

            Text("**Upcoming Matches**")
                .foregroundStyle(.white)
                .font(.system(size: 22))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .padding(.bottom)
            
            ScrollView(.vertical, showsIndicators: false) {
                UpcomingMatchesView(upcomingMatch: matchViewModel)
            }
            .padding(.bottom, 30)
        }.onAppear{
            Task{
                await matchViewModel.fetchLiveMatch()
                await matchViewModel.fetchUpcomingMatches()
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 45/255, green: 43/255, blue: 58/255), Color(red: 34/255, green: 33/255, blue: 48/255)]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .background(ignoresSafeAreaEdges: .all)
    }
    
    func requestPermission(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { granted, error in
            
            if let error{
                print("Error requesting notification permission: \(error.localizedDescription)")
            }
            
            if granted{
                print("Notification permission granted")
            }else{
                print("Notification permission denied")
            }
        }
    }
}


#Preview{
    NavigationStack{
        HomeView()
    }
}




struct LiveMatchView: View {
    
    @StateObject var matches: viewModel
    var body: some View {
        LazyHStack(spacing: 0){
            ForEach(matches.livematch, id: \.matchId){
                matche in
                VStack(alignment: .leading){
                    Button{
                        
                    }label: {
                        Image(systemName: "livephoto")
                            .imageScale(.small)
                        Text("LIVE")
                            .bold()
                            .font(.caption2)
                    }
                    
                    .frame(width: 65, height: 25)
                    .aspectRatio(contentMode: .fit)
                    .background(Color.red)
                    .foregroundStyle(.white)
                    
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    
                    
                    
                    
                    Text(matche.matchNumberVenue)
                        .frame(alignment: .leading)
                        
                        .font(.caption)

                        .foregroundStyle(.gray)
                        .padding(.top,5)
                        .padding(.bottom,5)

                    
                    
                    HStack(){
                        Text(matche.battingTeam)
                            .bold()
                            .font(.subheadline)
                            .foregroundColor(.black)
                           
                            
                        Spacer()
                        Text(matche.battingTeamScore)
                            .font(.subheadline)
                            .padding(.trailing,30)
                            .foregroundStyle(.black)
                            .bold()
                        
                        
                    }.padding(.bottom)
                    
                    HStack(alignment:.top) {
                        Text(matche.bowlTeam)
                            .font(.subheadline)
                            
                            .foregroundColor(.black)
                            .bold()
                            
                        Spacer()
                        Text(matche.bowlTeamScore)
                            .font(.subheadline)
                            .padding(.trailing,30)
                            .foregroundStyle(.black)
                            .bold()
                    }
                    
                    
                    Text(matche.liveText)
                        
                        .frame(maxWidth: .infinity,alignment:.center)
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(.top,5)
                        .padding(.trailing,20)
                    
                    
                }
                .padding()
                    .frame(width: 300, height: 300)
                    .aspectRatio(contentMode: .fill)
                    
                    .padding(.horizontal,20)
                    .containerRelativeFrame(.horizontal)
                    .background(Color(red: 0.47, green: 0.835, blue: 0.933))
                    .scrollTransition(.animated, axis: .horizontal) { content, phase in
                        content
                            .opacity(phase.isIdentity ? 1.0 : 0.8)
                            .scaleEffect(phase.isIdentity ? 1 : 0.9)
                        
                    }
                
                   
                
            }.clipShape(MyIcon())
                
            
            
        }.scrollTargetLayout()
    }
}

struct UpcomingMatchesView: View {
    @StateObject var upcomingMatch: viewModel
    @State private var index = 0
    @State var isBookmarked = false
    private let images = ["bookmark", "bookmark.fill"]

    var body: some View {
        
        ForEach($upcomingMatch.upcomingMatch, id: \.date) { $match in
            LazyVStack {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 10) {
                            WebImage(url: URL(string: match.imageUrl1))
                                .resizable()
                                .frame(width: 25, height: 25)
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                            Text(match.team1)
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        
                        HStack(spacing: 10) {
                            WebImage(url: URL(string: match.imageUrl2))
                                .resizable()
                                .frame(width: 25, height: 25)
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                            Text(match.team2)
                                .font(.headline)
                                .foregroundColor(.red)
                        }
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(match.matchTime)
                            .font(.system(size: 12))
                            .bold()
                            .foregroundColor(.black)
                        Text(match.date)
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(match.matchVenue)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                        
                        Button{
                            Task{
                                if match.bookmarked {
                                    
                                    await upcomingMatch.unbookmarkMatch(match: match)
                                    
                                    
                                } else {
                                    
                                    await upcomingMatch.bookmarkMatch(match: match)
                                    upcomingMatch.scheduleNotification(for: match)
                                    
                                }
                               
                            }
                        }label: {
                            Image(systemName: match.bookmarked ? images[1] : images[0])
                        }.padding(.top, 25)
                    }
                }
            }
            .padding()
            
            .frame(width: 320, height: 170, alignment: .center)
            .background(Color.white)
            .preferredColorScheme(.light)
            .clipShape(.buttonBorder)
            .shadow(radius: 2)
        }

    }
}


