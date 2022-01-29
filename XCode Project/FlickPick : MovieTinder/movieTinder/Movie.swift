//
//  movie.swift
//  movieTinder
//
//  Created by Colby Beach on 3/19/21.
//


import Foundation
import SwiftUI

/**
 Structure for movies
 
 Based on:
 Json Data Structure For Movies in the Movie Database API
 */
/**
 Structure for movies
 
 Based on:
 Json Data Structure For Movies in the Movie Database API
 */
struct Movie: Hashable, Codable {
    
    let adult: Bool?
    let backdropPath: String?
    let belongsToCollection: BelongsToCollection?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct BelongsToCollection: Hashable, Codable {
    let id: Int?
    let name, posterPath, backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
struct Genre: Hashable, Codable {
    let id: Int?
    let name: String?
}

struct ProductionCompany: Hashable, Codable {
    let id: Int?
    let logoPath, name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

struct ProductionCountry: Hashable, Codable {
    let iso3166_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

struct SpokenLanguage: Hashable, Codable {
    let englishName, iso639_1, name: String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}




class MovieViewModel : ObservableObject {
    
    let popularMin = 50
    let urlFirst = "https://api.themoviedb.org/3/"
    let urlLast = "?api_key=63d93b08a5c17f9bbb9d8205524f892f"
    let boolean1 = false;
    let String1 = "";
    let int1 = 0;
    let double2 = 0.1
    @Published var returnMovie : Movie = Movie(adult: false, backdropPath: "", belongsToCollection: BelongsToCollection(id: 2, name: "", posterPath: "", backdropPath: ""), budget: 0, genres: [Genre(id: 0, name: "")], homepage: "", id: -1, imdbID: "", originalLanguage: "", originalTitle: "", overview: "", popularity: 0.0, posterPath: "", productionCompanies: [ProductionCompany(id: 0, logoPath: "", name: "", originCountry: "")], productionCountries: [ProductionCountry(iso3166_1: "", name: "")], releaseDate: "", revenue: 2, runtime: 1, spokenLanguages: [SpokenLanguage(englishName: "", iso639_1: "", name: "")], status: "", tagline: "", title: "", video: false, voteAverage: 2.0, voteCount: 0)
    
    
    /**
        Fetches A Movie With Given Movie_ID
     */
    func fetchMovie(movie_id: Int){
        
        let urlMiddle = "movie/" + String(movie_id)
        let urlFull = urlFirst + urlMiddle + urlLast
        print(urlFull)

        guard let urlFull = URL(string: urlFull) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlFull) { [weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }

        
            do {
                let returnMovie = try JSONDecoder().decode(Movie.self, from: data)
                DispatchQueue.main.async {
                    self?.returnMovie = returnMovie
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
        
    } // End of fetchMovie
}


class CompareMovie {
    
    @StateObject var viewModel = MovieViewModel()
    
    /**
        Checks if Movie confers with current popular minimum
     */
    func isPopular(movie_id: Int) -> Bool{
        
        viewModel.fetchMovie(movie_id: movie_id)
        
        var movie = viewModel.returnMovie
        
        if(movie.popularity ?? 0 > 50){
            return true
        }
        return false
        
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
