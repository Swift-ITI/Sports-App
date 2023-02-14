//
//  LeagueDetailsViewController.swift
//  Sports-App
//
//  Created by Adham Samer on 06/02/2023.
//

import CoreData
import Foundation
import UIKit

class LeagueDetailsViewController: UIViewController {
    @IBOutlet var resultsCollectionView: UICollectionView!
    @IBOutlet var teamsCollectionView: UICollectionView!
    @IBOutlet var eventsCollectionView: UICollectionView!
    @IBOutlet var favorite_btn: UIBarButtonItem!

    var teams: [Teams] = []
    var events: [Event] = []
    var results: [Result] = []
    var leagueId: Int?
    var sportId: String?
    var league_country: String?
    var leagueVM = LeagueDetailsVM()
    // var isLiked = UserDefaults.standard
    var isLiked = false
    var currentLeague = League()
    var likedLeagues: [NSManagedObject] = []
    var managedContext: NSManagedObjectContext!
    var rightButton: UIBarButtonItem?
    var coreDataObject: CoreDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()

        // MARK: RegisterCells

        let eventNib = UINib(nibName: "EventCVCell", bundle: nil)
        let resultNib = UINib(nibName: "ResultCVCell", bundle: nil)
        let teamNib = UINib(nibName: "TeamCVCell", bundle: nil)
        resultsCollectionView.register(resultNib, forCellWithReuseIdentifier: "resultCell")
        eventsCollectionView.register(eventNib, forCellWithReuseIdentifier: "eventCell")
        teamsCollectionView.register(teamNib, forCellWithReuseIdentifier: "teamCell")

        // MARK: Fav Btn

        rightButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(saveToCoreData))
        navigationItem.rightBarButtonItem = rightButton

        // MARK: CoreData


        coreDataObject = CoreDataManager.getInstance()
        likedLeagues = coreDataObject?.fetchData() ?? []

        // MARK: FetchData

        leagueVM.getTeams(leagueId: leagueId ?? 177, sportId: sportId ?? "football")
        leagueVM.getResults(leagueId: leagueId ?? 177, sportId: sportId ?? "football")
        leagueVM.getEvents(leagueId: leagueId ?? 177, sportId: sportId ?? "football")

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
        checkFavouriteLeague()
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissVC))
        swipe.direction = .down

        view.addGestureRecognizer(swipe)
    }

    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    //MARK: Save_Btn
    @objc func saveToCoreData() {
        if rightButton?.image == UIImage(systemName: "heart.fill") {
            showAlert(Title: "Deleting From Favorites", Message: "Are you sure ?")
        } else {
            coreDataObject?.saveData(leagueC: currentLeague, sportId: sportId ?? "")
            rightButton?.image = UIImage(systemName: "heart.fill")
            showToastMessage(message: "Added !", color: .systemBlue)
        }
        viewWillAppear(false)
    }
}

extension LeagueDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: Delegates

    func setDelegates() {
        resultsCollectionView.dataSource = self
        resultsCollectionView.delegate = self

        eventsCollectionView.dataSource = self
        eventsCollectionView.delegate = self

        teamsCollectionView.delegate = self
        teamsCollectionView.dataSource = self
    }

    // MARK: Number of Cells

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case eventsCollectionView:
            return events.count
//            return 5
        case resultsCollectionView:
            return results.count
//                return 10
        case teamsCollectionView:
            return teams.count
//                return 10
        default:
            return 1
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    // MARK: Dimensions

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

    // MARK: Cells

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case eventsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCVCell
            switch sportId {
            case "basketball", "cricket":
                cell.awayImageE.kf.setImage(with: URL(string: events[indexPath.row].event_away_team_logo ?? "https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-circle-icon-vectors-png-image_1737851.jpg"))
                cell.homeImageE.kf.setImage(with: URL(string: events[indexPath.row].event_home_team_logo ?? "https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-circle-icon-vectors-png-image_1737851.jpg"))
            default:
                cell.awayImageE.kf.setImage(with: URL(string: events[indexPath.row].away_team_logo ?? "https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-circle-icon-vectors-png-image_1737851.jpg"))
                cell.homeImageE.kf.setImage(with: URL(string: events[indexPath.row].home_team_logo ?? "https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-circle-icon-vectors-png-image_1737851.jpg"))
            }
            switch sportId {
            case "cricket":
                cell.dateLabel.text = events[indexPath.row].event_date_start
            default:
                cell.dateLabel.text = events[indexPath.row].event_date
            }
            cell.timeLabel.text = events[indexPath.row].event_time
//            cell.awayImageE.image = UIImage(named: "SplashLogo")
//            cell.homeImageE.image = UIImage(named: "SplashLogo")
            return cell
        case teamsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCVCell
            cell.teamLabel.text = teams[indexPath.row].team_name
            cell.teamLogo.kf.setImage(with: URL(string: teams[indexPath.row].team_logo ?? "https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-circle-icon-vectors-png-image_1737851.jpg"))
//                cell.teamLabel.text = "Team +"
//                cell.teamLogo.image = UIImage(named: "SplashLogo")
            return cell
        case resultsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultCell", for: indexPath) as! ResultCVCell
            switch sportId {
            case "basketball", "cricket":
                cell.awayImage.kf.setImage(with: URL(string: results[indexPath.row].event_away_team_logo ?? "https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-circle-icon-vectors-png-image_1737851.jpg"))
                cell.homeImage.kf.setImage(with: URL(string: results[indexPath.row].event_home_team_logo ?? "https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-circle-icon-vectors-png-image_1737851.jpg"))
            default:
                cell.awayImage.kf.setImage(with: URL(string: results[indexPath.row].away_team_logo ?? "https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-circle-icon-vectors-png-image_1737851.jpg"))
                cell.homeImage.kf.setImage(with: URL(string: results[indexPath.row].home_team_logo ?? "https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-circle-icon-vectors-png-image_1737851.jpg"))
            }
            switch sportId {
            case "cricket":
                cell.dateLabel.text = results[indexPath.row].event_date_stop
                cell.resultLabel.text = (results[indexPath.row].event_home_final_result ?? "") + "\n" + (results[indexPath.row].event_away_final_result ?? "")
            default:
                cell.dateLabel.text = results[indexPath.row].event_date
                cell.resultLabel.text = results[indexPath.row].event_final_result
            }
            cell.timeLabel.text = results[indexPath.row].event_time
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
            return cell
        }
    }

    // MARK: Navigation

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case teamsCollectionView:
            let teamDetailsVC = UIStoryboard(name: "TeamDetailsStoryboard", bundle: nil).instantiateViewController(withIdentifier: "teamDetails") as! TeamDetailsViewController
            teamDetailsVC.team = teams[indexPath.row]
            teamDetailsVC.league_name = league_country

            teamDetailsVC.modalPresentationStyle = .fullScreen
            present(teamDetailsVC, animated: true)

        default:
            print("hii")
        }
    }
}

// MARK: Rendering

extension LeagueDetailsViewController {
    func renderTeams() {
        DispatchQueue.main.async {
            self.teams = self.leagueVM.teams
            self.teamsCollectionView.reloadData()
        }
    }

    func renderResults() {
        DispatchQueue.main.async {
            self.results = self.leagueVM.results
            self.resultsCollectionView.reloadData()
        }
    }

    func renderEvents() {
        DispatchQueue.main.async {
            self.events = self.leagueVM.events
            self.eventsCollectionView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
        resultsCollectionView.reloadData()
        teamsCollectionView.reloadData()
        eventsCollectionView.reloadData()
    }

    func showToastMessage(message: String, color: UIColor) {
        let toastLabel = UILabel(frame: CGRect(x: view.frame.width / 2 - 120, y: view.frame.height - 130, width: 260, height: 30))

        toastLabel.textAlignment = .center
        toastLabel.backgroundColor = color
        toastLabel.textColor = .black
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        toastLabel.text = message
        view.addSubview(toastLabel)

        UIView.animate(withDuration: 3.0, delay: 1.0, options: .curveEaseIn, animations: {
            toastLabel.alpha = 0.0
        }) { _ in
            toastLabel.removeFromSuperview()
        }
    }
}

extension LeagueDetailsViewController {
    // MARK: CoreData

    func checkFavouriteLeague() {
        for league in likedLeagues {
            if league.value(forKey: "id") as? Int == leagueId {
                rightButton?.image = UIImage(systemName: "heart.fill")
                print("yes")
            } else {
                print("No")
            }
        }
    }
    
    // MARK: Alert
    func showAlert(Title: String, Message: String) {
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: { [self] action in
            self.coreDataObject?.deleteLeagueFromFavourites(leagueId: self.leagueId ?? 0)
            self.rightButton?.image = UIImage(systemName: "heart")
            showToastMessage(message: "Removed !", color: .red)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
