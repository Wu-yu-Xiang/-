//
//  borrow.swift
//  傘2.0
//
//  Created by chang on 2019/12/18.
//  Copyright © 2019 chang. All rights reserved.
//

import UIKit
import CoreFoundation

class borrowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
 
    
    //地點下拉選單

    @IBAction func startSelect1(_ sender: UIButton) {
        for option in options1 {
            UIView.animate(withDuration: 0.3, animations: {
            option.isHidden =  !option.isHidden
                self.view.layoutIfNeeded()
         })
        }
    }
    @IBOutlet var options1: [UIButton]!
    
    @IBAction func optionPressed1(_ sender: UIButton) {
        let location = sender.currentTitle ?? ""
        print((location))
    }
    
    
    
    //雨傘編號下拉選單
    @IBAction func startSelect2(_ sender: UIButton) {
        for option in option2 {
            UIView.animate(withDuration: 0.3, animations: {
            option.isHidden =  !option.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBOutlet var option2: [UIButton]!
    
    @IBAction func optionPressed2(_ sender: UIButton) {
        let umbrella = sender.currentTitle ?? ""
        print((umbrella))
    }
    
    
    @IBAction func borrowButton(_ sender: Any) {
        print("borrow")
    }
    
    @IBAction func returnButton(_ sender: Any) {
        print("return")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let button = sender as! UIButton
        let controller = segue.destination as! qrcodeViewController
        //controller.name = button.currenTittle
        
    }

}
