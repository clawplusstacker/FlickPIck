//
//  movieTinderApp.swift
//  movieTinder
//
//  Created by Colby Beach on 3/19/21.


import SwiftUI
import Firebase

///
///Configuring and Setting up Firebase
///



@main   //Obvisouly shows that this is the main App sequence


struct movieTinderApp: App {


    init() {
        FirebaseApp.configure()
      }
    

    var body: some Scene {
        
        WindowGroup {
            
            LoadingScreenContentView()
            //LoginContentView()
            
                   
        }
    }
}
