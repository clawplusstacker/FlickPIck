//
//  User.swift
//  movieTinder
//
//  Created by Colby Beach on 3/24/21.
//

import Foundation
import RealmSwift

class User: Object{
    
    @objc dynamic var userName = "";
    @objc dynamic var password = "";
    let moviesLiked = List<Movie>()
    let moviesDisliked = List<Movie>()
    let friendList = List<User>()


    
    
    
    func equals(user1 : User) -> Bool{
        
        var result = false;
        
        if(user1.userName == self.userName && user1.password == self.password){
            result = true;
        }

        return result;
        
        
    }
    
    func friendListContains(user1: User) -> Bool{
        
        var result = false;
        
        for users in friendList{
            if(user1.equals(user1: users)){
                result = true;
            }
        }
        
        return result;
        
    }
    
    func likedListContains(movie1: Movie) -> Bool{
        
        var result = false;
        
        for movie in self.moviesLiked{
            if(movie1.equals(movie1: movie)){
                result = true;
            }
        }
        
        return result;
        
    }
    
    func disListContains(movie1: Movie) -> Bool{
        
        var result = false;
        
        for movie in self.moviesDisliked{
            if(movie1.equals(movie1: movie)){
                result = true;
            }
        }
        
        return result;
        
    }
    func matchList(user1: User) -> Array<Movie>{
        
        var result = [Movie]();
        
        for movies in user1.moviesLiked{
            if likedListContains(movie1: movies){
                result.append(movies)
            }
        }
        return result;
    }
    
    func matchListContains(movie1: Movie, user: User) -> Bool{
        
        var result = false;
        var matchList1 = matchList(user1: user)
        
        for movie in matchList1{
            if(movie1.equals(movie1: movie)){
                result = true;
            }
        }
        
        return result;
        
    }
    
    
}
