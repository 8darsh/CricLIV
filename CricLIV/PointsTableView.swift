//
//  PointsTableView.swift
//  CricLIV
//
//  Created by Adarsh Singh on 18/06/24.
//

import SwiftUI

struct PointsTableView: View {
    
    @StateObject private var pointTableModel = viewModel()
    var body: some View {
        
        NavigationStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color(red: 45/255, green: 43/255, blue: 58/255), Color(red: 34/255, green: 33/255, blue: 48/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea(.all)
                ScrollView(.vertical){
                    VStack(alignment: .leading) {
                        // Header Row
                        HStack(spacing: 2){
                            Text("Team")
                                .frame(width: 55, alignment: .leading)
                            
                            Text("Matches")
                                .frame(width: 60, alignment: .center)
                            
                            Text("Wins")
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            Text("Loss")
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            Text("Tied")
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            Text("NR")
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            Text("NRR")
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            Text("Points")
                                .frame(width: 40, alignment: .trailing)
                            
                            
                        }
                        .font(.system(size: 12))
                        .bold()
                        .padding()
                        .foregroundStyle(Color.black)
                        .background(Color.white)
                        .clipShape(.buttonBorder)
                        
                        // Data Rows
                        ForEach(pointTableModel.pointsTable) { teamPoints in
                            HStack(){
                                Text(teamPoints.team)
                                    .frame(width: 58, alignment: .leading)
                                    .bold()
                                Text("\(teamPoints.matchesPlayed)")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text("\(teamPoints.wins)")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text("\(teamPoints.losses)")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text("\(teamPoints.tied)")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text("\(teamPoints.noResult)")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text("\(teamPoints.netRunRate)")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text("\(teamPoints.points)")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                
                            }
                            .font(.system(size: 9))
                            .padding()
                            .foregroundStyle(Color.black)
                            .background(Color.cyan)
                            .clipShape(.buttonBorder)
                            
                            
                        }
                        
                        
                    }.padding()
                    
                    
                }
            }.onAppear{
                Task{
                    await pointTableModel.fetchPointsTable()
                }
            }
            
            
        }

    }
}

#Preview {
    
   
    
    PointsTableView()
}
