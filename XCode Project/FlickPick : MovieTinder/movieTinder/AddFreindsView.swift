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
                        .font(.system(size: 25, weight: .medium, design: .default))
                        .foregroundColor(.pink)
                        .padding(.horizontal, 15)
                    
                    Spacer()
                
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
                                
                                   
                                HStack{
                                    let profilePicUrl = URL(string: user.profilePicture)
                                    
                                    if #available(iOS 15.0, *) {
                                        AsyncImage(url: profilePicUrl) { phase in
                                            if let image = phase.image {
                                                image
                                                    .resizable()
                                                    .frame(width: 45, height: 45)
                                                    .scaledToFit()
                                                    .cornerRadius(150)
                                            } else {
                                                Rectangle()
                                                    .fill(Color("lightgray"))
                                                    .frame(width: 45, height: 45)
                                                    .scaledToFit()
                                                    .cornerRadius(150)
                                                
                                                }
                                            }
                                        }
                                    
                                    Text(user.userName)
                                        .foregroundColor(.pink)
                                        .textCase(.lowercase)
                                        .padding(.horizontal, 5)
                                } //HStack
                             
                            }) //Button (username)
                        } //HStack
                        
                    } //VSTACK
                } // List
                .listStyle(InsetGroupedListStyle())
                
                
                
                Spacer()
                
                
                    .sheet(item: $showingSheet) { item in
                        switch item {
                        case .own:
                            SelfSheetView(userName: passingUserName)
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

