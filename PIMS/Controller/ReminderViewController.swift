//
//  ReminderViewController.swift
//  PIMS
//
//  Created by hyukhur on 16/04/2017.
//  Copyright © 2017 hyukhur. All rights reserved.
//

import UIKit

class PIMSReminderViewController: PIMS.BaseViewController {
    private typealias Model = PIMS.Reminder.Model

    @IBAction func create(_ sender: Any) {
        let model = Model(reminderID: UUID().uuidString, content: "Remind", done: false)
        Model.save(object: model)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = Model.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = model.content
        cell?.detailTextLabel?.text = model.reminderID
        return cell!
    }
}
typealias PIMSReminderViewController = PIMS.Reminder.ViewController
extension PIMS.Reminder {
    class ViewController: PIMS.BaseViewController {
        @IBAction func create(_ sender: Any) {
        }
    }
}
//    typealias ViewController = PIMSReminderViewController
}
