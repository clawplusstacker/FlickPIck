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
    
    @State private var showingImagePicker = false
    @State private var image: UIImage?

    
    var body: some View {
        
        VStack{
            
            Text("Change Profile Picture")
                .font(.system(size: 33, weight: .black, design: .rounded))
                .padding(.top, 60)

            
            VStack{
                
                if let image = self.image{
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .scaledToFit()
                        .cornerRadius(150)
                }else{
                    Image("defaultUser")
                        .cornerRadius(150.0)
                        .padding(.top, 40)
                }
            }
       

            
            
            //Uploading New Image
            Button {
                
                showingImagePicker.toggle()
                
            } label: {
                Text("Upload New Profile Picture")
                    .frame(width: 325, height: 20)
            }
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 350, height: 50)
                .background(Color.pink)
                .cornerRadius(15.0)
                .padding(.top, 40)
            
            
            
            //Editing Current Image
            Button {
                Alert(title: SwiftUI.Text("Hi"))
            } label: {
                Text("Edit Current Profile Picture")
                    .frame(width: 325, height: 20)
            }
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 350, height: 50)
                .background(Color.pink)
                .cornerRadius(15.0)
                .padding(.top)
            
            Spacer()
            
        } //VStack
        
        .background(Image("whitePinkGradient"))
        
        
        //ImagePicker
        .sheet(isPresented: $showingImagePicker){
            ImagePicker(image: $image)
        }
        

        
        
    }//Var body
}//Struct



struct AddProfilePicPreview: PreviewProvider  {

    static var previews: some View {
        
        AddProfilePicView()

    }
}
