//
//  SentMemesViewController.swift
//  Meme-v2.0
//
//  Created by LIJO RAJU on 16/10/16.
//  Copyright © 2016 LIJORAJU. All rights reserved.
//

import UIKit

class SentMemesTableVC: UITableViewController {
    
    var memes : [MemeObject] {
        return (UIApplication.shared.delegate as! AppDelegate).memes //Accessing the shared model 'memes' in AppDelegate
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
        
    }
    
    //Returns the current number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
        
    }
    
    //Returns the table cell at the specified index path
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTable")!
        cell.imageView?.image = memes[indexPath.row].memedImage
        cell.textLabel?.text = memes[indexPath.row].topText + "..." + memes[indexPath.row].bottomText
        return cell
        
    }
    
    //Called to know that the user selected a row in the table
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailController.meme = self.memes[indexPath.row].memedImage
        self.navigationController!.pushViewController(detailController, animated: true) //Pushes a DetailViewController onto the navigationcontrollers stack and updates display
        
    }

}
