//
//  ViewController.swift
//  TestSparrow
//
//  Created by Pasha Otverchenko on 05.05.2023.
//

import UIKit

final class FourthTaskVC: UIViewController, UITableViewDelegate {
    
    // MARK: - UI Elements -
    
    private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // MARK: - Fields -
    
    private let cellIdentifier = "cell"
    private var diffableDataSource: UITableViewDiffableDataSource<Sections, Int>!
    private var snapshot: NSDiffableDataSourceSnapshot<Sections, Int>!
    
    private var data = Array(0...40).map { SparrowData(title: $0, isChecked: false) }
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureTableView()
        title = "Task 4"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "shuffle"),
            style: .done,
            target: self,
            action: #selector(handleShuffling))
    }
    
    // MARK: - Objective-C Methods -
    
    @objc
    private func handleShuffling() {
        data.shuffle()
        applySnapshot()
    }
    
    // MARK: - Helpers -
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data.map { $0.title })
        snapshot.reconfigureItems(data.map { $0.title })
        diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - TableView Delegate -
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if !data[indexPath.row].isChecked {
            var item = data[indexPath.row]
            data.remove(at: indexPath.row)
            item.changeCheckedState()
            data.insert(item, at: 0)
            applySnapshot()
        } else {
            data[indexPath.row].changeCheckedState()
            var snapshot = diffableDataSource.snapshot()
            snapshot.reconfigureItems([data[indexPath.row].title])
            diffableDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    // MARK: - UI Configuration -
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        diffableDataSource = UITableViewDiffableDataSource<Sections, Int>(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
            guard let data = self.data.first(where: { $0.title == itemIdentifier }) else { return cell }
            cell.textLabel?.text = "\(itemIdentifier)"
            cell.accessoryType = data.isChecked ? .checkmark : .none
            return cell
        })
        diffableDataSource.defaultRowAnimation = .bottom
        snapshot = NSDiffableDataSourceSnapshot<Sections, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data.map { $0.title })
        diffableDataSource.apply(snapshot)
    }
    
    // MARK: - Nested Types -
    
    struct SparrowData: Hashable, Equatable {
        let title: Int
        var isChecked: Bool
        
        mutating func changeCheckedState() {
            isChecked = !isChecked
        }
        
        
    }
    
    enum Sections: Int {
        case main
    }
}

