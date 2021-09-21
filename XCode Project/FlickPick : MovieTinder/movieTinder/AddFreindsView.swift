//
//  AddFreindsView.swift
//  movieTinder
//
//  Created by Colby Beach on 3/27/21.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth



private var UserFunctions = UserStoreFunctions()
private var db = Firestore.firestore()
private var currentUserUID = Auth.auth().currentUser?.uid


struct addFriendsView: View {
    
    //@State var notFriendsList = ["Loading Data"]


    @State private var searchText = ""
    @State private var addedOrRemoved = false
    @Binding var backButton : Bool
    
    @Binding var friendsViewSelected : Bool;
    @Binding var profileViewSelected : Bool
    @Binding var addFriendsSelected : Bool;
    
    
    @ObservedObject private var viewModel = UserViewModel()
    @State private var showingUserSheet = false
    @State private var showingSelfSheet = false
    @State private var showingFriendSheet = false


    
    @State private var passingUserName = ""
    //@State private var passingProfilePicture = "default"
    @State private var passingMoviesLiked = [""]


    //@State private var passingProfilePicture = "default"
    

    
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

                
                    Text("Find Friends")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        
                    
                    
                
                } //HStack
                .padding()
                
                
                SearchBar(text: $searchText)
                    .padding(.top, 10)
                
                
                List(viewModel.users) { user in
                    
                    VStack(alignment: .leading) {
                        HStack{
                                                        
                            Button(action: {
                                
                                let listHandler = UserFunctions.checkFriendListContains(index: UserFunctions.getFireStoreUserIndex(uid: currentUserUID!), userName: user.userName)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                    passingUserName = user.userName
                                    passingMoviesLiked = user.moviesLiked
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now()){

                                    if(user.uid == currentUserUID){
                                        showingSelfSheet.toggle()
                                        
                                    }else if(UserFunctions.checkFriendListContains(index: UserFunctions.getFireStoreUserIndex(uid: currentUserUID!), userName: user.userName)){
                                        
                                        showingFriendSheet.toggle()
                                    }else{
                    
                                        showingUserSheet.toggle()
                                    }
                                }
                            
                               
                            }, label: {
                                Text(user.userName)
                            })
                        }
                        
                    }
                }
                
                
                
                Spacer()
                
                    .sheet(isPresented: $showingUserSheet) {
                        UserSheetView(userName: passingUserName, moviesLiked: passingMoviesLiked)
                    }
                    .sheet(isPresented: $showingSelfSheet) {
                        SelfSheetView(userName: passingUserName, moviesLiked: passingMoviesLiked)
                    }
                    .sheet(isPresented: $showingFriendSheet) {
                        FriendSheetViewAdd(userName: passingUserName, moviesLiked: passingMoviesLiked)
                    }
                
            
            
                
            } //VStack
    
        }   //ZStack
        
        .onAppear(){
            self.viewModel.fetchData()
        }
        
        
    }

}
