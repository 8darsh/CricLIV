//
//  SignupView.swift
//  CricLIV
//
//  Created by Adarsh Singh on 04/07/24.
//

import SwiftUI

struct SignupView: View {
    @State private var username:String = ""
    @State private var email:String = ""
    @State private var password:String = ""
    @Binding var isSigninedIn: Bool
    @State var isPresented: Bool = false
    @State private var showSuccessMessage: Bool = false
    
    @StateObject private var signupModel = viewModel()
    var body: some View {
        NavigationStack{
            VStack {
                if showSuccessMessage{
                    HStack{
                        Image(systemName: "checkmark.seal.fill")
                            .renderingMode(.original)
                            .symbolEffect(.appear)
                        Text("Sucessfully Signed up")
                            .foregroundStyle(.blue)
                    }
                }
                Text("CricLIV")
                    .font(.system(size: 40))
                    .fontDesign(.rounded)
                    .fontWeight(.heavy)
                    .padding(.bottom, 50)
                    .foregroundStyle(.cyan.gradient.shadow(.inner(radius: 2)).shadow(.drop(radius: 5)))
                
                VStack {
                    TextField("Username", text: $username)
                        .padding()
                        .background(.ultraThickMaterial)
                        .clipShape(.rect(cornerRadius: 20))
                        .autocapitalization(.none)
                    TextField("Email", text: $email)
                        .padding()
                        .background(.ultraThickMaterial)
                        .clipShape(.rect(cornerRadius: 20))
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(.ultraThickMaterial)
                        .clipShape(.rect(cornerRadius: 20))
                        
                }
                .padding()
                
                
                NavigationLink(destination: SignInView(isSignedIn: $isSigninedIn, username: $username)) {
                    ZStack {
                        VStack {
                            Text("Sign Up")
                                .foregroundStyle(.white)
                        }
                    }
                    .frame(width: 250, height: 40)
                    .background(isFormValid() ? Color.blue : Color.gray)
                    .clipShape(.rect(cornerRadius: 10))
                    .bold()
                }
                .disabled(!isFormValid())
                
                .simultaneousGesture(TapGesture().onEnded {
                    Task{
                        await signupUser()
                    }
                    if isFormValid() {
                        showSuccessMessage = true
                    }
                })


                
                HStack(spacing: 3) {
                    Text("Already a user?")
                        .foregroundStyle(.gray)
                    
                    NavigationLink("Sign In") {
                        SignInView(isSignedIn: $isSigninedIn, username: $username)
                    }
                }
                .font(.footnote)
            }
            
        }
        
            .padding()
    }
    private func isFormValid() -> Bool {
        return !username.isEmpty && !email.isEmpty && !password.isEmpty
    }
    private func signupUser() async {
        let user = SignUp(userName: username, email: email, password: password)
        do {
            try await signupModel.signupUser(user: user)
            await MainActor.run {
                showSuccessMessage = true
            }
        } catch {
            print("Sign-up failed: \(error)")
        }
    }
}
    



