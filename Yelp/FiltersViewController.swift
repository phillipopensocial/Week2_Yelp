//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Phillip Pang on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate {
    @objc optional func filtersViewController( filtersViewController:FiltersViewController, filters: [String:AnyObject])
}

class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwitchCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var categories: [ [String:String] ]!
    var switchStates: [Int:Bool] = [:]
    weak var delegate:FiltersViewControllerDelegate?
    
    @IBAction func onCancelButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSearchButton(_ sender: AnyObject) {
            dismiss(animated: true, completion: nil)
        
        var filters : [String:AnyObject] = [:]
        
        var selectedCategories : [String] = []
        for(row, isSelected) in switchStates {
            
            if isSelected {
                selectedCategories.append( categories[row]["code"]!)
            }
            
        }
        if selectedCategories.count > 0 {
            filters["categories"] = selectedCategories as AnyObject?
        }
        
        delegate?.filtersViewController!(filtersViewController: self, filters: filters )
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        categories = yelpCategories()
        
        //Table
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //Tables
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.codepath.SwitchCell", for: indexPath) as! SwitchCell
        
        cell.gSwitchLabel.text = categories[indexPath.row]["name"]
        cell.delegate = self
        
        //Set the state
        cell.gOnSwitch.isOn = switchStates[indexPath.row] ?? false
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    //Delegate
    func SwitchCell(switchCell: SwitchCell, didChangeValue: Bool) {
        let indexPath = tableView.indexPath(for: switchCell)!
        
        switchStates[indexPath.row] = didChangeValue
        print("\nFiltersViewController gets the event")
        
    }
    
    
    //Yelp
    func yelpCategories() -> [[String:String]] {
        return [["name":"Afghan","code":"afghani"],
            ["name":"Vegan","code":"vega"] ]
    }

}
