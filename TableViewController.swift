//
//  TableViewController.swift
//  BeerAPI
//
//  Created by Patrick Landin on 1/25/15.
//  Copyright (c) 2015 pLandin. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  var beers = [Beer]()
  
    override func viewDidLoad() {
        super.viewDidLoad()

      self.tableView.dataSource = self
      self.searchBar.delegate = self
      
        // Do any additional setup after loading the view.
    }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.beers.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier("BEER_CELL", forIndexPath: indexPath) as UITableViewCell
    
    cell.textLabel?.text = self.beers[indexPath.row].name
    
    return cell
  }

  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    println(searchBar.text)
    self.searchBar.resignFirstResponder()
    
    NetworkController.sharedNetworkController.fetchBeersForSearchTerm(self.searchBar.text, completionHandler: { (beers, error) -> (Void) in
      if error == nil {
        self.beers = beers!
        
        self.tableView.reloadData()
      } else {
        println("Uh oh. Search probably returned a bunch of nothin")
      }
    })
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "SHOW_DETAIL" {
      let destinationVC = segue.destinationViewController as BeerDetailViewController
      let selectedIndexPath = self.tableView.indexPathForSelectedRow()?
      destinationVC.selectedBeer = self.beers[selectedIndexPath!.row]
    }
  }

}
