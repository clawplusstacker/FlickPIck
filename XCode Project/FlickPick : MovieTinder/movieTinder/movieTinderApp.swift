//
//  movieTinderApp.swift
//  movieTinder
//
//  Created by Colby Beach on 3/19/21.


import SwiftUI
import Firebase
@main

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


/*
 Used to fix Orientation when uploading profilePic to firebase storage
 */
extension UIImage {
    func fixOrientation() -> UIImage? {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }

        UIGraphicsBeginImageContext(self.size)
        self.draw(in: CGRect(origin: .zero, size: self.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
