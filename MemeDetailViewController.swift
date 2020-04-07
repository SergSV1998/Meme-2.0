//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Sergey on 23/3/20.
//  Copyright © 2020 Sergey. All rights reserved.
//
import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    @IBOutlet weak var memedImage: UIImageView!
    var meme: Meme!
    ///var memes: [Meme]! {
        ///let object = UIApplication.shared.delegate
        ///let appDelegate = object as! AppDelegate
        ///return appDelegate.memes
    ///}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editMeme))
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ///self.tabBarController?.tabBar.isHidden = true
        ///self.imageView?.image = meme.memedImage
        memedImage.image = meme.memedImage
        
        
    }
   
     ///override func viewWillDisappear(_ animated: Bool) {
        ///super.viewWillDisappear(animated)
        ///self.tabBarController?.tabBar.isHidden = false
          @objc func editMeme() {
                let editVC = storyboard?.instantiateViewController(identifier: "MemeDetailViewController") as! MemeDetailViewController
            editVC.meme = meme
                navigationController?.pushViewController(editVC, animated: true)
        }
    }
