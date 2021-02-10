//
//  SolarSystem.swift
//  PlanetRoom
//
//  Created by Emmanuel Cuevas on 09/02/21.
//

import Foundation

struct SolarSystem {
    let planets = [
        K.Planets.Mercury,
        K.Planets.Venus,
        K.Planets.Earth,
        K.Planets.Mars,
        K.Planets.Jupiter,
        K.Planets.Saturn,
        K.Planets.Uranus,
        K.Planets.Neptune
    ]
    var planetNumber = 0
    
    mutating func nextPlanet(){
        if planetNumber + 1 < planets.count{
            planetNumber += 1
            print(planetNumber)
        }else{
            planetNumber = 0
        }
    }
    
    mutating func prevPlanet(){
        if planetNumber - 1 > 0{
            planetNumber -= 1
            print(planetNumber)
        }else{
            planetNumber = 0
        }
    }
    
    func getPlanetName() -> String{
        var planetName = planets[planetNumber]
        print(planetName)
        return planetName
    }

}
