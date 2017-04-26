//
//  BaseViewController.swift
//  PIMS
//
//  Created by hyukhur on 16/04/2017.
//  Copyright © 2017 hyukhur. All rights reserved.
//

import UIKit

extension PIMS {
    class BaseViewController: UITableViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
}
