//
//  WeatherData.swift
//  Pods
//
//  Created by Kristaps Grinbergs on 20/02/2017.
//
//

import Foundation
import Vapor

/// Weather data
public struct WeatherData: WeatherDataProtocol, MeasureDateable, Content {
  public var temperature: String
  public var humidity: String
  public var airPressure: String
  public var wind: String
  public var windDirection: String
  public var precipitation: String
  public var irradiationFlux: String
  public var measuredTime: String
  
//  public var liveImage: LiveImage
  
  /**
    Init method
    
    - Parameters:
      - temperature: Temperature
      - humidity: Humidity
      - airPressure: Air pressure
      - wind: Wind
      - precipitation: Precipitation
      - irradiationFlux: Irradiation flux
      - measuredTime: Measured time
  */
  init(temperature: String, humidity: String, airPressure: String, wind: String,
       precipitation: String, irradiationFlux: String, measuredTime: String
//    ,
//       smallImageURL: String, largeImageURL: String
    ) {
    
    self.temperature = temperature
    self.humidity = humidity
    self.airPressure = airPressure
    
    let windParts = wind.components(separatedBy: " ")
    self.wind = "\(windParts[1]) \(windParts[2])"
    self.windDirection = windParts[0]
    
    self.precipitation = precipitation
    self.irradiationFlux = irradiationFlux
    self.measuredTime = measuredTime
    
//    self.liveImage = LiveImage(small: smallImageURL, large: largeImageURL)
  }
}
