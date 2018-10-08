//
//  ViewController.swift
//  PaginationSwift
//
//  Created by Daniyal Yousuf on 3/21/18.
//  Copyright © 2018 Daniyal Yousuf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var dataSource :[String] = ["apple"]
    var userActivityView: UIActivityIndicatorView!
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addActivityIndicator()
        tblView.tableFooterView?.isHidden = false
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addActivityIndicator(){
        userActivityView = UIActivityIndicatorView(activityIndicatorStyle:.gray)
        userActivityView.isHidden =  false
        userActivityView.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        userActivityView.backgroundColor = UIColor.green
       // userActivityView.center = uiView.center
    }

}
extension ViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.detailTextLabel?.text = "\(indexPath.row)"
        cell?.backgroundColor  = UIColor.red
        return cell!
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dataSource.count - 1 {
           loadMore()
        }
    }
    func loadMore(){
        self.userActivityView.startAnimating()
        let currentTime = CFAbsoluteTimeGetCurrent()
        DispatchQueue.global(qos: .userInteractive).async {
            for _ in 0...100 {
                self.dataSource.append("new element")
            }
        DispatchQueue.main.async {
                let latestTime = CFAbsoluteTimeGetCurrent()
                let elapsedTime = (latestTime - currentTime) * 1000.0
                print("\(elapsedTime)")
                self.userActivityView.stopAnimating()
                self.tblView.reloadData()
            }
        }
    }
    

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let uiView = UIView(frame:CGRect.init(x: 0, y: 0, width: self.tblView.frame.size.width, height: 100))
        uiView.backgroundColor = UIColor.purple
        userActivityView.center = uiView.center
        uiView.addSubview(userActivityView!)
        return uiView
    }
}

