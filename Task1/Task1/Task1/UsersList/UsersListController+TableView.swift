//
//  UsersListController+TableView.swift
//  

import Foundation
import UIKit

extension UsersListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersListCell", for: indexPath) as! UsersListCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.configure(
            userName: viewModel.itemAt(at: indexPath.row)?.name ?? "None",
            userNickname: viewModel.itemAt(at: indexPath.row)?.username ?? "None"
        )
        
        return cell
    }
}

extension UsersListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectAt(at: indexPath.row)
    }
}
