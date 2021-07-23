//
//  MatchesView.swift
//  movieTinder
//
//  Created by Colby Beach on 3/29/21.
//

import Foundation
import SwiftUI
import RealmSwift


//
//  AddFreindsView.swift
//  movieTinder
//
//  Created by Colby Beach on 3/27/21.
//

import Foundation
import SwiftUI
import RealmSwift

struct FriendsContentView: View {
    
    @State var friendsViewSelected = true
    @State var matchViewSelected = false
    @State var addFriendsSelected = false


    var body: some View {
        
        return Group{
            
            if(friendsViewSelected){
                FriendsView(friendsViewSelected: $friendsViewSelected, matchViewSelected: $matchViewSelected, addFriendsSelected: $addFriendsSelected);
            }else if(matchViewSelected){
                //addFriendsView(backButton: $friendsViewSelected)
                matchView(backButton: $friendsViewSelected);
            }else if(addFriendsSelected){
                addFriendsView(backButton: $friendsViewSelected);
            }
        
        }
    }
}

struct FriendsView: View {
        

    //private var users = try! Realm().objects(User.self)

    @State private var searchText = ""
    @State private var userList = CurrentUser.currentUser.friendList;
    @Binding var friendsViewSelected : Bool;
    @Binding var matchViewSelected : Bool;
    @Binding var addFriendsSelected : Bool;


    
    var body: some View {
        


        ZStack {
            
            VStack {
                
                HStack {
                    Text("Friends")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        
                    Spacer()
                    
                    Button(action: {
                        
                        addFriendsSelected = true;
                        matchViewSelected = false;
                        friendsViewSelected = false;
                                          
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.purple)
                        }
                
                }
                .padding()
                
                
                SearchBar(text: $searchText)
                    .padding(.top, 10)
               
                
                List(userList, id: \.userName) { i in
                    
                    HStack{
                        
                        Button{
                            
                            matchViewSelected = true;
                            CurrentUser.matchUserSelected = i;
                            addFriendsSelected = false;
                            friendsViewSelected = false;
                            
                        }label: {
                            Text(String((i.userName)))
                        }


                      
                        }//HS Stack
                    }//List
                    //.frame(width: 400, height: 400)
            
                
            }
    
        }
    }

}

