//
//  LikedView.swift
//  movieTinder
//
//  Created by Colby Beach on 3/29/21.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LikedContentView : View{
    
    @State var likedSelected = true;
    @State var disSelected = false;
    
    var body: some View{
        
        
        if(likedSelected){
            LikedView(likedSelected: $likedSelected, dislikedSelected: $disSelected);
        }else if(disSelected){
            DislikedView(likedSelected: $likedSelected, dislikedSelected: $disSelected);
        }
        
    }
}

private var UserFunctions = UserStoreFunctions()
private var db = Firestore.firestore()
private var currentUserUID = Auth.auth().currentUser?.uid

struct LikedView: View {
    
    @ObservedObject private var user = UserViewModel()

    @State private var likedList = ["Loading Movies"]
    
    @State private var addedOrRemoved = false;
    @Binding var likedSelected : Bool;
    @Binding var dislikedSelected : Bool;
        
    @State var movieTitle = ""
    @State var showingMovieSheet = false;


    var body: some View {
        

            VStack {
                
                HStack {
                             
                    Text("Liked Movies")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        .padding()
                    

                    Spacer()

                    Button(action: {
                        likedSelected = false;
                        dislikedSelected = true;
                        
                    }, label: {
                        Text("Disliked")
                            .padding()
                    })

   
                }   //Hstack
                .padding()
                
                
                
                List(likedList, id: \.self) { movies in
                    VStack(alignment: .leading){
                        
                        HStack{
                            Button(action: {
                                movieTitle = movies
                                showingMovieSheet.toggle()

                            }, label: {
                                Text(movies)
                            })
                            
                            Spacer()
                            
                            Button(action: {
                                UserFunctions.removeFromLiked(index: UserFunctions.getFireStoreUserIndex(uid: currentUserUID!), title: movies)
                                UserFunctions.addToMoviesDisliked(index: UserFunctions.getFireStoreUserIndex(uid: currentUserUID!), title: movies)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                    likedList = UserFunctions.getLikedList(index: UserFunctions.getFireStoreUserIndex(uid: currentUserUID!))
                                }

                                
                            }, label: {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.blue)
                            })
                            
                        }//Hstack
                        .buttonStyle(BorderlessButtonStyle())

                    }
                }
                
                
                Spacer()
               
                                    
            }   //VStack
            
     
            .sheet(isPresented: $showingMovieSheet, content: {
                MoviePreviewView(movieTitle: $movieTitle)
            })
            
            .onAppear(){
                
                UserViewModel().fetchData()

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    likedList = UserFunctions.getLikedList(index: UserFunctions.getFireStoreUserIndex(uid: currentUserUID!))
                    
                }
            }
    
    }

}

struct DislikedView: View {

    
    @ObservedObject private var user = UserViewModel()
    @State private var dislikedList = ["Loading Movies"]
    
    @State private var addedOrRemoved = false;
    @Binding var likedSelected : Bool;
    @Binding var dislikedSelected : Bool;
    
    @State var movieTitle = ""
    @State var showingMovieSheet = false;
    



    var body: some View {
        

        ZStack {
            
            VStack {
                
                HStack {
                             
                    Text("Disliked Movies")
                        .font(.system(size: 39, weight: .black, design: .rounded))
                        .padding()
                    
                    
                    Spacer()
                    
                    
                    Button(action: {
                        likedSelected = true;
                        dislikedSelected = false;
                        
                    }, label: {
                        Text("Liked")
                
                    })

   
                }   //HStack
                .padding()
                
                Spacer()
                
                List(dislikedList, id: \.self) { movies in
                    VStack(alignment: .leading){
                        
                        HStack{
                            Button(action: {
                                
                                movieTitle = movies
                                showingMovieSheet.toggle()
                                

                            }, label: {
                                Text(movies)

                            })
                            
                            
                            Spacer()
                            
                            Button(action: {
                                UserFunctions.removeFromDisliked(index: UserFunctions.getFireStoreUserIndex(uid: currentUserUID!), title: movies)
                                UserFunctions.addToMoviesLiked(index: UserFunctions.getFireStoreUserIndex(uid: currentUserUID!), title: movies)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                    dislikedList = UserFunctions.getDislikedList(index: UserFunctions.getFireStoreUserIndex(uid: currentUserUID!))
                                }
                                
                            }, label: {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.pink)
                            })
                        }//HStack
                        .buttonStyle(BorderlessButtonStyle())
                      
                    }//VStack
                }//List
         
               
                                    
            } //VStack
    
        }   //ZStack
        
        .sheet(isPresented: $showingMovieSheet, content: {
            MoviePreviewView(movieTitle: $movieTitle)
        })
        
        
        .onAppear(){
            UserViewModel().fetchData()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                dislikedList = UserFunctions.getDislikedList(index: UserFunctions.getFireStoreUserIndex(uid: currentUserUID!))
                
            }
        }
    }

}


//struct LikedPreview: PreviewProvider  {
//
//
//    static var previews: some View {
//
//        LikedView(likedSelected: .constant(true), dislikedSelected: .constant(false))
//        //DislikedView(likedSelected: .constant(true), dislikedSelected: .constant(false))
//
//    }
//}
