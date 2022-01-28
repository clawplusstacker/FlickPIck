//
//  movie.swift
//  movieTinder
//
//  Created by Colby Beach on 3/19/21.
//


import Foundation

/**
 Structure for movies
 
 Based on:
 Json Data Structure For Movies in the Movie Database API
 */
struct Movie: Hashable, Codable {

    
    let adult: Bool
    let backdrop_path: String
    let belongs_to_collection: String
    let budget: Int
    let genres: [String]
    let homepage: String
    let id: Int
    let imdb_id: String
    let original_language: String
    let overview: String
    let popularity: Int
    let poster_path: String
    let production_companies: [String]
    let production_countries: [String]
    let release_date: String
    let revenue: Int
    let runtime: Int
    let spoken_languages: [String]
    let status: String
    let tagline: String
    let video : Bool
    let vote_average: Int
    let vote_count: Int
    
}


class MovieViewModel : ObservableObject {
    
    let popularMin = 50
    let urlFirst = "https://api.themoviedb.org/3/"
    let urlLast = "?api_key=63d93b08a5c17f9bbb9d8205524f892f"
    
    /**
        Fetches A Movie With A Random Movie_ID
     */
    func fetchMovie(){
        
    }
    
    
    /**
        Fetches Movie Data With A Given Movie_ID
     */
    func fetchMovie(movie_id: Int){
        
    }
    
    
    
    /**
        Checks if Movie confers with current popular minimum
     */
    func isPopular(movie_id: Int){
        
    }
    
    
    
    /**
        Compares movie given to the current user and if it passes their current data
            Such as : not already liked / disliked, matches their streaming service preference
     */
    func compareMovieToUser(movie_id: Int){
        
        
    }
    
    /**
     Returns the given movies streaming services
     */
    func streamingServiceCheck(movie_id : Int){
        
        
        
    }
    

    /**
        Function that will get the current movie needed for the currently logged in user.
        Uses the previous helper functions to acheive this and get what movie would
        be best.
     */
    func getCurrentMovie(){
        
    }
    
}
