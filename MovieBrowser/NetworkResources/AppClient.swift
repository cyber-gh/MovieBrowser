//
// Created by soltan on 30/10/2019.
// Copyright (c) 2019 personal. All rights reserved.
//

import Foundation


class AppClient {

    static let shared = AppClient()

    private init() {

    }

    let apiURLRaw = "https://api.themoviedb.org/3"
    let apiKey = "9298ce2adec59153432766a85f544355" //TODO hide from source control git
    let imagesLocation = "https://image.tmdb.org/t/p/w500/"
    //let apiURL = URL(string: "\(apiURLRaw)?api_key=\(apiKey)" )

    func getFullImagePath(partialPath : String ) -> String {
        return imagesLocation + partialPath
    }

    @discardableResult
    func getImage(imagePath: String, completionHandler: @escaping (Result<Data, Error>) -> Void) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: URL(string: imagesLocation + imagePath)!) { (data, response, error) in
            guard let data = data else { return}
            completionHandler(.success(data))

        }
        task.resume()
        return  task
    }

    func urlBuilder(endPoints: [String], params: Dictionary<String, String>? = nil) -> URL {
        //var str = "\(apiURLRaw)/\(endPoint)?api_key=\(apiKey)"
        var str = "\(apiURLRaw)"
        endPoints.forEach { endPoint in
            str.append(contentsOf: "/\(endPoint)")
        }
        str.append(contentsOf: "?api_key=\(apiKey)" )
        if let params = params {
            params.forEach { key, value in
                str.append(contentsOf: "&\(key)=\(value)")
            }
        }
        return URL(string: str )!
    }

    @discardableResult
    func getLatestMovie(completionHandler: @escaping  (Result<Movie, Error>) -> Void) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: urlBuilder(endPoints: ["movie", "latest"])) { (data, response, error) in
            guard let data = data else {
                completionHandler(.failure(error ?? NetworkError()))
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let movie = try? decoder.decode(Movie.self, from: data)

            if let movie = movie {
                completionHandler(.success(movie))
            } else {
                completionHandler(.failure(EmptyResponse()))
            }
        }
        task.resume()

        return task
    }
    @discardableResult
    func getMovieImagePath(movieId: Int, completionHandler: @escaping (Result<MovieImage, Error>) -> Void) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: urlBuilder(endPoints: ["movie", movieId.toString(), "images"])) {data,response,error in
            guard  let data = data else {
                completionHandler(.failure(error ?? NetworkError()))
                return
            }
            let decoder = JSONDecoder()
            //decoder.keyDecodingStrategy = .convertFromSnakeCase

            let movieImage = try? decoder.decode(MovieImage.self, from: data)

            if let movieImage = movieImage {
                completionHandler(.success(movieImage))
            } else {
                completionHandler(.failure(EmptyResponse()))
            }

        }
        task.resume()
        return  task
    }

    @discardableResult
    func getPopularMovies(page: Int = 1, completionHandler: @escaping (Result<PopularMoviesResult, Error> ) -> Void) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: urlBuilder(endPoints: ["movie", "popular"], params: ["page" : page.toString()])) { data, response, error in
            guard let data = data else {
                completionHandler(.failure(error ?? NetworkError()))
                return
            }
            let decoder = JSONDecoder()
            //decoder.keyDecodingStrategy = .convertFromSnakeCase

            let popularMoviesResult = try? decoder.decode(PopularMoviesResult.self, from: data)

            if let popularMoviesResult = popularMoviesResult {
                completionHandler(.success(popularMoviesResult))
            } else {
                completionHandler(.failure(EmptyResponse()))
            }
        }

        task.resume()
        return task
    }

}
