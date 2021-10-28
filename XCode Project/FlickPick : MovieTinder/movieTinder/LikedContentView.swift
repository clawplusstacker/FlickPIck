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

struct LikedView: View {
    
    @ObservedObject private var user = UserViewModel()

    @State private var likedList = UserFunctions.getLikedList(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))

    
    @State private var addedOrRemoved = false;
    @Binding var likedSelected : Bool;
    @Binding var dislikedSelected : Bool;
        
    @State var movieTitle = ""
    @State var showingMovieSheet = false;

    

    var body: some View {
        

            VStack {
                             
                HStack {
                                 
                    Text("Liked Movies")
                        .padding()
                        .foregroundColor(.pink)
                        .font(.system(size: 20, weight: .medium, design: .default))

                        

                    Divider()
                        .padding()
                    
                    Button(action: {
                        likedSelected = false;
                        dislikedSelected = true;
                        
                    }, label: {
                        Text("Disliked Movies")
                            .padding()
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .medium, design: .default))

                    })
       
                }   //Hstack
                .frame(height: 60)
                
                Divider()
                    .padding(.horizontal, 30)
                
               
                
                
                    
                if #available(iOS 15.0, *) {
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
                                    UserFunctions.removeFromLiked(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""), title: movies)
                                    UserFunctions.addToMoviesDisliked(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""), title: movies)
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                        likedList = UserFunctions.getLikedList(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))
                                    }
                                    
                                    
                                }, label: {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.blue)
                                })
                                
                            }//Hstack
                            .buttonStyle(BorderlessButtonStyle())
                            
                        }
                    }
                    .refreshable {
                        likedList = UserFunctions.getLikedList(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))
                    }
                    .listStyle(InsetGroupedListStyle())
                } else {
                    // Fallback on earlier versions
                }
                    
                    Spacer()
                   
                                        
                }   //VStack
     
            .sheet(isPresented: $showingMovieSheet, content: {
                MoviePreviewView(movieTitle: $movieTitle)
            })
            
            .onAppear(){
                
                UserViewModel().fetchData()

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    likedList = UserFunctions.getLikedList(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))
                    
                }
            }
    
    }

}

struct DislikedView: View {

    
    @ObservedObject private var user = UserViewModel()
    @State private var dislikedList = UserFunctions.getDislikedList(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))
    
    @State private var addedOrRemoved = false;
    @Binding var likedSelected : Bool;
    @Binding var dislikedSelected : Bool;
    
    @State var movieTitle = ""
    @State var showingMovieSheet = false;
    



    var body: some View {
        

        ZStack {
            
            VStack {
                
                HStack {
                                 
                    Button(action: {
                        likedSelected = true;
                        dislikedSelected = false;
                        
                    }, label: {
                        Text("Liked Movies")
                            .padding()
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .medium, design: .default))

                    })
                        

                    Divider()
                        .padding()
                    
                    Button(action: {
                        likedSelected = false;
                        dislikedSelected = true;
                        
                    }, label: {
                        Text("Disliked Movies")
                            .padding()
                            .foregroundColor(.pink)
                            .font(.system(size: 20, weight: .medium, design: .default))
                    })
       
                }   //Hstack
                .frame(height: 60)
                
                Divider()
                    .padding(.horizontal, 30)
                
                Spacer()
                
                if #available(iOS 15.0, *) {
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
                                    UserFunctions.removeFromDisliked(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""), title: movies)
                                    UserFunctions.addToMoviesLiked(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""), title: movies)
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                        dislikedList = UserFunctions.getDislikedList(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))
                                    }
                                    
                                }, label: {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.pink)
                                })
                            }//HStack
                            .buttonStyle(BorderlessButtonStyle())
                            
                        }//VStack
                    }//List
                    .refreshable {
                        dislikedList = UserFunctions.getDislikedList(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))
                        
                    }
                    .listStyle(InsetGroupedListStyle())
                } else {
                    // Fallback on earlier versions
                }
         
               
                                    
            } //VStack
    
        }   //ZStack
        
        .sheet(isPresented: $showingMovieSheet, content: {
            MoviePreviewView(movieTitle: $movieTitle)
        })
        
        
        .onAppear(){
            UserViewModel().fetchData()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                dislikedList = UserFunctions.getDislikedList(index: UserFunctions.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? ""))
                
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
