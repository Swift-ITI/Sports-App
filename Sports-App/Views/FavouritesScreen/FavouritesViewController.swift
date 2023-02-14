//
//  FavouritesViewController.swift
//  Sports-App
//
//  Created by MESHO on 02/02/2023.
//

import CoreData
import Reachability
import UIKit

class FavouritesViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var likedLeagues: [NSManagedObject] = []
    var managedContext: NSManagedObjectContext!
    var coreDataManager: CoreDataManager?
    let reachability: Reachability = Reachability.forInternetConnection()
    var segueTemp: NSManagedObject?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        tableView.delegate = self
        tableView.dataSource = self
        coreDataManager = CoreDataManager.getInstance()
        likedLeagues = coreDataManager?.fetchData() ?? []
        let nib = UINib(nibName: "CustomTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "leagueCell")
        tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        // super.viewWillAppear(animated)

        likedLeagues = coreDataManager?.fetchData() ?? []
        tableView.reloadData()
    }
}

//MARK: Cells
extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedLeagues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! CustomTableCell

        let temp: NSManagedObject = likedLeagues[indexPath.row]
        cell.nameLabel.text = temp.value(forKey: "name") as? String
        cell.countryLabel.text = temp.value(forKey: "country") as? String
        cell.imgView.kf.setImage(with: URL(string: temp.value(forKey: "logo") as? String ?? ""))

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if reachability.isReachable() {
            let temp: NSManagedObject = likedLeagues[indexPath.row]
            segueTemp = temp
            performSegue(withIdentifier: "goToDetails", sender: self)
        } else {
            print("Network is not connected\n")
            showAlertNotConnected()
            tableView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let teamDetailsVC = segue.destination as? LeagueDetailsViewController

        teamDetailsVC?.sportId = segueTemp?.value(forKey: "sport") as? String
        teamDetailsVC?.leagueId = segueTemp?.value(forKey: "id") as? Int
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alert = UIAlertController(title: "Deleting From Favorites", message: "Are you sure ?", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: { [self] action in
                self.coreDataManager?.deleteLeagueFromFavourites(leagueId: self.likedLeagues[indexPath.row].value(forKey: "id") as! Int)
                self.likedLeagues.remove(at: indexPath.row)
                
                    tableView.deleteRows(at: [indexPath], with: .left)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        
                tableView.reloadData()
        } 
    }
}



//MARK: Alerts
extension FavouritesViewController{
    func showAlertNotConnected() {
        let alert = UIAlertController(title: "Not Connected!", message: "Please, Check the internet connection.", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        present(alert, animated: true, completion: nil)
    }
}
