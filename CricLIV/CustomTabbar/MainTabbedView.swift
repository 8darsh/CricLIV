//
//  MainTabbedView.swift
//  CricLIV
//
//  Created by Adarsh Singh on 18/06/24.
//

import SwiftUI

struct MainTabbedView: View {
    @State var selectedTab = 0
    @Binding var isSignedIn: Bool
    @Binding var username: String
    @Binding var email: String
   
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                TabView(selection: $selectedTab) {
                    HomeView()
                        .tag(0)
                    PointsTableView()
                        .tag(1)
                    AllMatchesView()
                        .tag(2)
                    ProfileView(isSignedIn: $isSignedIn, username: $username, email: $email)
                        .tag(3)
                }
                ZStack {
                    HStack {
                        ForEach(TabbedItems.allCases, id: \.self) { item in
                            Button {
                                selectedTab = item.rawValue
                            } label: {
                                customTabbedView(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                            }
                        }
                    }
                    .padding(6)
                }
                .frame(height: 70)
                .background(Color(red: 23/255, green: 24/255, blue: 38/255))
                .cornerRadius(35)
                .padding(.horizontal, 26)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

extension MainTabbedView {
    func customTabbedView(imageName: String, title: String, isActive: Bool) -> some View {
        
        HStack(spacing: 10) {
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(isActive ? .black : .gray)
                .frame(width: 20, height: 20)
            
            if isActive {
                Text(title)
                    .font(.system(size: 14))
                    .foregroundStyle(isActive ? .black : .gray)
                    .bold()
            }
            Spacer()
        }
        .frame(width: isActive ? .infinity : 60, height: 60)
        .background(isActive ? Color(red: 0.47, green: 0.835, blue: 0.933) : .clear)
        .clipShape(Capsule())
    }
    
}

struct MainTabbedView_Previews: PreviewProvider {
    @State static var isSignedIn = false
    @State static var path = NavigationPath()
    static var previews: some View {
        NavigationStack{
            MainTabbedView(isSignedIn: $isSignedIn,username: .constant("username"), email: .constant(""))
        }
    }
}
