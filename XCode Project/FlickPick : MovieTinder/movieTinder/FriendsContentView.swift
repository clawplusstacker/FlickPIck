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
    
    @State var friendsList = UserFunctions.getFreindsList(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ??
    ""))

    @State var passingProfilePicture = ""
    @State var passingUserName  = ""
    @State var passingMatchList = [String]()
    
    @State var showingSheet = false

 
    var body: some View {
    
        

        ZStack {
            
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
                                    Text(friends)
                                })
                            }
                        }

                    }
                    .listStyle(InsetGroupedListStyle())
                
                
                Spacer()
                
                    
                    .sheet(isPresented: $showingSheet){
                        FriendSheetView(profilePicture: $passingProfilePicture, userName: $passingUserName, matchList: $passingMatchList)
                    }
                    
                    
  
            } //VStack
            

        } //ZStack
    
        .onAppear(){
            UserViewModel().fetchData()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                friendsList = UserFunctions.getFreindsList(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))
                
            }
        }
        .background(Image("whitePinkGradient"))


    } // View
    

}




//
//struct Friends: PreviewProvider  {
//
//
//    static var previews: some View {
//
//        FriendsContentView()
//        //DislikedView(likedSelected: .constant(true), dislikedSelected: .constant(false))
//
//    }
//}
