//
//  WelcomeSheet.swift
//  movieTinder
//
//  Created by Colby Beach on 9/22/21.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore




struct WelcomeSheetView : View{
    
    var body: some View {
    
        VStack{
            
            Image(systemName: "chevron.down")
                .padding()
                .foregroundColor(.white)
                .font(.system(size: 40))

            
            Spacer()
            
            VStack{
                
                Text("Welcome Back ")
                    .foregroundColor(.white)
                    .italic()
                    .font(.system(size: 40, weight: .medium))
                
                    
                
                Text("to")
                    .foregroundColor(.white)
                    .italic()
                    .font(.system(size: 40, weight: .medium))
                    .padding()
                
                Text("FlickPick")
                    .foregroundColor(.white)
                    .italic()
                    .font(.system(size: 40, weight: .black))
                
            }
            .padding(.bottom, 350)
       
               
        }
        .background(
            Image("gradientBG")
        )
            
            
    }
    
}
