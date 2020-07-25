//
//  ViewController.swift
//  Network Layer With Alamofire
//
//  Created by Tayyab Ali on 7/25/20.
//  Copyright © 2020 Tayyab Ali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.isHidden = true
        }
    }
    @IBOutlet weak var activityIndecator: UIActivityIndicatorView! {
        didSet {
            activityIndecator.startAnimating()
        }
    }

    var imagesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImageData()
    }
}

// MARK: - Apis Call
extension ViewController {
    
    fileprivate func fetchImageData() {
        NetworkManager.shared.genericMethodCall(target: .fetchData) { (result: Result<[ImageModel], Swift.Error>) in
            
            self.activityIndecator.isHidden = true
            self.tableView.isHidden = false
            switch result {
                
            case .success(let images):
                
                self.imagesArray = images.map({$0.imageUrl})
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }

        }
    }
}

//MARK: - TableView Delegates
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return imagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! ImageCell
        
        cell.updateCell(with: imagesArray[indexPath.row])
        
        return cell
    }
    
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}


