import Vapor
import HTTP

public func routes(_ router: Router) throws {
  
  let weatherDataController = WeatherDataController()
  router.get("/", use: weatherDataController.live)
  router.get("/liveImage.jpg", use: weatherDataController.liveImage)
  
  let historyDataController = HistoryDataController()
  router.get("/history", use: historyDataController.history)
}
