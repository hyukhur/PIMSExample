//
//  TimerViewController.swift
//  PIMS
//
//  Created by hyukhur on 16/04/2017.
//  Copyright © 2017 hyukhur. All rights reserved.
//

import UIKit

class PIMSTimerViewController: PIMS.BaseViewController {
    typealias Model = PIMS.Timer.Model

    @IBAction func create(_ sender: Any) {
        let model = Model(token: UUID().uuidString, serverDate: Date(), scheduledDate: Date())
        Model.save(object: model)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = Model.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = model.token
        cell?.detailTextLabel?.text = "\(model.scheduledDate)"
        return cell!
    }
}

extension PIMS.Timer {
    typealias ViewController = PIMSTimerViewController
}
