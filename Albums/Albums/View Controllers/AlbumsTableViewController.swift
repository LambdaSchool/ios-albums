//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Kat Milton on 8/5/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    var albumController = AlbumController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        albumController.getAlbums(completion: { (error) in
            
            if let error = error {
                print("\(error)")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        albumController.getAlbums(completion: { (error) in
            
            if let error = error {
                print("\(error)")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albumController.albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath)

        cell.textLabel?.text = albumController.albums[indexPath.row].name
        cell.detailTextLabel?.text = albumController.albums[indexPath.row].artist

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
        if segue.identifier == "Add" {
            let destinationVC = segue.destination as? AlbumDetailTableViewController
            destinationVC?.albumController = albumController 
        } else if segue.identifier == "ShowDetails" {
            let destinationVC = segue.destination as? AlbumDetailTableViewController
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let album = albumController.albums[indexPath.row]
            
            destinationVC?.albumController = albumController
            destinationVC?.album = album
        }
    }
    

}
