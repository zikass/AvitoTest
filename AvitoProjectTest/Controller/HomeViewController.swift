//
//  HomeViewController.swift
//  AvitoProjectTest
//
//  Created by Zakaria elmouatassim on 05/03/2018.
//  Copyright © 2018 Zakaria elmouatassim. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class HomeViewController: NetworkingController , UITableViewDelegate , UITableViewDataSource{
    
    // MARK: - Outlets
    @IBOutlet weak var AdsTableview: UITableView!
    
    // MARK: - Properties
    var adsArray  = [AdsView]()
    var BASE_URL = "https://services.avito.ma/api"

    override func viewDidLoad() {
        super.viewDidLoad()

        //register cell
        let nib = UINib(nibName: "ListViewCell", bundle: nil)
        self.AdsTableview.register(nib, forCellReuseIdentifier: "adsCell")
       
        //Call Networking method
            getAdsList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Datasource & Delegate UItableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.adsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "adsCell") as! ListViewCell
        let adsObject = self.adsArray[indexPath.row]
        cell.subjectLbl.text = adsObject.subject
        cell.nameUser.text = adsObject.name
        if adsObject.price != nil{
        cell.priceLbl.text = "\(String(describing: adsObject.price!)) DH"
        }else{
            cell.priceLbl.text =  ""
        }
        if let urlImage = URL(string: "https://www.avito.ma/images/" + adsObject.imagePath!){
            
            let placeHolder = UIImage(named : "avito.png")
            cell.imageAds.sd_setImage(with: urlImage, placeholderImage: placeHolder, options: [], completed: nil)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }

    
    // MARK: - Networking methods
    func getAdsList()
    {
        let  headers  =  [
            "Accept"     :   "application/json",
            "Content-Type"       :   "application/json",
            "lang"       :   "fr"
        ]
        self.networkingGET(url: BASE_URL + "/v1/ads", headers: headers)
    }

    
    
    override func networkingGotResponse(json: JSON) {
        print("\n\n JSON = \(json)")
        
        if   let dictionary = json.dictionaryObject{
            
            if let array = dictionary["ads"] as? NSArray{
            
            for i in 0 ..< array.count{
                var adsView : AdsView?
                let adsObject = array[i] as! NSDictionary
                let adId = adsObject.object(forKey: "adId") as? NSInteger
                let name = adsObject.object(forKey: "name") as? String
                let subject = adsObject.object(forKey: "subject") as? String
                let price = adsObject.object(forKey: "price") as? NSInteger
                let body = adsObject.object(forKey: "body") as? String
                let date = adsObject.object(forKey: "date") as? String
                var pathImage = ""
                if  let images =  adsObject.object(forKey: "images") as? NSArray{
                    let imageObj = images[0] as! NSDictionary
                    pathImage  = imageObj.object(forKey: "path") as! String
                }
                adsView = AdsView(adsId: adId, subject: subject, name: name, bodyDesc: body, price: price, imagePath: pathImage, date: date)
                self.adsArray.append(adsView!)
            }
                self.AdsTableview.reloadData()

            }
        }
        
    }
}
