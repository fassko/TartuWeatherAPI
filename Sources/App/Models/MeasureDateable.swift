//
//  MeasureDateable.swift
//  Pods-TartuWeatherProvider_Example
//
//  Created by Kristaps Grinbergs on 23/02/2018.
//

import Foundation

/// Measure date protocol
public protocol MeasureDateable {}

public extension MeasureDateable where Self == WeatherData {
  
  /// Measured date
  public var measuredDate: Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "EET")
    dateFormatter.dateFormat = "dd MMM yy HH:mm:ss"
    
    return dateFormatter.date(from: measuredTime)
  }
}
