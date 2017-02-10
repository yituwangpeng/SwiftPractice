//
//  ViewController.swift
//  SwiftPractise
//
//  Created by 王鹏 on 16/10/20.
//  Copyright © 2016年 王鹏. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, URLSessionDelegate {
    
    // MARK: - CollectionView
    lazy var collectionView: UICollectionView = {
        
        let collection: UICollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), collectionViewLayout: UICollectionViewFlowLayout())
        collection.backgroundColor = UIColor.white
        collection.delegate = self
        collection.dataSource = self
        collection.register(VideoListCell.self, forCellWithReuseIdentifier: "videoListCell")
        return collection
        
    }()
    
    // MARK: - datasource
    lazy var dataSource: NSMutableArray = {
        let datas = NSMutableArray.init(capacity: 1)
        return datas
        
    }()
 
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.createSubviews()
        
//        //读取json数据
//        let filePath: String = Bundle.main.path(forResource: "video", ofType: "json")!
//        let data: Data = NSData.init(contentsOfFile: filePath) as! Data
        
        fetchData()
    }
    
    func createSubviews() {
        
         self.view.addSubview(collectionView)
    }
    
    func fetchData() -> () {
        let url = URL.init(string: "https://open.qyer.com/plan/video/list")
        let request = URLRequest.init(url: url!)
        let config = URLSessionConfiguration.default
        
        let session = URLSession.init(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        
        let sessionTask = session.dataTask(with: request, completionHandler:{ (data, response, error) -> Void in
            
            //现在dic 是两重Optional
            var dic = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject]
            
            if let dict = dic {
                
                NSLog("response ======== %@", dict ?? "")
                
                let datas = dict?["data"] as? [[String: AnyObject]]
                
                for obj in datas! {
                    var dict: [String: AnyObject] = obj
                    
                    var model = videoModel()
                    model.title = dict["title"] as! String
                    model.cover = dict["cover"] as! String
                    model.url = dict["url"] as! String
                    self.dataSource.add(model)
                    
                }
                
                self.collectionView.reloadData()
            }
//            do {
//                let dict = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject]
//                
//                NSLog("response ======== %@", dict ?? "")
//                
//                let datas = dict?["data"] as? [[String: AnyObject]]
//            
//                for obj in datas! {
//                    var dict: [String: AnyObject] = obj
//                    
//                    var model = videoModel()
//                    model.title = dict["title"] as! String
//                    model.cover = dict["cover"] as! String
//                    model.url = dict["url"] as! String
//                    self.dataSource.add(model)
//                    
//                }
//                
//                self.collectionView.reloadData()
//
//            } catch let aError as NSError {
//                
//            }
        })
        
        sessionTask.resume()
    }
    
    // MARK: - collecitionView delegate & datasource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoListCell", for: indexPath) as! VideoListCell
        cell.setData(data: dataSource[indexPath.row] as! videoModel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var model = self.dataSource[indexPath.row] as! videoModel
        
        let vc = WebDisplayViewController.init()
        vc.originUrlStr = model.url
        
        self.present(vc, animated: true) {
            
        }
    }

    // MARK: - collectonView layout delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
           return UIEdgeInsetsMake(15, 15, 15, 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        var width = (self.view.frame.size.width - 15*2 - 15)/2
        var height = width*1.5
        
        return CGSize.init(width: width, height: height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        
    }
    
}

