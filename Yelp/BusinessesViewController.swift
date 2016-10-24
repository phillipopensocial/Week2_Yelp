//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate{
    
    var businesses: [Business]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup Table
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //Setup Search
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
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
