//
//  AddFreindsView.swift
//  movieTinder
//
//  Created by Colby Beach on 3/27/21.
//

import Foundation
import SwiftUI
import RealmSwift



struct addFriendsView: View {
        

    //private var users = try! Realm().objects(User.self)

    @State private var searchText = ""
    @State private var userList: Results<User> = try! Realm(configuration: Realm.Configuration(schemaVersion: 1)).objects(User.self)
    @State private var addedOrRemoved = false;
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

                
                    Text("Find or Remove Friends")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        
                    
                    
                
                }
                .padding()
                
                
                SearchBar(text: $searchText)
                    .padding(.top, 10)
               
                
                List(userList, id: \.userName) { i in
                    
                    HStack{

                        Text(String((i.userName)))
                        
                        if(addedOrRemoved){
                           //This is only here to refresh the view to update the button pictures
                        }
                        
                        if(CurrentUser.currentUser.equals(user1 : i)){
                            
                            Text("(You)")
                         
                        }else if(CurrentUser.currentUser.friendListContains(user1: i)){

                            Button(action: {
                                
                                if var index = CurrentUser.currentUser.friendList.index(of: i){
                                    
                                    let realm = try! Realm();
                                    
                                    try! realm.write{
                                        CurrentUser.currentUser.friendList.remove(at: index);
                                    }
                                    
                                    
                                }
                                
                               
                                addedOrRemoved = false;
                                addedOrRemoved = true;
                                
                            
                            }){
                                Image(systemName: "minus.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.red)
                            }
                        }else {

                            Button(action: {
                                
                                let realm = try! Realm();
                                
                                try! realm.write{
                                    CurrentUser.currentUser.friendList.append(i);
                                }
                                
                                addedOrRemoved = false;
                                addedOrRemoved = true;

                            }){
                                Image(systemName: "plus.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.blue)
                            }
                        }
                    
                        
                    
                      
                        }//HS Stack
                    }//List
                    //.frame(width: 400, height: 400)
            
                
            }
    
        }
    }

}

