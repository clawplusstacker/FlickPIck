//
//  AddFreindsView.swift
//  movieTinder
//
//  Created by Colby Beach on 3/27/21.
//

import Foundation
import SwiftUI



struct addFriendsView: View {
        

    //private var users = try! Realm().objects(User.self)

    @State private var searchText = ""
    @State private var addedOrRemoved = false;
    @Binding var backButton : Bool;

    
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

                
                    Text("Find or Remove Friends")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        
                    
                    
                
                } //HStack
                .padding()
                
                
                SearchBar(text: $searchText)
                    .padding(.top, 10)
               
            
                
            } //VStack
    
        }   //ZStack
        
        
    }

}

