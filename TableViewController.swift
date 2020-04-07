//
//  TableViewController.swift
//  MemeMe
//
//  Created by Sergey on 23/3/20.
//  Copyright © 2020 Sergey. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UITableViewController {
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let delegate = object as! AppDelegate
        return delegate.memes
    }
    var tableview:UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        ///self.tableView.delegate = self
        ///self.tableView.dataSource = self
        ///self.tableView.action = NSObject
        ////self.tableView.me.action(for: addMeme, forKey : String)
        tableView.register(MemeTableViewCell.self, forCellReuseIdentifier: "MemeTableViewCell")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMeme))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        print("LIST \(memes.count)")
        ///self.imageView?.image = memes.memedImage
        ///if memes.count == 0 {
                ///addMemeWithNoAnimation()
        ///}
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("COUNT table\(memes.count)")
        return memes.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell")!
        let dic = memes[(indexPath as NSIndexPath).row]
        cell.imageView?.image = dic.memedImage
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showVC = storyboard?.instantiateViewController(identifier: "MemeDetailViewController") as! MemeDetailViewController
        let memeToSend = memes[(indexPath as NSIndexPath).row]
        showVC.meme = memeToSend
        navigationController?.pushViewController(showVC, animated: true)
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height/6.0
    }
    
    
    
    
    @objc func addMeme() {
        let editVC = storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
        ///let showVC = storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
        navigationController?.pushViewController(editVC, animated: true)
    }
    @objc func addMemeWithNoAnimation() {
        let editVC = storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
        editVC.cancelButtonIsEnabled = true
                ///present(editVC, animated: true, completion: nil)
                navigationController?.pushViewController(editVC, animated: true)
    }
}
