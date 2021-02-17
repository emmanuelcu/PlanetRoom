//
//  SolarSystem.swift
//  PlanetRoom
//
//  Created by Emmanuel Cuevas on 09/02/21.
//

import Foundation

struct SolarSystem {
    let planets = [
        Planet(n: "Mercury", u: K.Planets.Mercury),
        Planet(n: "Venus", u: K.Planets.Venus),
        Planet(n: "Earth", u: K.Planets.Earth),
        Planet(n: "Mars", u: K.Planets.Mars),
        Planet(n: "Jupiter", u: K.Planets.Jupiter),
        Planet(n: "Saturn", u: K.Planets.Saturn),
        Planet(n: "Uranus", u: K.Planets.Uranus),
        Planet(n: "Neptune", u: K.Planets.Neptune)
    ]
    var planetNumber = 0
    
    mutating func nextPlanet(){
        if planetNumber + 1 < planets.count{
            planetNumber += 1
//            print(planetNumber)
        }else{
            planetNumber = 0
        }
    }
    
    mutating func prevPlanet(){
        if planetNumber - 1 > 0{
            planetNumber -= 1
//            print(planetNumber)
        }else{
            planetNumber = 0
        }
    }
    
    func getPlanetName() -> String{
        let planetName = planets[planetNumber].name
//        print(planetName)
        return planetName
    }
    
    func getPlanetImage() -> String{
        let planetURL = planets[planetNumber].url
        return planetURL
    }

}
