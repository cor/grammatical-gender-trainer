//
//  ViewController.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 02-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import UIKit

class GroupListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var group: Group!
    @IBOutlet weak var tableView: UITableView!

    let cellIdentifier = "cellIdentifier"
    let showListIdentifier = "showList"
    var selectedList: List?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.group = SimpleGroup(name: "Loading...", lists: [List](), groups: [Group]())
        self.title = "Loading..."
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            let loadedGroup = WrtsSource(username: "qlpc@q8p.nl", password: "School5ucks4Lyfe").root
            //self.group = WrtsSource(username: "wrts@pruijs.nl", password: "uBq-eS8-nKs-d8p").root
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false

            dispatch_async(dispatch_get_main_queue()) {
                self.group = loadedGroup
                self.title = loadedGroup.name

                self.tableView.reloadData()
            }
        }
    }

    // MARK: UITableViewDataSource methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return group.groups.count + 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return group.lists.count
        default: return group.groups[section - 1].lists.count // subgroups not supported + group.groups[section - 1].groups.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as UITableViewCell
        
        cell.textLabel?.text = listForIndexPath(indexPath).name
        
        return cell
    }
    
    func listForIndexPath(indexPath: NSIndexPath) -> List {
        switch indexPath.section {
        case 0: return group.lists[indexPath.item]
        default:
            let currentGroup = group.groups[indexPath.section - 1]
            return currentGroup.lists[indexPath.item]
        }
        
        // subgroups not supported
        //            if (indexPath.item < currentGroup.lists.count) {
        //                cell.textLabel?.text = currentGroup.lists[indexPath.item].name
        //            } else {
        //                cell.textLabel?.text = currentGroup.groups[indexPath.item - currentGroup.lists.count].name
        //            }
    }
    
    // MARK: UITableViewDelegate methods
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return nil
        default: return group.groups[section - 1].name
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.destinationViewController {
        case let preGameController as PreGameController:
            if let selectedList = self.selectedList {
                preGameController.words = selectedList.words
                preGameController.title = selectedList.name
            }
        default: break;
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let path = tableView.indexPathForSelectedRow()!
        let loadingList = listForIndexPath(path)
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            loadingList.words
            self.selectedList = loadingList

            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            dispatch_async(dispatch_get_main_queue()) {
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                self.performSegueWithIdentifier("game", sender: self)
            }
        }

    }
    
/*
    func printList(list: List, indent: String) -> String {
        var text = ""
        text += "\(indent)List '\(list.name):'\n"
        
//        for word in list.words {
//            text += "  \(indent)\(word)\n"
//        }
        
        return text
    }
    
    func printGroup(group : Group, indent: String) -> String {
        var text = ""
        text += "\(indent)\(group.name):\n"
        
        for list in group.lists {
            text += "\(indent)" + printList(list, indent: indent + "  ")
        }
        
        for group in group.groups {
            text += "\(indent)Group: " + printGroup(group, indent: indent + "  ")
        }
        
        return text
    }
*/
}

