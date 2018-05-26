//
//  QueryDataProtocol.swift
//  TartuWeatherProvider
//
//  Created by Kristaps Grinbergs on 21/02/2018.
//

import Foundation

/// Query data protocol
public protocol QueryDataProtocol: WeatherDataProtocol {

  /// UV Index
  var uvIndex: String { get }

  /// Light
  var light: String { get }
  
  /// Gamma radiation
  var gammaRadiation: String { get }
}
