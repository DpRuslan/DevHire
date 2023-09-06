//
//  DefaultUserController+TableView.swift
//

import Foundation
import UIKit

extension DefaultUserController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultUserCell", for: indexPath) as! DefaultUserCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.configure(
            postName: viewModel.itemAt(at: indexPath.row)?.title ?? "None",
            postBody: viewModel.itemAt(at: indexPath.row)?.body ?? "None"
        )
        
        return cell
    }
}

extension DefaultUserController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectAt(at: indexPath.row)
    }
}
