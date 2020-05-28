//
//  ResultViewController.swift
//  Horoscope
//
//  Created by 藤田優作 on 2020/05/23.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ResultViewController: UIViewController {
    var sign = 0

    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getHoroscope()
        //print("aa")
        // Do any additional setup after loading the view.
    }

    func getHoroscope() {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy/MM/dd",
                                                            options: 0,
                                                            locale: Locale(identifier: "ja_JP"))
        let nowStr = dateFormatter.string(from: now)
        let requestString = "http://api.jugemkey.jp/api/horoscope/free/" + nowStr
        
        Alamofire.request(requestString).responseJSON { response in
            if let jsonObject = response.result.value {
                //print("JSON: \(jsonObject)")
                let json = JSON(jsonObject)
                let result = json["horoscope"][nowStr][self.sign]
                let rank = result["rank"].stringValue
                let sign = result["sign"].stringValue
                let content = result["content"].stringValue
                self.signLabel.text = sign
                self.rankLabel.text = rank
                self.contentLabel.text = content
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
