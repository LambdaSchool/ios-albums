//
//  AlbumsTableViewController.swift
//  An Album Cover
//
//  Created by Michael Redig on 6/3/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

	let anAlbumController = AnAlbumController()

	override func viewDidLoad() {
		super.viewDidLoad()
		anAlbumController.getAlbums { [weak self] (result: Result<[AnAlbum], NetworkError>) in
			self?.tableView.reloadData()
		}
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let dest = segue.destination as? AlbumDetailTableViewController {
			dest.anAlbumController = anAlbumController

			if segue.identifier == "ShowAlbumDetail" {
				guard let indexPath = tableView.indexPathForSelectedRow else { return }
				dest.album = anAlbumController.albums[indexPath.row]
			}
		}
	}
}

extension AlbumsTableViewController {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return anAlbumController.albums.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		let album = anAlbumController.albums[indexPath.row]
		cell.textLabel?.text = album.name
		cell.detailTextLabel?.text = album.artist
		return cell
	}
}
