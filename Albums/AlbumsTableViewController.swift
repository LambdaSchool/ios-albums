//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Lotanna Igwe-Odunze on 1/28/19.
//  Copyright © 2019 Sugabelly LLC. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MusicController.shared.albums.count
    }
    
}
