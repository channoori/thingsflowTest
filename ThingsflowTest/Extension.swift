//
//  Extension.swift
//  ThingsflowTest
//
//  Created by Channoori Park on 2022/10/28.
//

import UIKit

extension ViewController {
    func alert(msg: String) {
        let alert = UIAlertController(title: "ThingsflowTest", message: msg, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirm)
        self.present(alert, animated: true)
    }
    
    func alertInput(completion: @escaping(String, String) -> Void) {
        let alert = UIAlertController(title: "ThingsflowTest", message: "Organization이름과 Repository이름을 입력해주세요.", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default) { ok in
            completion(alert.textFields?[0].text ?? "", alert.textFields?[1].text ?? "")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(confirm)
        alert.addAction(cancel)
        alert.addTextField { textField in
            textField.placeholder = "Organization 이름"
        }
        alert.addTextField { textField in
            textField.placeholder = "Repository 이름"
        }
        self.present(alert, animated: true)
    }
}
