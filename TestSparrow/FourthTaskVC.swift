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
    private var diffableDataSource: UITableViewDiffableDataSource<Int, Int>!
    private var snapshot: NSDiffableDataSourceSnapshot<Int, Int>!
    
    private var data = Array(0...40)
    
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
        print("shuffle")
        data.shuffle()
        applySnapshot()
    }
    
    // MARK: - Helpers -
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([1])
        snapshot.appendItems(data)
        
        diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - TableView Delegate -
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = data[indexPath.row]
        data.remove(at: indexPath.row)
        data.insert(item, at: 0)
        applySnapshot()
    }
    
    // MARK: - UI Configuration -
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        diffableDataSource = UITableViewDiffableDataSource<Int, Int>(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
            cell.textLabel?.text = "\(itemIdentifier)"
            return cell
        })
        diffableDataSource.defaultRowAnimation = .bottom
        snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([1])
        snapshot.appendItems(data)
        diffableDataSource.apply(snapshot)
    }
}

