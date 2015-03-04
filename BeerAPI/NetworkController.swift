//
//  NetworkController.swift
//  BeerAPI
//
//  Created by Patrick Landin on 1/25/15.
//  Copyright (c) 2015 pLandin. All rights reserved.
//

import UIKit

class NetworkController {
  
  class var sharedNetworkController : NetworkController {
    struct Static {
      static let instance : NetworkController = NetworkController()
    }
    return Static.instance
  }

  func fetchBeersForSearchTerm(searchTerm : String, completionHandler : ([Beer]?, String?) -> (Void)) {
    let url = NSURL(string: "http://api.brewerydb.com/v2/search?key=bd8c3a5a3503d79ea553868ba7189517&q=\(searchTerm)&type=beer")
    let request = NSMutableURLRequest(URL: url!)
    request.HTTPMethod = "GET"
    var urlSession = NSURLSession.sharedSession()
    let dataTask = urlSession.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      if (error == nil) {
        if let httpResponse = response as? NSHTTPURLResponse {
          println(httpResponse.statusCode)
          switch httpResponse.statusCode {
          case 200...299:
            println("fucking boom")
           
            let results = Beer.beersFromJSON(data)
            if results != nil {
              
              NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              completionHandler(results, nil)
                
              })
            } else {
              completionHandler(nil, "error happened")
            }
          default:
            println("ah crap")
          }
        }
        println(error)
      } else {
        println("crap\(data)")
      }
    })
    dataTask.resume()
  }
}
