//
//  ViewController.swift
//  AlertDialog
//
//  Created by daniel hu on 09/22/2022.
//  Copyright (c) 2022 daniel hu. All rights reserved.
//

import UIKit
import AlertDialog

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showAlertDialog() {
        let alert = AlertDialog(title: "温馨提示", message: "测试内容")
        let cancel = CancelButton { [weak alert] in
            alert?.dismiss(animated: true)
        }
        alert.addButton(cancel)
        present(alert, animated: true)
    }
}

