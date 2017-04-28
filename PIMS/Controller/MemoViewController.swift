//
//  MemoViewController.swift
//  PIMS
//
//  Created by hyukhur on 16/04/2017.
//  Copyright © 2017 hyukhur. All rights reserved.
//

import UIKit

class PIMSMemoViewController: PIMS.BaseViewController {
    private typealias Model = PIMS.Memo.Model

    @IBAction func create(_ sender: Any) {
        let model = Model(memoID: "Memo", content: "content", createDate: Date())
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
        cell?.detailTextLabel?.text = "\(String(describing: model.createDate))"
        return cell!
    }
}

extension PIMS.Memo {
    typealias ViewController = PIMSMemoViewController
}
