//
//  MenuView.swift
//  SideMenuTest
//
//  Created by Allister Alambra on 16/11/2016.
//  Copyright © 2016 Allister Alambra. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    
    var previouslySelectedHeaderIndex: Int?
    var selectedHeaderIndex: Int?
    var selectedItemIndex: Int?
    
    var cells: SwiftyAccordionCells!
    
    var selectedMenuItem : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cells = SwiftyAccordionCells()
        self.setup()
        
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.backgroundColor = UIColor.clearColor()
        tableView.scrollsToTop = false
        
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup() {
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Geology"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Planning"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Analysis"))
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Geochemistry"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Planning"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Analysis"))
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Petrology"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Planning"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Analysis"))
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "RED"))
    }
    
    // MARK: - Table view data source
    
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // Return the number of sections.
//        return 1
//    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.cells.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let item = self.cells.items[(indexPath as NSIndexPath).row]
        let value = item.value
        let isChecked = item.isChecked as Bool
        var newCell:UITableViewCell?
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("cell") {
            cell.textLabel?.text = value
            
            if item as? SwiftyAccordionCells.HeaderItem != nil {
                cell.backgroundColor = UIColor.lightGrayColor()
                cell.accessoryType = .None
            } else {
                if isChecked {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            }
            
            return cell
        }
        else{
            newCell = UITableViewCell()
            newCell?.textLabel?.text = value
            if item as? SwiftyAccordionCells.HeaderItem != nil {
                newCell!.backgroundColor = UIColor.lightGrayColor()
                newCell!.accessoryType = .None
            } else {
                if isChecked {
                    newCell!.accessoryType = .Checkmark
                } else {
                    newCell!.accessoryType = .None
                }
            }
            return newCell!
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let item = self.cells.items[(indexPath as NSIndexPath).row]
        
        if item is SwiftyAccordionCells.HeaderItem {
            return 60
        } else if (item.isHidden) {
            return 0
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let item = self.cells.items[(indexPath as NSIndexPath).row]
        
        if item is SwiftyAccordionCells.HeaderItem {
            if self.selectedHeaderIndex == nil {
                self.selectedHeaderIndex = (indexPath as NSIndexPath).row
            } else {
                self.previouslySelectedHeaderIndex = self.selectedHeaderIndex
                self.selectedHeaderIndex = (indexPath as NSIndexPath).row
            }
            
            if let previouslySelectedHeaderIndex = self.previouslySelectedHeaderIndex {
                self.cells.collapse(previouslySelectedHeaderIndex)
            }
            
            if self.previouslySelectedHeaderIndex != self.selectedHeaderIndex {
                self.cells.expand(self.selectedHeaderIndex!)
            } else {
                self.selectedHeaderIndex = nil
                self.previouslySelectedHeaderIndex = nil
            }
            
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            
        } else {
            if (indexPath as NSIndexPath).row != self.selectedItemIndex {
                let cell = self.tableView.cellForRowAtIndexPath(indexPath)
                cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
                
                if let selectedItemIndex = self.selectedItemIndex {
                    let previousCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: selectedItemIndex, inSection: 0))
                    previousCell?.accessoryType = UITableViewCellAccessoryType.None
                    cells.items[selectedItemIndex].isChecked = false
                }
                self.selectedItemIndex = (indexPath as NSIndexPath).row
                cells.items[self.selectedItemIndex!].isChecked = true
            }
        }
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
}
