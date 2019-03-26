//
//  SearchViewController.swift
//  reciplease
//
//  Created by james on 26/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    var ingredients : [String] = [] //list ingredients enter by user

    @IBOutlet weak var searchTextField: UITextField! // ingredient user input
    @IBOutlet weak var tableView: UITableView! //ingredients TableView
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Action UI
    
    @IBAction func onClickAdd(_ sender: Any) {
        if let text = searchTextField.text, !text.isEmpty {
            ingredients.append(text)
            searchTextField.text = ""
            self.tableView.reloadData()
        }
    }
    @IBAction func onClickClear(_ sender: Any) {
        ingredients.removeAll()
        self.tableView.reloadData()
    }
    @IBAction func onClickSearch(_ sender: Any) {
        print("search with : \(ingredients)")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate{
    
}
// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
    
}