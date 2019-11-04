// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieImage = try? newJSONDecoder().decode(MovieImage.self, from: jsonData)

import Foundation

// MARK: - MovieImage
struct MovieImage: Codable {
    let id: Int?
    let backdrops, posters: [Backdrop]?
}

// MARK: - Backdrop
struct Backdrop: Codable {
    let aspectRatio: Double?
    let filePath: String?
    let height: Int?
    let iso639_1: String?
    let voteAverage, voteCount, width: Int?

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case height
        case iso639_1 = "iso_639_1"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}
