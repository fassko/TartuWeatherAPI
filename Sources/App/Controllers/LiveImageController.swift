//
//  LiveImageController.swift
//  App
//
//  Created by Kristaps Grinbergs on 26/05/2018.
//

import Vapor

final class LiveImageController {
  
  func large(_ req: Request) throws -> Future<Response> {
    return try liveImage(req, "http://meteo.physic.ut.ee/webcam/uus/suur.jpg")
  }
  
  func small(_ req: Request) throws -> Future<Response> {
    return try liveImage(req, "http://meteo.physic.ut.ee/webcam/uus/pisike.jpg")
  }
  
  func liveImage(_ req: Request, _ url: String) throws -> Future<Response> {
    return try req.sharedContainer.client().get(url)
  }
}
