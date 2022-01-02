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

struct FriendsView: View {
        

    @State private var searchText = ""
    @State var showingAddSheet = false
    @State var friendsList = UserFunctions.getFreindsList(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))

    @State var passingProfilePicture = ""
    @State var passingUserName  = ""
    @State var passingMatchList = [String]()
    
    @State var showingSheet = false

 
    var body: some View {
    
        

            
        VStack {
            
            HStack {
                Text("Friends")
                    .font(.system(size: 40, weight: .black, design: .rounded))
                    
                Spacer()
                
                Button(action: {
                    
                    showingAddSheet = true
                    
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.pink)
                    }
                .sheet(isPresented: $showingAddSheet){
                    addFriendsView()
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
                                    
                                    
                                    showingSheet = true
                                    
                                    
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
                                    
                                    Text(friends)
                                        .padding(.horizontal, 5)

                                }
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
            
                
            .sheet(isPresented: $showingSheet){
                FriendSheetView(profilePicture: $passingProfilePicture, userName: $passingUserName, matchList: $passingMatchList)
            }
                
                

        } //VStack
            
        .navigationBarHidden(true)
       
        .onAppear(){
            UserViewModel().fetchData()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                friendsList = UserFunctions.getFreindsList(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))
            }
        } //Onappear

        
    } // Var Body
} //View

