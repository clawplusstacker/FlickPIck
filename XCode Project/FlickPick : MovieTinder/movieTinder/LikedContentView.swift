//
//  LikedView.swift
//  movieTinder
//
//  Created by Colby Beach on 3/29/21.
//

import Foundation
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
    
    @State private var addedOrRemoved = false;
    @Binding var likedSelected : Bool;
    @Binding var dislikedSelected : Bool;



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
                
                Spacer()
         
               
                                    
            }   //VStack
    
    }

}

struct DislikedView: View {

    
    @State private var addedOrRemoved = false;
    @Binding var likedSelected : Bool;
    @Binding var dislikedSelected : Bool;




    var body: some View {
        

        ZStack {
            
            VStack {
                
                HStack {
                             
                    Text("Disliked Movies")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        .padding()
                    
                    
                    Button(action: {
                        likedSelected = true;
                        dislikedSelected = false;
                        
                    }, label: {
                        Text("Liked")
                    })

   
                }   //HStack
                .padding()
                
                Spacer()
         
               
                                    
            } //VStack
    
        }   //ZStack
    }

}


struct LikedPreview: PreviewProvider  {
    

    static var previews: some View {
        
        LikedView(likedSelected: .constant(true), dislikedSelected: .constant(false))
        //DislikedView(likedSelected: .constant(true), dislikedSelected: .constant(false))

    }
}
