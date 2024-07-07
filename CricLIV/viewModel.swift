//
//  viewModel.swift
//  CricLIV
//
//  Created by Adarsh Singh on 03/07/24.
//

import Foundation
import Combine
import SwiftUI
import UserNotifications
final class viewModel: ObservableObject{
    
    @Published var livematch: [LiveMatch] = []
    @Published var upcomingMatch: [UpcomingMatch] = []
    @Published var pointsTable:[PointsTable] = []
    @Published var bookmarkedMatches: [UpcomingMatch] = []
    @Published var signup: SignUp?
//    @Published var signin: SignIn?
    @Published var token: String = (UserDefaults.standard.string(forKey: "token") ?? "abc")
    
    

    
    func fetchLiveMatch() async{
        
        print("refr: \(token)")
        do{
            let url = URL(string: "https://crickliv-deploy-2.onrender.com/match/live")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let (data,_) = try await URLSession.shared.data(for: request)
            
            let decodedData = try JSONDecoder().decode([LiveMatch].self, from: data)
            print(decodedData)
            await MainActor.run {
                self.livematch = decodedData
            }
        }catch{
            
            print("Error: \(error)")
        }
    }
    
    func fetchUpcomingMatches() async{
        do{
            let url = URL(string: "https://crickliv-deploy-2.onrender.com/match/featured-match")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
            
            let (data,_) = try await URLSession.shared.data(for: request)
            
            let decodedData = try JSONDecoder().decode([UpcomingMatch].self, from: data)
//            print(decodedData)
            await MainActor.run {
                self.upcomingMatch = decodedData
            }
//            print(upcomingMatch)
        }catch{
            
            print("Error: \(error)")
        }
    }
    
    
    func fetchPointsTable() async{
        
        do {
            let url = URL(string: "https://crickliv-deploy-2.onrender.com/match/point-table")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String]] {
                print("JSON Array: \(jsonArray)")
                
                let pointsTable = jsonArray.dropFirst().map { array -> PointsTable in
                    return PointsTable(
                        team: array[0],
                        matchesPlayed: array[1],
                        wins: array[2],
                        losses: array[3],
                        tied: array[4],
                        noResult: array[5],
                        points: array[6],
                        netRunRate: array[7]
                    )
                }
                
                print("Points Table: \(pointsTable)")
                
                await MainActor.run {
                    self.pointsTable = pointsTable
                }
            } else {
                print("Failed to cast JSON")
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func bookmarkMatch(match: UpcomingMatch) async{
        
        
        do {
            let url = URL(string: "https://crickliv-deploy-2.onrender.com/match/bookmark")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
            
           
            
            let encodeData = try JSONEncoder().encode(match)
            request.httpBody = encodeData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Print the response data as a string
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response String: \(responseString)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                print("Failed with status code: \(httpResponse.statusCode)")
                return
            }
            
            // Decode the response as an array of UpcomingMatch
            let decodedData = try JSONDecoder().decode([UpcomingMatch].self, from: data)
            print(decodedData)
            
            // Update the bookmarked status locally
            if let index = upcomingMatch.firstIndex(where: { $0.date == match.date }) {
                DispatchQueue.main.async {
                    self.upcomingMatch[index].bookmarked = true
                }
            }
        } catch {
            print("Error: \(error)")
        }
        
    }
    
    func unbookmarkMatch(match: UpcomingMatch) async{
        

        
        do {
            let url = URL(string: "https://crickliv-deploy-2.onrender.com/match/deleteBookmarkById")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
            
           
            
            let encodeData = try JSONEncoder().encode(match)
            request.httpBody = encodeData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Print the response data as a string
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response String: \(responseString)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                print("Failed with status code: \(httpResponse.statusCode)")
                return
            }
            
            // Decode the response as an array of UpcomingMatch
            let decodedData = try JSONDecoder().decode([UpcomingMatch].self, from: data)
            print(decodedData)
            
             
            if let index = upcomingMatch.firstIndex(where: { $0.date == match.date && $0.seriesName == match.seriesName }) {
                DispatchQueue.main.async {
                    self.upcomingMatch[index].bookmarked = false
                }
            }
        } catch {
            print("Error: \(error)")
        }

        
    }
    
    func fetchBookmarkedMatches() async{
        do{
            let url = URL(string: "https://crickliv-deploy-2.onrender.com/match/get-bookmark")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
            
            let (data,_) = try await URLSession.shared.data(for: request)
            
            let decodedData = try JSONDecoder().decode([UpcomingMatch].self, from: data)
//            print(decodedData)
            await MainActor.run {
                self.upcomingMatch = decodedData
            }
//            print(upcomingMatch)
        }catch{
            
            print("Error: \(error)")
        }
    }
    
    func clearAllBookmark() async{
        do{
            let url = URL(string: "https://crickliv-deploy-2.onrender.com/match/clear-bookmarks")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let (_,_) = try await URLSession.shared.data(for: request)
        }catch{
            print("Error: \(error)")
        }
    }
    
    
    func signupUser(user: SignUp) async {
        do {
            let url = URL(string: "https://crickliv-deploy-2.onrender.com/auth/sign-up")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZGl0eWFyYXkuMDAyQGdtYWlsLmNvbSIsImlhdCI6MTcyMDEwMzgyNiwiZXhwIjoxNzM1NjU1ODI2fQ.9yUHQHqVCN4JMPXZpL-6uvJkdhCauOBW5eQ2ejFIy2c4vBSzq29wYVPmLdm8fpWdtEuN4F_eSGBMiPt15M2dvg", forHTTPHeaderField: "Authorization")

            let encodeData = try JSONEncoder().encode(user)
            request.httpBody = encodeData

            // Debugging prints
            print("Request URL: \(url)")
            print("Request Headers: \(request.allHTTPHeaderFields ?? [:])")
            print("Request Body: \(String(data: encodeData, encoding: .utf8) ?? "")")

            let (data, response) = try await URLSession.shared.data(for: request)

            if let httpResponse = response as? HTTPURLResponse {
                guard (200...299).contains(httpResponse.statusCode) else {
                    print("HTTP Error: \(httpResponse.statusCode)")
                    if let responseData = String(data: data, encoding: .utf8) {
                        print("Response data: \(responseData)")
                    }
                    throw URLError(.badServerResponse)
                }
            }

            let decodedData = try JSONDecoder().decode(SignUp.self, from: data)
            await MainActor.run{
                self.signup = decodedData
                
            }

            // Print the decoded data for debugging
            print("Decoded Data: \(decodedData)")
        } catch {
            print("Error: \(error)")
        }
    }
    
    
    
    
  
    
    
}
extension viewModel{
    
    func scheduleNotification(for match: UpcomingMatch){
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { granted, error in
            if let error{
                print("Error requesting notification permission: \(error.localizedDescription)")
                return
            }
            
            if !granted{
                print("Notification permission not granted")
                return
            }
        }
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "EEE, dd MMM, yy HH:mm"
        dateformatter.timeZone = TimeZone(abbreviation: "IST")
        
        let dateString = "\(match.date) \(match.matchTime)"
        
        guard let matchDate = dateformatter.date(from: dateString) else{
            print("Invalid match date or time format")
            return
        }
        
        let notificationTime = matchDate.addingTimeInterval(-15 * 60)
        
        let content = UNMutableNotificationContent()
        content.title = "Match Reminder"
        content.body = "Your bookmarked match \(match.team1) vs \(match.team2) is about to start!"
        content.sound = .default
        
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: notificationTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: "\(match.featuredMatchId)-notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled for match \(match.team1) vs \(match.team2)")
            }
        }
    }
}
    

