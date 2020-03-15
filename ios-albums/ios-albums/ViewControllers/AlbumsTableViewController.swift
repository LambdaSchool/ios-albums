//
//  AlbumsTableViewController.swift
//  ios-albums
//
//  Created by Joseph Rogers on 3/9/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    var albumController = AlbumController()

    override func viewDidLoad() {
        super.viewDidLoad()
        let album = albumController.testDecodingExampleAlbum()
        albumController.createAlbum(album: album!)
        albumController.getAlbums(completion: {
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albumController.albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        
        cell.textLabel?.text = self.albumController.albums[indexPath.row].name
        cell.detailTextLabel?.text = self.albumController.albums[indexPath.row].artist
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let detailVC = segue.destination as? AlbumDetailTableViewController {
                guard let indexPath = tableView.indexPathForSelectedRow else { return }
                
                detailVC.albumController = self.albumController
                detailVC.album = self.albumController.albums[indexPath.row]
            }
        }
        
        if segue.identifier == "AddSegue" {
            if let addVC = segue.destination as? AlbumDetailTableViewController {
                addVC.albumController = self.albumController
            }
        }
    }
}
