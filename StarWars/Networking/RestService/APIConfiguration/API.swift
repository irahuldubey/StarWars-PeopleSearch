//
//  API.swift
//  StarWars
//

enum API: String {
  case scheme = "https"
  case host = "swapi.dev"
  case path = "/api"
}

public enum AttributeType: String {
  case people
  case films
  case planets
  case species
  case starships
  case vehicles
}
