//
//  PopularMovie.swift
//  movieTinder
//
//  Created by Colby Beach on 2/2/22.
//

import Foundation


// MARK: - PopularMovieList
struct PopularMovieList: Hashable, Codable {
    let page: Int
    let results: [PopularMovie]
}

// MARK: - Result
struct PopularMovie: Hashable, Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}



class PopularViewModel : ObservableObject {
    
    let url = "https://api.themoviedb.org/3/movie/popular?api_key=63d93b08a5c17f9bbb9d8205524f892f"
    //Change to list of credits
    @Published var returnPopList : PopularMovieList = PopularMovieList(page: -1, results: [])
    
    /**
        Fetches Credit List With Given Movie_ID
     */
    func fetchPopList(){

        guard let urlFull = URL(string: url) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlFull) { [weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }

            do {
                let returnPopList = try JSONDecoder().decode(PopularMovieList.self, from: data)
                DispatchQueue.main.async {
                    self?.returnPopList = returnPopList
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
        
    } // End of fetchMovie
}
