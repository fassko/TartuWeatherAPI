//
//  LiveImageProtocol.swift
//  TartuWeatherProvider
//
//  Created by Kristaps Grinbergs on 21/02/2018.
//

import Foundation

/// Live image data protocol
public protocol LiveImageProtocol {

  /// Live image
  var liveImage: LiveImage { get }
}
