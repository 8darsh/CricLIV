//
//  ProfileView.swift
//  CricLIV
//
//  Created by Adarsh Singh on 18/06/24.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    @Binding var isSignedIn:Bool
    @Binding var username: String
    @Binding var email: String
    @State var photourl: String?
   
    @Environment(\.dismiss) private var dismiss
    @State private var isPresented:Bool = false
    var body: some View {
        NavigationStack{
            Text("Profile")
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding()
                .font(.system(size: 30))
                .bold()
            VStack{
                
                if let photoURL = photourl{
                    AsyncImage(url: URL(string: photoURL)){
                        image in
                        
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white,lineWidth: 4))
                            .shadow(radius: 10)
                        
                    }placeholder: {
                        ProgressView()
                    }
                }else{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                }
                

                Text(UserDefaults.standard.string(forKey: "username")!)
                    .font(.headline)
                    
                    .padding()
                
                Text(UserDefaults.standard.string(forKey: "email")!)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .padding(.top,5)
                
                
            }.padding()
                
            
            List{
                Section{
                    Button{
                        
                    }label: {
                        HStack{
                            Image(systemName: "person.fill")
                                .imageScale(.large)
                                .foregroundStyle(.blue)
                            Text("User Profile")
                           .bold()
                           .foregroundStyle(.blue)
                        }
                    }
                    NavigationLink{
                       MyWishlistView()
                    }label: {
                        HStack{
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.pink)
                                .imageScale(.large)
                            Text("My Wishlist")
                                .tint(.pink)
                                .bold()
                        }
                    }
                }
                Section{
                    Button{
//                        signOut()
                    }label: {
                        HStack{
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .scaleEffect(x: -1, y:1)
                                .imageScale(.large)
                            
                            Text("Logout")
                                .bold()
                        }
                    }
                }
            }.scrollContentBackground(.hidden)
        }
    }
}

extension ProfileView{
//    func signOut(){
//        let firebaseAuth = Auth.auth()
//        do {
//            
//          try firebaseAuth.signOut()
//            isSignedIn = false
//            path = NavigationPath()
//        } catch let signOutError as NSError {
//          print("Error signing out: %@", signOutError)
//        }
//        
//        
//       dismiss()
//    }
}

struct ProfileView_Previews: PreviewProvider {
    @State static var isSignedIn = false
    @State static var path = NavigationPath()
    static var previews: some View {
        NavigationStack{
            ProfileView(isSignedIn: $isSignedIn, username: .constant("Adarsh"), email: .constant("adarsingh2002@gmail.com"))
        }
    }
}
