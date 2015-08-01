//
//  DogsMenuViewController.swift
//  SlideOutNavigation
//
//  Created by zeus on 31/07/2015.
//  Copyright © 2015 James Frost. All rights reserved.
//

import Foundation
import UIKit

class DogsMenuViewController: SlideMenuViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var animals: Array<Animal>!
    
    struct TableView {
        struct CellIdentifiers {
            static let AnimalCell = "AnimalCell"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animals = Animal.allDogs()
        
        tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableView.CellIdentifiers.AnimalCell, forIndexPath: indexPath) as! AnimalCell
        cell.configureForAnimal(animals[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //let selectedAnimal = animals[indexPath.row]
        delegate?.itemSelected("Item1")
    }
}
