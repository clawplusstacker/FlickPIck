//
//  UserSheets.swift
//  movieTinder
//
//  Created by Colby Beach on 9/17/21.
//


import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth


private var UserFunctions = UserStoreFunctions()
private var db = Firestore.firestore()
private var currentUserUID = Auth.auth().currentUser?.uid



struct UserSheetView : View {
    
    @ObservedObject var user = UserViewModel()

    
    var profilePicture = "defaultUser"
    var userName = "defaultUser"
    var moviesLiked = [""]
    
    @State private var buttonText = "Add Friend"
    
    
    var body: some View{
        
        VStack{
            
            let profilePicUrl = URL(string: UserFunctions.getProfilePicture(index: UserFunctions.getFireStoreUserIndex(userName: userName)))
            
            if #available(iOS 15.0, *) {
                AsyncImage(url: profilePicUrl) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .frame(width: 200, height: 200)
                            .scaledToFit()
                            .cornerRadius(150)
                            .padding(.top, 40)
                    } else {
                        Rectangle()
                            .fill(Color("lightgray"))
                            .frame(width: 200, height: 200)
                            .scaledToFit()
                            .cornerRadius(150)
                            .padding(.top, 40)
                        }
                    }
                }

                    
            
            Text(userName)
                .font(.system(size: 40))
                .padding()
            
            Spacer()
             
            Button(action: {
                
                //This is a really bad way to fix a pretty bad bug in my code
                UserFunctions.addUserToFriends(index: 0, userName: "handler")
                //
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    UserFunctions.addUserToFriends(index: UserFunctions.getFireStoreUserIndex(uid: currentUserUID!), userName: userName)
                }
    
                buttonText = "Added!"
                
                
            }, label: {
                Text(buttonText)
            })
                .padding()
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 400, height: 50)
                .background(Color.pink)
                .cornerRadius(15.0)
        }
        .onAppear(){
            self.user.fetchData()
        }
        .background(Image("whitePinkGradient"))

       
        
    }
}

struct FriendSheetView : View {
    
    @ObservedObject private var user = UserViewModel()

    
    
    @Binding var profilePicture : String
    @Binding var userName : String
    @Binding var matchList : Array<String>
    
    @State private var buttonText = "Remove Friend"
    @State private var showingMovieSheet = false
    
    @State var movieTitle = ""
        
    
    
    
    var body: some View{
        
        VStack{
        
            VStack{
                                    
                    HStack{
                        
                        Text(userName)
                            .font(.system(size: 40, weight: .black, design: .rounded))
                            .padding(.top, 40)
                      
                    }//Hstack
                
                Spacer()
                   
                
                let profilePicUrl = URL(string: UserFunctions.getProfilePicture(index: UserFunctions.getFireStoreUserIndex(userName: userName)))
                
                if #available(iOS 15.0, *) {
                    AsyncImage(url: profilePicUrl) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .frame(width: 200, height: 200)
                                .scaledToFit()
                                .cornerRadius(150)
                        } else {
                            Rectangle()
                                .fill(Color("lightgray"))
                                .frame(width: 200, height: 200)
                                .scaledToFit()
                                .cornerRadius(150)
                            }
                        }
                    }

                
                LabelledDivider(label: "")
                

                Text("MATCHES:")
                    .padding()
                    .font(.headline)
                
                
                
                List(matchList, id: \.self) { movies in
                    VStack(alignment: .leading){
                        
                        Button(action: {
                            
                                movieTitle = movies
                                showingMovieSheet.toggle()
                          
                            
                        }, label: {
                            Text(movies)
                                .foregroundColor(.pink)
                        })
                        
                    }
                }

            } //VStack 2
            
            HStack{
                Button(action: {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                        
                        if(matchList.count > 0){
                            movieTitle = matchList[Int.random(in: 0...matchList.count-1)]
                        }

                        
                    }
                    if(matchList.count > 0){
                        showingMovieSheet.toggle()
                    }
                 
                    
                }, label: {
                    Text("Shuffle!")
                })
                .padding()
                .padding()
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 200, height: 50)
                .background(Color.pink)
                .cornerRadius(15.0)
                
                
                Button(action: {
                    
                    buttonText = "Removed!"

                    //This is a really bad way to fix a pretty bad bug in my code
                    UserFunctions.addUserToFriends(index: 0, userName: "handler")
                    //
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){

                        UserFunctions.removeUserFromFriends(index: UserFunctions.getFireStoreUserIndex(uid: currentUserUID!), userName: userName)

                    }
                 
                    
                }, label: {
                    Text(buttonText)
                })
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(15.0)
                
            }//Hstack 2
            .padding(.bottom, 10)
        }//Vstack1
            
                    
            .sheet(isPresented: $showingMovieSheet, content: {
                
                MoviePreviewView(movieTitle: $movieTitle)
                
            })
            
            .onAppear(){
                self.user.fetchData()
            }
        .background(Image("whitePinkGradient"))

                
            
        }
    }

    struct FriendSheetViewAdd : View {
        
        @ObservedObject var user = UserViewModel()

        
        var profilePicture = "defaultUser"
        var userName = "defaultUser"
        var moviesLiked = [""]
        
        @State private var buttonText = "Already Your Friend!"
        
        
        var body: some View{
            
            VStack{
                
                let profilePicUrl = URL(string: UserFunctions.getProfilePicture(index: UserFunctions.getFireStoreUserIndex(userName: userName)))
                
                if #available(iOS 15.0, *) {
                    AsyncImage(url: profilePicUrl) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .frame(width: 200, height: 200)
                                .scaledToFit()
                                .cornerRadius(150)
                                .padding(.top, 40)
                        } else {
                            Rectangle()
                                .fill(Color("lightgray"))
                                .frame(width: 200, height: 200)
                                .scaledToFit()
                                .cornerRadius(150)
                                .padding(.top, 40)

                            }
                        }
                    }

                        
                
                Text(userName)
                    .font(.system(size: 40))
                    .padding()
                
                Spacer()
                 
              
                Text(buttonText)
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 400, height: 50)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }
            .onAppear(){
                self.user.fetchData()
            }
            .background(Image("whitePinkGradient"))

           
        }
        
}

struct SelfSheetView : View {
    
    @ObservedObject var user = UserViewModel()

    var userName = "defaultUser"
    
    
    var body: some View{
        
        VStack{
            
            let profilePicUrl = URL(string: UserFunctions.getProfilePicture(index: UserFunctions.getFireStoreUserIndex(uid: Auth.auth().currentUser?.uid ?? "")))
            
            if #available(iOS 15.0, *) {
                AsyncImage(url: profilePicUrl) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .frame(width: 200, height: 200)
                            .scaledToFit()
                            .cornerRadius(150)
                            .padding(.top, 40)

                    } else {
                        Rectangle()
                            .fill(Color("lightgray"))
                            .frame(width: 200, height: 200)
                            .scaledToFit()
                            .cornerRadius(150)
                            .padding(.top, 40)
                        }
                    }
                }

                    
            
            Text(userName)
                .font(.system(size: 40))
                .padding()
            
            Spacer()
             
            Text("This is your public profile!")
                .padding()
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 400, height: 50)
                .background(Color.purple)
                .cornerRadius(15.0)
        }
        .onAppear(){
            self.user.fetchData()
        }
        .background(Image("whitePinkGradient"))

       
        
    }
}


