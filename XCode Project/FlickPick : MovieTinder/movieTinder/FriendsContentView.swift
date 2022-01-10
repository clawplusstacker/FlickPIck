//
//  MatchesView.swift
//  movieTinder
//
//  Created by Colby Beach on 3/29/21.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth


private var UserFunctions = UserStoreFunctions()
private var db = Firestore.firestore()
private var currentUserUID = Auth.auth().currentUser?.uid

enum FriendsSheetsSettings: Identifiable  {
    case add, friend
    
    var id: Int{
        hashValue
    }
}

struct FriendsView: View {
        

    @State private var searchText = ""
    @State var friendsList = UserFunctions.getFreindsList(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))

    @State var passingProfilePicture = ""
    @State var passingUserName  = ""
    @State var passingMatchList = [String]()
    
    @State var showingSheet : FriendsSheetsSettings?
    
    @State var removeButtonText = "Remove"

 
    var body: some View {
    
        

            
        VStack {
            
            HStack {
                Text("Friends")
                    .font(.system(size: 25, weight: .medium, design: .default))
                    .foregroundColor(.pink)

                Spacer()
                
                Button(action: {
                    
                    showingSheet = .add
                    
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.pink)
                    }
            
            } //HStack
            .padding()
            
            
            if #available(iOS 15.0, *) {
                List(friendsList, id: \.self) { friends in
                    VStack(alignment: .leading){
                        HStack{
                            
                            Button(action: {
                                
                                
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                    
                                    
                                    passingUserName = friends
                                    passingMatchList = UserFunctions.getMatches(indexOfSelf: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""), userNameOfOther: friends)
                                    
                                    
                                    showingSheet = .friend
                                    
                                    
                                }
                                
                                
                                
                            }, label: {
                                HStack{
                                    let profilePicUrl = URL(string: UserFunctions.getProfilePicture(index: UserFunctions.getFireStoreUserIndex(userName: friends)))
                                    
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
                                    
                                    VStack(alignment: .leading){
                                        
                                        Text(friends)
                                            .textCase(.lowercase)
                                        
                                        Text("Matches: " + String(UserFunctions.getMatches(indexOfSelf: UserFunctions.getFireStoreUserIndex(uid: Auth.auth().currentUser?.uid ?? ""), userNameOfOther: friends).count))
                                            .font(.system(size: 8))
                                        
                                    }//Vstack
                                        .padding(.horizontal, 5)
                                    
                                    
                                    Spacer()
                                    
                                    
                                    Button {
                                        
                                        removeButtonText = "Removed!"
                                        
                                        
                                        //This is a really bad way to fix a pretty bad bug in my code
                                        UserFunctions.addUserToFriends(index: 0, userName: "handler")
                                        //
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){

                                            UserFunctions.removeUserFromFriends(index: UserFunctions.getFireStoreUserIndex(uid: currentUserUID!), userName: friends)

                                        }
                                        
                                    } label: {
                                        Text(removeButtonText)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 5)
                                            .background(
                                               RoundedRectangle(cornerRadius: 10)
                                                .fill(Color.pink)
                                                
                                           )
                                    }

                                    
                                    
                                    
                                    
                                } //HStack
                            })
                        }
                    }
                    
                }
                .refreshable {
                    friendsList = UserFunctions.getFreindsList(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))
                }
                .listStyle(InsetGroupedListStyle())
            }
        
            Spacer()

        } //VStack
            
        .sheet(item: $showingSheet){ item in
            switch item {
            case .add:
                addFriendsView()
            case .friend:
                FriendSheetView(profilePicture: $passingProfilePicture, userName: $passingUserName, matchList: $passingMatchList)
            }
        }
        
        .navigationBarHidden(true)
       
        .onAppear(){
            UserViewModel().fetchData()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                friendsList = UserFunctions.getFreindsList(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))
            }
        } //Onappear

        
    } // Var Body
} //View

