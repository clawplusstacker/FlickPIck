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
import FirebaseStorage



private var db = Firestore.firestore()
private var userStore = UserStoreFunctions()



struct AddProfilePicView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showingImagePicker = false
    @State private var image: UIImage?
    @ObservedObject var userData = UserViewModel()
    @State var userIndex = userStore.getFireStoreUserIndex(uid: (Auth.auth().currentUser?.uid) ?? "")


    
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
                    let profilePicUrl = URL(string: userStore.getProfilePicture(index: userIndex))
                    
                    if #available(iOS 15.0, *) {
                        AsyncImage(url: profilePicUrl) { phase in
                            if let image = phase.image {
                                image
                                    .cornerRadius(150.0)
                                    .padding(.top, 40)

                            } else if phase.error != nil {
                                Text("Network Error!")
                                    .cornerRadius(150.0)
                                    .padding(.top, 40)
                            } else {
                                ProgressView()
                                    .cornerRadius(150.0)
                                    .padding(.top, 40)
                            }
                        }
                    }
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
                uploadImageToStorage(image: image)
                presentationMode.wrappedValue.dismiss()
                
            } label: {
                Text("Save Changes")
                    .frame(width: 325, height: 20)
            }
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 350, height: 50)
                .background(Color.blue)
                .cornerRadius(15.0)
                .padding(.top)
            
            Spacer()
            
        } //VStack
        
        .background(Image("whitePinkGradient"))
        
        
        //ImagePicker
        .sheet(isPresented: $showingImagePicker){
            ImagePicker(image: $image)
        }
        
        .onAppear{
            userData.fetchData()
        }
        

        
        
    }//Var body
    
    
    func uploadImageToStorage(image: UIImage?) {
        
        let fileName = Auth.auth().currentUser?.uid ?? ""
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let picRef = storageRef.child(fileName)
        
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else { return }
        
        
        picRef.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                print("Failed to push image to Storage: \(err)")
                return
            }

            picRef.downloadURL { url, err in
                if let err = err {
                    print("Failed to retrieve downloadURL: \(err)")
                    return
                }
                
                UserStoreFunctions().addProfilePicture(index: userIndex, pictureURL: url!)
                
                
            }
        }
    } //Function
    
}//Struct



struct AddProfilePicPreview: PreviewProvider  {

    static var previews: some View {
        
        AddProfilePicView()

    }
}
