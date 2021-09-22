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



struct FriendsContentView: View {
    
    @State var friendsViewSelected = true
    @State var profileViewSelected = false
    @State var addFriendsSelected = false
    

    
    

    var body: some View {
        
        return Group{
            
            if(friendsViewSelected){
                
                FriendsView(friendsViewSelected: $friendsViewSelected, profileViewSelected: $profileViewSelected, addFriendsSelected: $addFriendsSelected)
                
            }else if(profileViewSelected){
//                FriendSheetView(backButton: $friendsViewSelected, userName: passingUserName, matchList: passingMatchList)

            }else if(addFriendsSelected){
                addFriendsView(backButton: $friendsViewSelected, friendsViewSelected: $friendsViewSelected, profileViewSelected: $profileViewSelected, addFriendsSelected: $addFriendsSelected)
            }
        
        }
    }
}

private var UserFunctions = UserStoreFunctions()
private var db = Firestore.firestore()
private var currentUserUID = Auth.auth().currentUser?.uid

struct FriendsView: View {
        


    @State private var searchText = ""
    @Binding var friendsViewSelected : Bool;
    @Binding var profileViewSelected : Bool
    @Binding var addFriendsSelected : Bool;
    
    
    @State var friendsList = ["Loading Data..."]

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
                        
                        addFriendsSelected = true;
                        profileViewSelected = false;
                        friendsViewSelected = false;
                                          
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.purple)
                        }
                
                } //HStack
                .padding()
                
                
                SearchBar(text: $searchText)
                    .padding(.top, 10)

               
                    List(friendsList, id: \.self) { friends in
                        VStack(alignment: .leading){
                            HStack{
                                                            
                                Button(action: {
                              
                                    
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                        
                                        
                                        passingUserName = friends
                                        passingMatchList = UserFunctions.getMatches(indexOfSelf: UserFunctions.getFireStoreUserIndex(uid: currentUserUID!), userNameOfOther: friends)
                                        

                                        showingSheet = true
                                        

                                    }

                                   
                                   
                                }, label: {
                                    Text(friends)
                                })
                            }
                                                    }

                    }
                
                
                Spacer()
                
                    
                    .sheet(isPresented: $showingSheet){
                        FriendSheetView(profilePicture: $passingProfilePicture, userName: $passingUserName, matchList: $passingMatchList)
                    }
                    
                    
  
            } //VStack
            

        } //ZStack
    
        .onAppear(){
            UserViewModel().fetchData()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                friendsList = UserFunctions.getFreindsList(index: UserFunctions.getFireStoreUserIndex(uid: currentUserUID!))
                
            }
        }

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
