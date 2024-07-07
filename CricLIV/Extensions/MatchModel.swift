//
//  MatchModel.swift
//  CricLIV
//
//  Created by Adarsh Singh on 18/06/24.
//

import Foundation
import SwiftUI

struct LiveMatch: Codable,Hashable{

    var matchId: Int
    var matchNumberVenue: String
    var battingTeam: String
    var battingTeamScore: String
    var bowlTeam: String
    var bowlTeamScore: String
    var liveText: String
    
}

struct UpcomingMatch: Codable, Hashable{
    
    var featuredMatchId:Int
    var seriesName: String
    var matchTime: String
    var matchVenue: String
    var imageUrl1: String
    var imageUrl2: String
    var team1: String
    var team2: String
    var date: String
    var bookmarked: Bool
    


    
}

struct PointsTable: Identifiable, Codable {
    var id = UUID()
    var team: String
    var matchesPlayed: String
    var wins: String
    var losses: String
    var tied: String
    var noResult: String
    var points: String
    var netRunRate: String

    enum CodingKeys: String, CodingKey {
        case team
        case matchesPlayed = "matches"
        case wins = "won"
        case losses = "lost"
        case tied
        case noResult = "no_result"
        case points
        case netRunRate = "net_run_rate"
    }
}

//struct BookmarkedMatch: Codable, Hashable{
//    
//   
//    var seriesName: String
//    var matchTime: String
//    var matchVenue: String
//    var imageUrl1: String
//    var imageUrl2: String
//    var team1: String
//    var team2: String
//    var date: String
//
//}

struct SignUp: Codable, Hashable{
    
    var userName: String
    var email: String
    var password: String
}

struct SignIn: Codable, Hashable{
    var email: String?
    var password: String?
    var jwtToken: String?
    var username: String?
}




