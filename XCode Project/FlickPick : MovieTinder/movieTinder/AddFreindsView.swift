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
    @State private var addedOrRemoved = false;
    @Binding var backButton : Bool;
    
    @ObservedObject private var viewModel = UserViewModel()
    @State private var showingUserSheet = false
    
    @State private var passingUserID = ""
    
    
    

    
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
                            Text(user.userName)
                            
                            Spacer()
                            
                            Button(action: {
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){

                                    UserFunctions.addUserToFriends(index: UserFunctions.getFireStoreUserIndex(uid: currentUserUID!), userName: user.userName)

                                }
                               
                            }, label: {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.pink)
                            })
                        }
                        
                    }
                }
                
                
                
                Spacer()
                
                    .sheet(isPresented: $showingUserSheet) {
                        userSheetView(userId: passingUserID)
                    }
               
            
                
            } //VStack
    
        }   //ZStack
        
        .onAppear(){
            self.viewModel.fetchData()
        }
        
        
    }

}

struct userSheetView : View {
    
    var userId = ""
    
    
    
    var body: some View{
        
        Text(userId)
        
    }
}
