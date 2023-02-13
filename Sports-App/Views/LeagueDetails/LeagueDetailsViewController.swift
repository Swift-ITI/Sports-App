//
//  LeagueDetailsViewController.swift
//  Sports-App
//
//  Created by Adham Samer on 06/02/2023.
//

import Foundation
import UIKit
import CoreData

class LeagueDetailsViewController: UIViewController {
    @IBOutlet var resultsCollectionView: UICollectionView!
    @IBOutlet var teamsCollectionView: UICollectionView!
    @IBOutlet var eventsCollectionView: UICollectionView!
    @IBOutlet weak var favorite_btn: UIBarButtonItem!
    
    var teams:[Teams] = []
    var events:[Event] = []
    var results:[Result] = []
    var leagueId:Int?
    var sportId:String?
    var league_country: String?
    var leagueVM = LeagueDetailsVM()
    //var isLiked = UserDefaults.standard
    var isLiked = false
    var currentLeague: League = League()
    var likedLeagues: [NSManagedObject]=[]
    var managedContext: NSManagedObjectContext!
    var rightButton:UIBarButtonItem?
    
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
        
        //MARK: Fav Btn
         rightButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(saveToCoreData))
        navigationItem.rightBarButtonItem = rightButton
        
        //MARK: CoreData
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        likedLeagues = fetchDataFromCore()
        
        //MARK: FetchData
        leagueVM.getTeams(leagueId: leagueId ?? 177,sportId:sportId ?? "football")
        leagueVM.getResults(leagueId: leagueId ?? 177,sportId:sportId ?? "football")
        leagueVM.getEvents(leagueId: leagueId ?? 177,sportId:sportId ?? "football")
        
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
        self.checkFavouriteLeague()
    }
    
    @objc func saveToCoreData(){
        
        let entity = NSEntityDescription.entity(forEntityName: "Leagues", in: managedContext)
        let league = NSManagedObject(entity: entity!, insertInto: managedContext)
        league.setValue(leagueId, forKey: "id")
        league.setValue(currentLeague.league_name, forKey: "name")
        league.setValue(currentLeague.country_name, forKey: "country")
        league.setValue(currentLeague.league_logo, forKey: "logo")
        do{
            try managedContext.save()
            print("Saved")
        }catch{
            print(String(describing: error))
        }
        rightButton?.image = UIImage(systemName: "heart.fill")
        showToastMessage(message: "Added !", color: .blue)
            
    }
    
    
}


extension LeagueDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //MARK: Delegates
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
            cell.awayImage.kf.setImage(with: URL(string: results[indexPath.row].away_team_logo ?? "https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-circle-icon-vectors-png-image_1737851.jpg"))
            cell.homeImage.kf.setImage(with: URL(string: results[indexPath.row].home_team_logo ?? "https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-circle-icon-vectors-png-image_1737851.jpg"))
            cell.dateLabel.text = results[indexPath.row].event_date
            cell.resultLabel.text = results[indexPath.row].event_final_result
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

//            navigationController?.pushViewController(teamDetailsVC, animated: true)
            teamDetailsVC.modalPresentationStyle = .fullScreen
            present(teamDetailsVC, animated: true)
//            performSegue(withIdentifier: "gotoTeamDetails", sender: self)
        default:
            print("hii")
        }
    }
}

    //MARK: Rendering

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
        self.viewDidLoad()
        resultsCollectionView.reloadData()
        teamsCollectionView.reloadData()
        eventsCollectionView.reloadData()
    }
}

extension LeagueDetailsViewController{
    
    //MARK: CoreData
    func fetchDataFromCore() -> [NSManagedObject] {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Leagues")
        do{
            self.likedLeagues = try managedContext.fetch(fetchRequest)
        }catch let error{
            print(error.localizedDescription)
        }
        return self.likedLeagues
        
    }
    
    func checkFavouriteLeague() {
        for league in likedLeagues{
            if league.value(forKey: "id") as? Int == self.leagueId{
                rightButton?.image = UIImage(systemName: "heart.fill")
                print("yes")
            }else{
                print("No")
            }
        }
        
    }
    
    func showToastMessage(message: String, color: UIColor) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.width/2-120, y: self.view.frame.height-100, width: 260, height: 30))
        
        toastLabel.textAlignment = .center
        toastLabel.backgroundColor = color
        toastLabel.textColor = .black
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        toastLabel.text = message
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 3.0, delay: 1.0, options: .curveEaseIn, animations: {
            toastLabel.alpha = 0.0
        }) { (isCompleted) in
            toastLabel.removeFromSuperview()
        }
    }
}
