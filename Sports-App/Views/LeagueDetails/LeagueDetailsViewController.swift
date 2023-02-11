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
    
    var teams:[Team] = []
    var events:[Event] = []
    var results:[Result] = []
    var leagueId:Int?
    var leagueVM = LeagueDetailsVM()
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
        
        
        leagueVM.getTeams(leagueId: leagueId ?? 177)
        leagueVM.getResults(leagueId: leagueId ?? 177)
        leagueVM.getEvents(leagueId: leagueId ?? 177)
        
        leagueVM.bindTeamsToLeagueDVC = { () in
            self.renderTeams()
        }
        leagueVM.bindResultsToLeagueDVC = { () in
            self.renderResults()
        }
        leagueVM.bindEventsToLeagueDVC = { () in
            self.renderEvents()
        }
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
            return self.events.count
//            return 5
        case resultsCollectionView:
                return self.results.count
//                return 10
        case teamsCollectionView:
                return self.teams.count
//                return 10
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
            return CGSize(width: eventsCollectionView.frame.width - 16, height: eventsCollectionView.frame.height - 20)
        case resultsCollectionView:
            return CGSize(width: resultsCollectionView.frame.width - 16, height: resultsCollectionView.frame.height / 10)
        case teamsCollectionView:
                return CGSize(width: teamsCollectionView.frame.width / 3, height: teamsCollectionView.frame.height - 20)
        default:
            return CGSize(width: 100, height: 100)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case eventsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCVCell
                cell.awayImageE.kf.setImage(with: URL(string: events[indexPath.row].away_team_logo ?? ""))
                cell.homeImageE.kf.setImage(with: URL(string: events[indexPath.row].home_team_logo ?? ""))
                cell.dateLabel.text = events[indexPath.row].event_date
                cell.timeLabel.text = events[indexPath.row].event_time
//            cell.awayImageE.image = UIImage(named: "SplashLogo")
//            cell.homeImageE.image = UIImage(named: "SplashLogo")
            return cell
        case teamsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCVCell
                cell.teamLabel.text = teams[indexPath.row].team_name
                cell.teamLogo.kf.setImage(with: URL(string: teams[indexPath.row].team_logo ?? ""))
//                cell.teamLabel.text = "Team +"
//                cell.teamLogo.image = UIImage(named: "SplashLogo")
                return cell
        case resultsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultCell", for: indexPath) as! ResultCVCell
                cell.awayImage.kf.setImage(with:URL(string: results[indexPath.row].away_team_logo ?? "https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-circle-icon-vectors-png-image_1737851.jpg"))
                cell.homeImage.kf.setImage(with:URL(string: results[indexPath.row].home_team_logo ?? "https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-circle-icon-vectors-png-image_1737851.jpg"))
                cell.dateLabel.text = results[indexPath.row].event_date
                cell.resultLabel.text = results[indexPath.row].event_final_result
                cell.timeLabel.text = results[indexPath.row].event_time
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case teamsCollectionView:
            performSegue(withIdentifier: "gotoTeamDetails", sender: self)
        default:
            print("hii")
        }
    }
}


extension LeagueDetailsViewController{
    func renderTeams(){
        DispatchQueue.main.async {
            self.teams = self.leagueVM.teams
            self.teamsCollectionView.reloadData()
        }
    }
    func renderResults(){
        DispatchQueue.main.async {
            self.results = self.leagueVM.results
            self.resultsCollectionView.reloadData()
        }
    }
    func renderEvents(){
        DispatchQueue.main.async {
            self.events = self.leagueVM.events
            self.eventsCollectionView.reloadData()
        }
    }
}
