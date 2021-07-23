//
//  LikedView.swift
//  movieTinder
//
//  Created by Colby Beach on 3/29/21.
//

import Foundation
import RealmSwift
import SwiftUI

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



struct LikedView: View {
    
    @State private var movieList = Array(CurrentUser.currentUser.moviesLiked);
    @State private var addedOrRemoved = false;
    @Binding var likedSelected : Bool;
    @Binding var dislikedSelected : Bool;



    var body: some View {
        

        ZStack {
            
            VStack {
                
                HStack {
                             
                    Text("Liked Movies")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                    
                    Spacer()

                    
                    Button(action: {
                        likedSelected = false;
                        dislikedSelected = true;
                        
                    }, label: {
                        Text("Disliked")
                    })
                    Spacer()

   
                }
                .padding()
         
                List(movieList, id: \.Title) { i in
                    
                    HStack{
                        
                        if(addedOrRemoved){
                           //This is only here to refresh the view to update the button pictures
                        }
                        if(movieList.count == 10000000){
                            //Fake
                        }
                        
                        if(CurrentUser.currentUser.likedListContains(movie1: i)){

                            Text(String((i.Title)))
                            Spacer()
                            Button(action: {
                                
                                if let index = CurrentUser.currentUser.moviesLiked.index(of: i){
                                    
                                    let realm = try! Realm();
                                    
                                    try! realm.write{
                                        CurrentUser.currentUser.moviesLiked.remove(at: index);
                                        CurrentUser.currentUser.moviesDisliked.append(i);

                                    }
                                    
                                    addedOrRemoved = false;
                                    addedOrRemoved = true;
                                    movieList = Array(CurrentUser.currentUser.moviesLiked);
                                }

                            }){
                                Image(systemName: "minus.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.red)
                            }
                        
                            }
                        
        
                        }//HS Stack
                    }//List
                                    
            }
    
        }
    }

}

struct DislikedView: View {

    
    @State private var movieList = Array(CurrentUser.currentUser.moviesDisliked);
    @State private var addedOrRemoved = false;
    @Binding var likedSelected : Bool;
    @Binding var dislikedSelected : Bool;




    var body: some View {
        

        ZStack {
            
            VStack {
                
                HStack {
                             
                    Text("Disliked Movies")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                    
                    Spacer()
                    
                    Button(action: {
                        likedSelected = true;
                        dislikedSelected = false;
                        
                    }, label: {
                        Text("Liked")
                    })
                    Spacer()

   
                }
                .padding()
         
                List(movieList, id: \.Title) { i in
                    
                    HStack{
                        
                        if(addedOrRemoved){
                            //This is only here to refresh the view to update the button pictures

                        }
                      
                        if(CurrentUser.currentUser.disListContains(movie1: i)){
                            Text(String((i.Title)))
                            Spacer()
                            Button(action: {
                                
                                if let index = CurrentUser.currentUser.moviesDisliked.index(of: i){
                                    
                                    let realm = try! Realm();
                                    
                                    try! realm.write{
                                        CurrentUser.currentUser.moviesDisliked.remove(at: index);
                                        CurrentUser.currentUser.moviesLiked.append(i);

                                    }
                                    
                                    addedOrRemoved = false;
                                    addedOrRemoved = true;
                                    movieList = Array(CurrentUser.currentUser.moviesDisliked);
                                    
                                }

                            }){
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.green)
                            
                            }
                        }
        
                        }//HS Stack
                    }//List
                                    
            }
    
        }
    }

}

