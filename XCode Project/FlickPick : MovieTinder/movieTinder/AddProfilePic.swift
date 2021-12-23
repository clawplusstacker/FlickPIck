//
//  AddProfilePic.swift
//  movieTinder
//
//  Created by Colby Beach on 12/23/21.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

private var db = Firestore.firestore()
private var userStore = UserStoreFunctions()


struct AddProfilePicView: View {
    
    var body: some View {
        
        VStack{
            
            Text("Add a Profile Picture")
                .font(.system(size: 30).bold())
            
            Image("defaultUser")
            

            Spacer()
            
        } //VStack
        .background(Image("whitePinkGradient"))
        
    }//Var body
}//Struct



struct AddProfilePicPreview: PreviewProvider  {

    static var previews: some View {

        AddProfilePicView()

    }
}
