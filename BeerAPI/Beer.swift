//
//  Beer.swift
//  BeerAPI
//
//  Created by Patrick Landin on 2/15/15.
//  Copyright (c) 2015 pLandin. All rights reserved.
//

import UIKit

class Beer {
  let name : String
  let id : String
  let abv : String?
  let description : String?
//  let glass : String
  
  init(jsonDictionary : [String : AnyObject]) {
    
    self.name = jsonDictionary["name"] as String
    self.id = jsonDictionary["id"] as String
    
    
    if let abv = jsonDictionary["abv"] as? String {
      self.abv = jsonDictionary["abv"] as? String
    }
    if let description = jsonDictionary["description"] as? String {
      self.description = description
    }
  }
  
  class func beersFromJSON(jsonData : NSData) -> [Beer]? {
    
    if let jsonDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: nil) as? [String : AnyObject] {
      
      if let dataArray = jsonDictionary["data"] as? [[String : AnyObject]] {
      
    var beers = [Beer]()
    for data in dataArray {
      var beer = Beer(jsonDictionary: data)
      beers.append(beer)
    }
      return beers
      }
      return nil
    } else {
      return nil
      }
  }
}