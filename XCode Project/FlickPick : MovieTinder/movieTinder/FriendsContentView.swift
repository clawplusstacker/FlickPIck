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

private var UserFunctions = UserStoreFunctions()
private var db = Firestore.firestore()
private var currentUserUID = Auth.auth().currentUser?.uid

struct FriendsView: View {
        


    @State private var searchText = ""
    @Binding var friendsViewSelected : Bool;
    @Binding var matchViewSelected : Bool
    @Binding var addFriendsSelected : Bool;
    
    
    @State var friendsList = ["Loading Data..."]
 
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
                
                } //HStack
                .padding()
                
                
                SearchBar(text: $searchText)
                    .padding(.top, 10)

               
                    List(friendsList, id: \.self) { friends in
                        VStack(alignment: .leading){
                            Text(friends)
                        }

                    }
                
                
                Spacer()
            

               
  
            } //VStack
            

        } //ZStack
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                UserViewModel().fetchData()
                friendsList = UserFunctions.getFreindsList(index: UserFunctions.getFireStoreUserIndex(uid: currentUserUID!))
                
            }
        }

    } // View
    

} //Struct
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
