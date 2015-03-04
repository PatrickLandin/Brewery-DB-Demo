//
//  BeerDetailViewController.swift
//  BeerAPI
//
//  Created by Patrick Landin on 3/2/15.
//  Copyright (c) 2015 pLandin. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController {
  
  var selectedBeer : Beer?

  @IBOutlet weak var nameLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.nameLabel.text = self.selectedBeer?.name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}
