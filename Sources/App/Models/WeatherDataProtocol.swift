//
//  WeatherDataProtocol.swift
//  TartuWeatherProvider
//
//  Created by Kristaps Grinbergs on 21/02/2018.
//

import Foundation

/// Weather data protocol
public protocol WeatherDataProtocol {

  /// Temperature
  var temperature: String { get }
  
  /// Humidity
  var humidity: String { get }
  
  /// Air pressure
  var airPressure: String { get }
  
  /// Wind speed and direction
  var wind: String { get }
  
  /// Wind direction
  var windDirection: String { get }
  
  /// Precipitation
  var precipitation: String { get }
  
  /// Irradiation flux
  var irradiationFlux: String { get }
  
  /// Measured time
  var measuredTime: String { get }
}
