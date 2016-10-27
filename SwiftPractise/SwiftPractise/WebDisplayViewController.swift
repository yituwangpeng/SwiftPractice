//
//  WebDisplayViewController.swift
//  SwiftPractise
//
//  Created by 王鹏 on 16/10/20.
//  Copyright © 2016年 王鹏. All rights reserved.
//

import UIKit

class WebDisplayViewController: ViewController {

    // MARK: - button add target
    lazy var backButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 0, y: 50, width: 100, height: 100)
        button.addTarget(self, action: #selector(self.backViewController), for: .touchUpInside)
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button;
    }()

    // MARK: -Events
    func backViewController() {
        
        self.dismiss(animated: true) { 
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.addSubview(self.backButton)
        
        let url = URL.init(string: "https://baidu.com")
        
        if let loadUrl = url {
            self.loadRequest(url: loadUrl)

        }
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

}
