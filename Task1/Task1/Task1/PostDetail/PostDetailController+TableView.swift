//
//  PostDetailController+TableView.swift
//

import Foundation
import UIKit

extension PostDetailController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailCell", for: indexPath) as! PostDetailCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.configure(
            email: viewModel.itemAt(at: indexPath.row)?.email ?? "None",
            commentBody: viewModel.itemAt(at: indexPath.row)?.body ?? "None"
        )
        
        return cell
    }
}
