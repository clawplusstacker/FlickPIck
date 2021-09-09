//
//  MatchView.swift
//  movieTinder
//
//  Created by Colby Beach on 3/29/21.
//

import Foundation
import SwiftUI



struct matchView: View {
        
    //private var users = try! Realm().objects(User.self)

    @State private var addedOrRemoved = false;
    @State private var showingSheet = false
    @Binding var backButton : Bool;

    //@State private var userList = try! Realm().objects(User.self)

    
    var body: some View {

        ZStack {
            
            VStack {
                
                HStack {
                    
                    Button(action: {
                        
                        backButton = true;
                        
                                          
                    }) {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.purple)
                        }
                    
                    Spacer()

                
                    Text("Matches")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        
                    
                    
                
                }
                .padding()
                
                Button("Shuffle!"){
                    
                    
                 
                    
                }
                .sheet(isPresented: $showingSheet) {
                    //Movie Preview View Pops Up
                       }
                
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(15.0)
                
                    
                
                                    
            }
    
        }
    }
}

