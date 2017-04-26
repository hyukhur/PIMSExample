//
//  EventVewController.swift
//  PIMS
//
//  Created by hyukhur on 16/04/2017.
//  Copyright © 2017 hyukhur. All rights reserved.
//

import UIKit

class PIMSEventViewController: PIMS.BaseViewController {
    typealias Model = PIMS.Event.Model

    typealias DateRange = PIMS.Event.DateRange
    @IBAction func create(_ sender: Any) {
        let event = Model(dateRange: PIMS.Event.DateRange(startDate: Date(), period: .week), title: "title")
        Model.save(object: event)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = Model.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = event.dateRange.predicate.predicateFormat
        cell?.detailTextLabel?.text = event.title
        return cell!
    }
}

extension PIMS.Event {
    typealias ViewController = PIMSEventViewController
}
