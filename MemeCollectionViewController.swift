//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Sergey on 23/3/20.
//  Copyright © 2020 Sergey. All rights reserved.
//
import UIKit
import Foundation

class MemeCollectionViewController: UICollectionViewController {
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let space:CGFloat = 2.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        let dimension2 = (view.frame.size.height - (2 * space)) / 3.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! CollectionViewCell
               let dic = self.memes[(indexPath as NSIndexPath).row]
               cell.imageView.image = dic.memedImage
               print(cell.imageView.image?.size.height as Any)
               return cell
    }
    
     override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let showVC = storyboard?.instantiateViewController(identifier: "MemeDetailViewController") as! MemeDetailViewController
            let dic = memes[(indexPath as NSIndexPath).row]
            showVC.meme = dic
            //        present(editVC, animated: true, completion: nil)
                    navigationController?.pushViewController(showVC, animated: true)
    }
    }
