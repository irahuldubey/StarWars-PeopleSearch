//
//  SWServiceEnumeration.swift
//  StarWars
//

public struct Resource: Codable {
  var results: [People]? = []
  var next: String?
  var previous: String?
  var count: Int = 0
}
  
public struct People: Codable {
  
  var name: String
  var mass: String
  var height: String
  var hairColor: String
  var skinColor: String
  var eyeColor: String
  var birthYear: String
  var gender: String
  var homeworld: String
  var created: String
  var edited: String
  var url: String
  
  var films: [String] = []
  var species: [String] = []
  var vehicles: [String] = []
  var starships: [String] = []
  
  enum CodingKeys: String, CodingKey {
    case name
    case mass
    case height
    case hairColor = "hair_color"
    case skinColor = "skin_color"
    case birthYear = "birth_year"
    case eyeColor = "eye_color"
    case gender
    case homeworld
    case films
    case species
    case vehicles
    case starships
    case created
    case edited
    case url
  }
}
