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

//Used for switch case for sheets 
enum ActiveSheet: Identifiable {
    case own, user, friend
    
    var id: Int {
        hashValue
    }
}

struct addFriendsView: View {
    
    @State private var searchText = ""
    
    
    
    @ObservedObject private var viewModel = UserViewModel()
    @State var showingSheet: ActiveSheet?

    
    @State private var passingUserName = ""
    //@State private var passingProfilePicture = "default"
    @State private var passingMoviesLiked = [""]
    

    
    var body: some View {
        


        ZStack {
            
            VStack {
                
                HStack {
                    
                    Text("Find Friends")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        
                    
                    
                
                } //HStack
                .padding(.top, 50)
                
                
                SearchBar(text: $searchText)
                    .padding(.top, 20)
                
                
                
                List(viewModel.users.filter({ searchText.isEmpty ? true : $0.userName.contains(searchText) })) { user in
                    
                    VStack(alignment: .leading) {
                        HStack{
                                                        
                            Button(action: {
                                
                                //Crappy way to solve a crappy problem
                                let listHandler = UserFunctions.checkFriendListContains(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid)!), userName: user.userName)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                    passingUserName = user.userName
                                    passingMoviesLiked = user.moviesLiked
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now()){

                                    if(user.uid == (Auth.auth().currentUser?.uid)!){
                                        showingSheet = .own
                                        
                                    }else if(UserFunctions.checkFriendListContains(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid)!), userName: user.userName)){
                                        showingSheet = .friend

                                    }else{
                                        showingSheet = .user

                                    }
                                }
                            
                               
                            }, label: {
                                Text(user.userName)
                                    .foregroundColor(.pink)
                            })
                        }
                        
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
                
                
                Spacer()
                
                
                    .sheet(item: $showingSheet) { item in
                        switch item {
                        case .own:
                            SelfSheetView(userName: passingUserName, moviesLiked: passingMoviesLiked)
                        case .friend:
                            FriendSheetViewAdd(userName: passingUserName, moviesLiked: passingMoviesLiked)
                        case .user:
                            UserSheetView(userName: passingUserName, moviesLiked: passingMoviesLiked)

                        }

                    }
                
                
            } //VStack
    
        }   //ZStack
        
        .onAppear(){
            self.viewModel.fetchData()
        }
        .background(Image("whitePinkGradient"))

        
    }

}

