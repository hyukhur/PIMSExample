//
//  AlarmViewController.swift
//  PIMS
//
//  Created by hyukhur on 16/04/2017.
//  Copyright © 2017 hyukhur. All rights reserved.
//

import UIKit

class PIMSAlarmViewController: PIMS.BaseViewController {
    typealias Model = PIMS.Alarm.Model
    
    @IBAction func create(_ sender: Any) {
        let model = Model(token: UUID().uuidString, period: PIMS.Alarm.Model.Period(scheduledDate: Date(), weekdays: nil))
        Model.save(object: model)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = Model.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "\(String(describing: model.period.weekdays))"
        cell?.detailTextLabel?.text = "active: \(model.active)"
        return cell!
    }
}

extension PIMS.Alarm {
    typealias ViewController = PIMSAlarmViewController
}
