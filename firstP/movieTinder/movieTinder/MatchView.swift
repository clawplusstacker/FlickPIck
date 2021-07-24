//
//  MatchView.swift
//  movieTinder
//
//  Created by Colby Beach on 3/29/21.
//

import Foundation
import SwiftUI
import RealmSwift



struct matchView: View {
        
    //private var users = try! Realm().objects(User.self)

    @State private var movieList: Results<Movie> = try! Realm(configuration: Realm.Configuration(schemaVersion: 1)).objects(Movie.self)
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
                    
                    if(CurrentUser.currentUser.matchList(user1: CurrentUser.matchUserSelected).randomElement() == nil){
                        
                    }else{
                        CurrentUser.matchMovieSelected = CurrentUser.currentUser.matchList(user1: CurrentUser.matchUserSelected).randomElement()!;  //Exclamation point unwraps the value
                        showingSheet.toggle()
                    }
                    
                 
                    
                }
                .sheet(isPresented: $showingSheet) {
                           MoviePreview()
                       }
                
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(15.0)
                
                    
                
                
                
                List(CurrentUser.currentUser.matchList(user1: CurrentUser.matchUserSelected), id: \.Title) { i in
    
                    Button(action: {
                        CurrentUser.matchMovieSelected = i;
                        showingSheet.toggle()
                        
                    }, label: {
                        Text(String((i.Title)))
                    })
                    
                    .sheet(isPresented: $showingSheet) {
                               MoviePreview()
                           }
                    
                }//List
                                    
            }
    
        }
    }
}

