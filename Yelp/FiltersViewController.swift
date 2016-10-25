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


enum PrefRowIdentifier : String {
    case Category = "Category!"
    case Sort = "Sort"
    case Distance = "Distance"
    case Deals = "Deals"
}

class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwitchCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let tableStructure: [PrefRowIdentifier] = [.Category, .Sort, .Distance,.Deals]
    var tableRowStructure: [Int] = []
    var prefValues: [PrefRowIdentifier: Bool] = [:]
    
    
    var categories: [ [String:String] ]!
    var switchStates: [Int:Bool] = [:]
    weak var delegate:FiltersViewControllerDelegate?
    
    
    //Sections
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("indexPath: sect: \(indexPath.section)  Row: \(indexPath)" )
        let aPrefSect = tableStructure[indexPath.section]

        
        switch aPrefSect{
            case .Sort:
                let cell = tableView.dequeueReusableCell(withIdentifier: "com.codepath.SliderCell", for: indexPath) as! SliderCell
                cell.gSlider.removeAllSegments()
                cell.gSlider.insertSegment(withTitle: "Best Match", at: 0, animated: true)
                cell.gSlider.insertSegment(withTitle: "Distance", at: 1, animated: true)
                cell.gSlider.insertSegment(withTitle: "Highest Rated", at: 2, animated: true)
                return cell
            
            case .Deals:
                let cell = tableView.dequeueReusableCell(withIdentifier: "com.codepath.SwitchCell", for: indexPath) as! SwitchCell
                cell.gSwitchLabel.text = "Deals"
                return cell
            
            case .Distance:
                let cell = tableView.dequeueReusableCell(withIdentifier: "com.codepath.SliderCell", for: indexPath) as! SliderCell
                cell.gSlider.removeAllSegments()
                cell.gSlider.insertSegment(withTitle: "0.3 Mile", at: 0, animated: true)
                cell.gSlider.insertSegment(withTitle: "1 Mile", at: 1, animated: true)
                cell.gSlider.insertSegment(withTitle: "5 Miles", at: 2, animated: true)
                cell.gSlider.insertSegment(withTitle: "20 Miles", at: 3, animated: true)
                return cell
            
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "com.codepath.SwitchCell", for: indexPath) as! SwitchCell
                cell.gSwitchLabel.text = categories[indexPath.row]["name"]
                cell.delegate = self
                //Set the state
                cell.gOnSwitch.isOn = switchStates[indexPath.row] ?? false
                return cell
                

        }


    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return categories.count
        
        //return tableStructure.count
        return tableRowStructure[section]
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableStructure.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var header:String = " "
        
        let aSection = tableStructure[section]
        
        switch aSection{
            case .Category: header = PrefRowIdentifier.Category.rawValue
            case .Sort: header = PrefRowIdentifier.Sort.rawValue
            case .Distance: header = PrefRowIdentifier.Distance.rawValue
            case .Deals: header = PrefRowIdentifier.Deals.rawValue
            default: header = " "
        }
        
        return   header
    }
       
    
    
    
    //Event
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
        tableRowStructure.append( categories.count)
        tableRowStructure.append(1)
        tableRowStructure.append(1)
        tableRowStructure.append(1)
        
        

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
    

    
    
    //Delegate
    func SwitchCell(switchCell: SwitchCell, didChangeValue: Bool) {
        let indexPath = tableView.indexPath(for: switchCell)!
        
        switchStates[indexPath.row] = didChangeValue
        print("\nFiltersViewController gets the event")
        
    }
    
    
    //Yelp
    func yelpCategories() -> [[String:String]] {
        return [["name":"Afghan","code":"afghani"],
            ["name":"African","code":"african"],
            ["name":"Baguettes","code":"baguettes"],
            ["name":"Chinese","code":"chinese"],
            ["name":"Danish","code":"danish"],
            ["name":"Ethiopian","code":"ethiopian"],
            ["name":"Flatbread","code":"flatbread"],
            ["name":"Vegan","code":"vega"] ]
    }


}
