//
//  SignInView.swift
//  CricLIV
//
//  Created by Adarsh Singh on 19/06/24.
//

import SwiftUI
import GoogleSignIn
import Firebase

struct SignInView: View {
    @Binding var isSignedIn: Bool
    @State var email: String = ""
    @State var pass: String = ""
    @Binding var username: String
    @State var showSuccessMessage: Bool = false
    @State private var showErrorMessage: Bool = false
   
    @StateObject private var signinModel = UserViewModel()
    @StateObject private var matchModel = viewModel()
    var body: some View {
        NavigationStack {
            VStack {
                Text("CricLIV")
                    .font(.system(size: 40))
                    .fontDesign(.rounded)
                    .fontWeight(.heavy)
                    .padding(.bottom, 50)
                    .foregroundStyle(.cyan.gradient.shadow(.inner(radius: 2)).shadow(.drop(radius: 5)))
                
                VStack {
                    if showErrorMessage {
                        HStack {
                            Image(systemName: "multiply.circle.fill")
                                .imageScale(.large)
                                .foregroundStyle(.red)
                                .symbolEffect(.pulse)
                            Text("Wrong credentials!")
                                .foregroundStyle(.red)
                        }
                    }
                    TextField("Email", text: $email)
                        .padding()
                        .background(.ultraThickMaterial)
                        .clipShape(.rect(cornerRadius: 20))
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $pass)
                        .padding()
                        .background(.ultraThickMaterial)
                        .clipShape(.rect(cornerRadius: 20))
                }
                .padding()
                
                Button {
                    Task {
                        await signinModel.signInUser(user: SignIn(email: email, password: pass))
                        if let token = signinModel.signin?.jwtToken {
                            print("Token retrieved: \(token)")
                            UserDefaults.standard.set(token, forKey: "token")
                            UserDefaults.standard.set(email, forKey: "email")
                            UserDefaults.standard.set(signinModel.signin?.username, forKey: "username")
                            isSignedIn = true
                            showErrorMessage = false
                            await matchModel.fetchLiveMatch()
                            await matchModel.fetchUpcomingMatches()
                            await matchModel.fetchPointsTable()
                            await matchModel.fetchBookmarkedMatches()
                        } else {
                            print("Failed to retrieve token")
                            showErrorMessage = true
                        }
                    }
                } label: {
                    ZStack {
                        VStack {
                            Text("Sign In")
                                .foregroundStyle(.white)
                        }
                    }
                    .frame(width: 250, height: 40)
                    .background(isFormValid() ? Color.blue : Color.gray)
                    .clipShape(.rect(cornerRadius: 10))
                    .bold()
                }
                .navigationDestination(isPresented: $isSignedIn) {
                    MainTabbedView(isSignedIn: $isSignedIn, username: $username, email: $email)
                   
                }
                .navigationBarBackButtonHidden(true)
                .disabled(!isFormValid())

                HStack(spacing: 3) {
                    Text("New User?")
                        .foregroundStyle(.gray)
                    
                    NavigationLink("Sign Up") {
                        SignupView(isSigninedIn: $isSignedIn)
                    }
                }
                .font(.footnote)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }

    private func isFormValid() -> Bool {
        return !email.isEmpty && !pass.isEmpty
    }
}

//extension SignInView{
//    func signIn(){
//        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//
//        // Create Google Sign In configuration object.
//        let config = GIDConfiguration(clientID: clientID)
//        GIDSignIn.sharedInstance.configuration = config
//
//        // Start the sign in flow!
//        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
//          guard error == nil else {
//            
//              return
//          }
//
//          guard let user = result?.user,
//            let idToken = user.idToken?.tokenString
//          else {
//            return
//          }
//
//          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
//                                                         accessToken: user.accessToken.tokenString)
//
//          
//         Auth.auth().signIn(with: credential) { result, error in
//             
//             if let error = error {
//                 print("Firebase sign in error: \(error.localizedDescription)")
//                 return
//             }
//             isSignedIn = true
//             print("User is signed in with Firebase")
//             
//             
//          }
//                
//        }
//    }
//    
//    func getRootViewController() -> UIViewController {
//        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return UIViewController() }
//        guard let rootViewController = screen.windows.first?.rootViewController else { return UIViewController() }
//        return rootViewController
//    }
//}

struct SignInView_Previews: PreviewProvider {
    @State static var isSignedIn = false

    static var previews: some View {
        NavigationStack{
            SignInView(isSignedIn: $isSignedIn, username: .constant("username"))
        }
    }
}
