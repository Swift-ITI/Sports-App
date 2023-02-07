//
//  LeagueDetailsViewController.swift
//  Sports-App
//
//  Created by Adham Samer on 06/02/2023.
//

import Foundation
import UIKit

class LeagueDetailsViewController: UIViewController {
    @IBOutlet var resultsCollectionView: UICollectionView!
    @IBOutlet var teamsCollectionView: UICollectionView!
    @IBOutlet var eventsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        let eventNib = UINib(nibName: "EventCVCell", bundle: nil)
        let resultNib = UINib(nibName: "ResultCVCell", bundle: nil)
        let teamNib = UINib(nibName: "TeamCVCell", bundle: nil)

        resultsCollectionView.register(resultNib, forCellWithReuseIdentifier: "resultCell")
        eventsCollectionView.register(eventNib, forCellWithReuseIdentifier: "eventCell")
        teamsCollectionView.register(teamNib, forCellWithReuseIdentifier: "teamCell")
        let rightButton = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(printAdd))
        navigationItem.rightBarButtonItem = rightButton
        resultsCollectionView.reloadData()
        teamsCollectionView.reloadData()
        eventsCollectionView.reloadData()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        resultsCollectionView.reloadData()
        teamsCollectionView.reloadData()
        eventsCollectionView.reloadData()
    }
    @objc func printAdd() {
        print("Added")
    }
}

extension LeagueDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func setDelegates() {
        resultsCollectionView.delegate = self
        resultsCollectionView.dataSource = self

        eventsCollectionView.dataSource = self
        eventsCollectionView.delegate = self

        teamsCollectionView.delegate = self
        teamsCollectionView.dataSource = self
    }

    func registerNibs() {
        let eventNib = UINib(nibName: "EventCVCell", bundle: nil)
        let resultNib = UINib(nibName: "ResultCVCell", bundle: nil)
        let teamNib = UINib(nibName: "TeamCVCell", bundle: nil)

        resultsCollectionView.register(resultNib, forCellWithReuseIdentifier: "resultCell")
        eventsCollectionView.register(eventNib, forCellWithReuseIdentifier: "eventCell")
        teamsCollectionView.register(teamNib, forCellWithReuseIdentifier: "teamsCell")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case eventsCollectionView:
            return 5
        case resultsCollectionView:
            return 10
        case teamsCollectionView:
            return 15
        default:
            return 1
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case eventsCollectionView:
                return CGSize(width: eventsCollectionView.frame.width-16, height: eventsCollectionView.frame.height - 20)
        case resultsCollectionView:
                return CGSize(width: resultsCollectionView.frame.width-16, height: resultsCollectionView.frame.height / 10)
        case teamsCollectionView:
                return CGSize(width: teamsCollectionView.frame.width / 3.33, height: teamsCollectionView.frame.height-20)
        default:
            return CGSize(width: 100, height: 100)
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case eventsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCVCell
            cell.nameLabel.text = "Event +"
            return cell
        case teamsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCVCell
            cell.teamLabel.text = "Team +"
            return cell
        case resultsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultCell", for: indexPath) as! ResultCVCell
            cell.resultLabel.text = "Result +"
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
            return cell
        }
        
    }
}
