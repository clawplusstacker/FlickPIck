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
            
            Image(profilePicture)
                .padding(.top, 40)
                    
            
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
       
        
    }
}

struct FriendSheetView : View {
    
    @ObservedObject private var user = UserViewModel()
    
    @Binding var backButton : Bool;

    @State var profilePicture = "defaultUser"
    @State var userName = ""
    @State var matchList = [String]()
    
    @State private var buttonText = "Remove Friend"
    @State private var showingMovieSheet = false
    
    @State var movieTitle = ""
    
    
    
    
    var body: some View{
        
        VStack{
        
            VStack{
                                    
                    HStack{
                        
                        Button(action: {
                            
                            backButton = true;
                            
                                              
                        }) {
                            Image(systemName: "chevron.left.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.purple)
                            }
                        
                        Text(userName)
                            .font(.system(size: 40, weight: .black, design: .rounded))
                            .padding()
                      
                    }//Hstack
                
                Spacer()
                   
                
               
                
                Image(profilePicture)
                    .padding(.top, 40)
                

                Text("MATCHES:")
                    .font(.headline)
                
                List(matchList, id: \.self) { movies in
                    VStack(alignment: .leading){
                        
                        Button(action: {
                            
                          
                                movieTitle = movies
                                showingMovieSheet.toggle()
                                        
                          
                            
                        }, label: {
                            Text(movies)
                        })
                        
                    }
                }

            } //VStack 2
            
            HStack{
                Button(action: {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                        movieTitle = matchList[Int.random(in: 0...matchList.count-1)]
                        
                    }
                    showingMovieSheet.toggle()
                 
                    
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
                        backButton = true

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
                
                Image(profilePicture)
                    .padding(.top, 40)
                        
                
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
           
        }
        
}

struct SelfSheetView : View {
    
    @ObservedObject var user = UserViewModel()

    
    var profilePicture = "defaultUser"
    var userName = "defaultUser"
    var moviesLiked = [""]
    
    
    var body: some View{
        
        VStack{
            
            Image(profilePicture)
                .padding(.top, 40)
                    
            
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
                .background(Color.green)
                .cornerRadius(15.0)
        }
        .onAppear(){
            self.user.fetchData()
        }
       
        
    }
}


