//
//  UserViewModel.swift
//  CricLIV
//
//  Created by Adarsh Singh on 20/06/24.
//

import SwiftUI
import FirebaseAuth

class UserViewModel: ObservableObject{
    
    @Published var displayName: String = ""
    @Published var email: String = ""
    @Published var photoURL: URL? = nil
    @Published var signin: SignIn?
    init(){
        fetchUserProfile()
    }
    func signInUser(user: SignIn) async {
        
       
            do {
                let url = URL(string: "https://crickliv-deploy-2.onrender.com/auth/login")!
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")

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

                let decodedData = try JSONDecoder().decode(SignIn.self, from: data)
                
                await MainActor.run {
                    self.signin = decodedData
                    UserDefaults.standard.set(decodedData.jwtToken, forKey: "token")
                    
                }
                

                // Print the decoded data for debugging
                print("Decoded Data: \(decodedData)")
               
            } catch {
                print("Error: \(error)")
            }
        
        }
    
    
    func fetchUserProfile(){
//        if let user = Auth.auth().currentUser{
//            self.displayName = user.displayName ?? "No Name"
//            self.email = user.email ?? "No Email"
//            self.photoURL = user.photoURL
//            
//        }
    }

}
