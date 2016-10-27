//
//  ViewController.swift
//  SwiftPractise
//
//  Created by 王鹏 on 16/10/20.
//  Copyright © 2016年 王鹏. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    // MARK: - Properties
    lazy var webView: WKWebView = {
        
        let configuretion: WKWebViewConfiguration = WKWebViewConfiguration.init()
        
        let webView: WKWebView = WKWebView.init(frame: CGRect.init(x: 0, y: 20, width: self.view.frame.size.width, height: self.view.frame.size.height - 20), configuration: configuretion)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        return webView
    }()
    

    lazy var pView: UIProgressView = {
        let progressView = UIProgressView.init(progressViewStyle: .default)
        progressView.progressTintColor = UIColor.red
        progressView.trackTintColor = UIColor.clear
        var width = self.view.frame.size.width
        progressView.frame = CGRect.init(x: 0, y: 20, width: width, height: 3)
        
        // kvo 监听webview加载进度KVO 是基于 KVC (Key-Value Coding) 以及动态派发技术实现的，而这些东西都是 Objective-C 运行时的概念。另外由于 Swift 为了效率，默认禁用了动态派发，因此想用 Swift 来实现 KVO，我们还需要做额外的工作，那就是将想要观测的对象标记为 dynamic。
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil);

        return progressView;
    }()
    
    // MARK: - button add target
    lazy var pushButton: UIButton = {
        let button = UIButton.init(type: .contactAdd)
        button.frame = CGRect.init(x: 0, y: 50, width: 100, height: 100)
        button.addTarget(self, action: #selector(self.pushViewController), for: .touchUpInside)
        
        return button;
    }()

    // MARK: - KVO Callback
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let change = change {
            let a = change[.newKey] as! Float
            
            if a == 1 {
                self.pView.progress = a
                self.pView.isHidden = true
            } else {
                self.pView.isHidden = false
                self.pView.progress = a
            }

         }

    }
    
    // MARK: -Events
    func pushViewController() {
        
        let vc = WebDisplayViewController.init()
        
        self.present(vc, animated: true) { 
            
        }
        
    }
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.createSubviews()
        
        let urlString = "https://www.baidu.com"
        
        self.loadRequest(url: URL.init(string: urlString)!)
        
    }

    func createSubviews() {
        
        self.view.addSubview(self.webView)
        
        self.view.addSubview(self.pView)

        self.view.addSubview(self.pushButton)
    }
    
    func loadRequest(url: URL) -> () {
        let request = URLRequest.init(url: url)
        self.webView.load(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }

}

