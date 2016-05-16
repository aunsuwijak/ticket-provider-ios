//
//  TPTicketShowViewController.swift
//  ticket-provider-ios
//
//  Created by Suwijak Chaipipat on 5/15/2559 BE.
//  Copyright © 2559 Suwijak Chaipipat. All rights reserved.
//

import UIKit
import AlamofireImage
import SwiftyJSON

class TPTicketShowViewController: UIViewController {

    var ticket: JSON?
    
    @IBOutlet weak var ticketImage: UIImageView!
    @IBOutlet weak var activityNameLabel: UILabel!
    @IBOutlet weak var ticketLabel: UILabel!
    @IBOutlet weak var ticketPriceLabel: UILabel!
    @IBOutlet weak var ticketDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageUrl = NSURL(string: "\(ticket!["ticket_type_image_url"])")
        self.ticketImage.af_setImageWithURL(imageUrl!)
        
        self.activityNameLabel.text = ">> \(ticket!["activity_name"])"
        
        self.ticketLabel.font = UIFont.boldSystemFontOfSize(14.0)
        self.ticketLabel.text = "\(ticket!["ticket_type_name"]) \(ticket!["row"]) \(ticket!["column"])"
        
        self.ticketPriceLabel.text = "\(ticket!["price"])"
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let activityDate = formatter.dateFromString("\(ticket!["activity_date"])")
        formatter.dateFormat = "dd MMMM yyyy"
        self.ticketDateLabel.text = formatter.stringFromDate(activityDate!)
        
        self.navigationController?.navigationBar.backItem?.title = ""
        self.title = "\(ticket!["activity_name"])"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
