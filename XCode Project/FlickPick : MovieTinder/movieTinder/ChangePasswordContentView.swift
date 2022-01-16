//
//  ChangePasswordContentView.swift
//  movieTinder
//
//  Created by Colby Beach on 9/24/21.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct ChangePasswordView : View{
    
    
    @State private var email = "";
    @State private var alertShow = false
    @State private var alertText = ""
    @State private var alertTitle = "Success!"

    
    @State private var errorText = ""
    



    var body: some View{
        
        ZStack {
            
            VStack {
                
                
                HStack {
                    
                    Text("Change Password")
                        .font(.system(size: 25, weight: .medium, design: .default))
                        .foregroundColor(.pink)
                        .padding(.horizontal, 15)
                    
                    Spacer()
                
                } //HStack
                .padding(.top, 60)
                
                
                
                LabelledDivider(label: "")
                    .padding()
                
            
                Text(errorText)
                
               
                
                TextField("Enter Email Associated With Account:", text: $email)
                    .padding()
                    .cornerRadius(20.0)
                    .overlay(
                         RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 0.2)
                     )
                    .shadow(radius:1)
                    .padding(.horizontal, 30)
                

                
                
                Button("Send Reset Link"){
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                    Auth.auth().sendPasswordReset(withEmail: email) { error in
                        if let error = error {
                                                    
                            alertShow.toggle()
                            alertText = error.localizedDescription
                            alertTitle = "Error!"

                        } else{
                            alertShow.toggle()
                            alertText = "Your Password Reset Email Has Been Sent!"
                            alertTitle = "Success!"

                        }
                    }
                    

                }
                .alert(isPresented: $alertShow, content: {
                    Alert(title: Text(alertTitle), message: Text(alertText), dismissButton: .default(Text("Okay!")))
                })
               
                .padding()
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.pink)
                .cornerRadius(15.0)
                .padding(.top, 50)

                
                Spacer()

            }
        }
        .background(Image("whitePinkGradient"))

    }
}

