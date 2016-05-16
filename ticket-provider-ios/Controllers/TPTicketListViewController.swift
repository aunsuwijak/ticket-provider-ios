//
//  TPTicketListViewController.swift
//  ticket-provider-ios
//
//  Created by Suwijak Chaipipat on 5/12/2559 BE.
//  Copyright © 2559 Suwijak Chaipipat. All rights reserved.
//

import UIKit
import SwiftyJSON
import AlamofireImage

class TPTicketListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tickets: JSON?
    let textCellIdentifier = "TPticketListTableViewCell"
    
    @IBOutlet weak var ticketListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = false
        
        self.ticketListTableView.delegate = self
        self.ticketListTableView.dataSource = self
        self.ticketListTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        TPHttpManager.sharedInstance.retrieveTickets({
            responseCode, data in
                if responseCode == 200 {
                    self.tickets = data["tickets"]
                    self.ticketListTableView.reloadData()
                }
            }, errorBlock: {
                
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        self.title = "My Tickets"
        self.addLeftBarButtonWithImage(UIImage(named: "HamburgerIcon")!)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tickets = self.tickets else {
            return 0
        }
        return tickets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.textCellIdentifier, forIndexPath: indexPath) as! TPTicketListTableViewCell
        
        let row = indexPath.row
        if let ticket = self.tickets?[row] {
            cell.activityNameLabel?.text = "\(ticket["activity_name"])"
            
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let activityDate = formatter.dateFromString("\(ticket["activity_date"])")
            formatter.dateFormat = "dd MMMM yyyy"
            cell.activityDateLabel?.text = formatter.stringFromDate(activityDate!)
            
            let imageUrl = NSURL(string: "\(ticket["ticket_type_image_url"])")!
            cell.backgroundImage.af_setImageWithURL(imageUrl)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        
        if let ticket = self.tickets?[row] {
            self.navigateToTicketShow(ticket)
        }
    }
    
    func navigateToTicketShow(ticket: JSON) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let ticketShowVC = storyBoard.instantiateViewControllerWithIdentifier("TPTicketShow") as! TPTicketShowViewController
        
        ticketShowVC.ticket = ticket
        
        self.navigationController?.pushViewController(ticketShowVC, animated: false)
    }
}
