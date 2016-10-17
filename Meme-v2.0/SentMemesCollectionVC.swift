//
//  SentMemesCollectionVC.swift
//  Meme-v2.0
//
//  Created by LIJO RAJU on 17/10/16.
//  Copyright © 2016 LIJORAJU. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionVC:UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var meme : [MemeObject] {
        return (UIApplication.shared.delegate as! AppDelegate).memes //Accessing the shared model 'memes' in AppDelegate
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView?.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat = 3.0
        let dimension1 = (view.frame.size.width - (5 * space)) / 3.0
        let dimension2 = (view.frame.size.height - (5 * space)) / 7.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width:dimension1,height:dimension2)
        
    }
    
    //Returns the number of items in the specified section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meme.count
        
    }
    
    //Returns the visible cell object at the specified index path
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemesCollectionViewCell", for: indexPath) as! SentMemesCollectionViewCell
        cell.memeImage?.image = meme[indexPath.row].memedImage
        return cell
        
    }
    
    //Tells the delegate that the item at the specified index path was selected
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier:"DetailViewController") as! DetailViewController
        detailController.meme = meme[indexPath.row].memedImage
        self.navigationController!.pushViewController(detailController, animated: true) //Pushes a DetailViewController onto the navigationcontrollers stack and updates display
        
    }
    
}
