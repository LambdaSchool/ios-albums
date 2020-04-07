//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Jon Bash on 2019-12-02.
//  Copyright © 2019 Jon Bash. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    var albumController: AlbumController?

    override func viewDidLoad() {
        super.viewDidLoad()

        albumController = AlbumController()
        
        albumController?.getAlbums(completion: { result in
            do {
                let _ = try result.get()
            } catch {
                print("Error fetching albums: \(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController?.albums.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        guard let album = albumController?.albums[indexPath.row] else { return cell }
        
        cell.textLabel?.text = album.name
        cell.detailTextLabel?.text = album.artist

        return cell
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let albumDetailVC = segue.destination as? AlbumDetailViewController {
            albumDetailVC.albumController = albumController
            if let index = tableView.indexPathForSelectedRow?.row, segue.identifier == "EditAlbumSegue" {
                albumDetailVC.album = albumController?.albums[index]
            }
        }
    }
}
