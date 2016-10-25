//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate, UISearchBarDelegate{
    
    var businesses: [Business]!
    var searchBar : UISearchBar!
    var defaultSearchText = "Thai"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup Table
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //Add search bar
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    
        
        //Setup Search
        doSearch(searchTerm: defaultSearchText)
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    func doSearch( searchTerm: String){
        Business.searchWithTerm(term: searchTerm, completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
            }
        )
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included

/*  filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
    */
        if searchText.isEmpty == false {
            doSearch(searchTerm: searchText)
        }else{
            doSearch(searchTerm: defaultSearchText)
        }
        tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Tables
    //Tables methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.codepath.BusinessCell", for: indexPath) as! BusinessCell

        cell.business = businesses[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if businesses != nil {
            return businesses!.count
        }else{
            return 0
        }
    }
    

     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
              // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
    
            let navigationalController = segue.destination as! UINavigationController
        
            let filtersViewControler = navigationalController.topViewController as! FiltersViewController
        
            filtersViewControler.delegate = self
    }
 

    
    func filtersViewController(filtersViewController: FiltersViewController, filters: [String : AnyObject]) {
        
        var categories = filters["categories"] as? [String]
        
        print("\nBusinessViewController: About to update SearchWithTerm")
        
        Business.searchWithTerm(term: "Restaurants", sort: nil, categories: categories, deals: nil) { (businesses:[Business]? , error:Error?) in
            self.businesses = businesses
            self.tableView.reloadData()
        }
        
            
    }
    

}
