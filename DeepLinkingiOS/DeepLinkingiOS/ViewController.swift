//
//  ViewController.swift
//  DeepLinkingiOS
//
//  Created by Phincon on 24/09/23.
//

import UIKit
import StoreKit


class ViewController: UIViewController, UITableViewDataSource {
    
    let data = ["Account", "Privacy", "Contact"]
    
    private let table = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad ()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(table)
        table.dataSource = self
        table.tableFooterView = createFooter()
    }
    
    private func createFooter() -> UIView {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        footer.backgroundColor = .secondarySystemBackground
        let size = (view.frame.size.width-40)/3
        for x in 0..<3 {
            let button = UIButton (frame: CGRect(x: CGFloat (x) * size + (CGFloat (x)+1 * 10), y: 0,
                                                 width: size, height: size))
            footer.addSubview(button)
            button.tag = x+1
            button.setBackgroundImage (UIImage (named: "app\(x+1)"), for: .normal)
            button.addTarget(self, action: #selector (didTapButton (_:)),
                             for: .touchUpInside)
        }
        return footer
    }
    
    @objc private func didTapButton(_ sender: UIButton) {
        let tag = sender.tag
        if tag == 1 {
            //microsoft word
            guard let url = URL(string: "ms-word://") else {
                return
            }
            print("Open word apps")
            if UIApplication.shared.canOpenURL(url) {
                // deep link
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            else {
                // upsell
                let vc = SKStoreProductViewController()
                //value: 586447913 = id microsoft word in apps store
                vc.loadProduct (withParameters: [SKStoreProductParameterITunesItemIdentifier: NSNumber (value: 586447913)], completionBlock: nil)
                present (vc, animated: true)
            }
        }
        else if tag == 2 {
            //excel
            guard let url = URL(string: "ms-excel://") else {
                return
            }
            print("Open excel apps")
            if UIApplication.shared.canOpenURL(url) {
                // deep link
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            else {
                // upsell
                let vc = SKStoreProductViewController()
                vc.loadProduct (withParameters: [SKStoreProductParameterITunesItemIdentifier: NSNumber (value: 586683407)], completionBlock: nil)
                present (vc, animated: true)
            }
            
        }
        else if tag == 3 {
            //disney hostar
            guard let url = URL(string: "disney-hostar://") else {
                return
            }
            print("Open disney hostar apps")
            if UIApplication.shared.canOpenURL(url) {
                // deep link
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            else {
                // upsell
            }

        }

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
}

