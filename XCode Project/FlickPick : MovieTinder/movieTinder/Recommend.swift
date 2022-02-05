//
//  Recommend.swift
//  movieTinder
//
//  Created by Colby Beach on 2/2/22.
//

import Foundation

// MARK: - Welcome
struct RecList: Hashable, Codable {
    let page: Int
    let results: [RecMovie]
}

// MARK: - Result
struct RecMovie: Hashable, Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let mediaType, title, originalLanguage, originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath, releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case mediaType = "media_type"
        case title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

class RecViewModel : ObservableObject {
    
    let urlFront = "https://api.themoviedb.org/3/movie/"
    let urlBack = "/recommendations?api_key=63d93b08a5c17f9bbb9d8205524f892f"
    //Change to list of credits
    @Published var returnRecList : RecList = RecList(page: -1, results: [])
    
    /**
        Fetches Credit List With Given Movie_ID
     */
    func fetchRecList(movie_id: Int){
        
        let urlMiddle = String(movie_id)

        guard let urlFull = URL(string: urlFront + urlMiddle + urlBack) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlFull) { [weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }

            do {
                let returnRecList = try JSONDecoder().decode(RecList.self, from: data)
                DispatchQueue.main.async {
                    self?.returnRecList = returnRecList
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
        
    } // End of fetchMovie
}
