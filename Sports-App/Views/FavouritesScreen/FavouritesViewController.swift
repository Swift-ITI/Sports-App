//
//  FavouritesViewController.swift
//  Sports-App
//
//  Created by MESHO on 02/02/2023.
//

import UIKit
import CoreData
import Reachability

class FavouritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var likedLeagues: [NSManagedObject] = []
    var managedContext: NSManagedObjectContext!
    
    let reachability: Reachability = Reachability.forInternetConnection()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
        let nib = UINib(nibName: "CustomTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "leagueCell")
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(animated)
        
        //likedLeagues = DBManager.fetchData(appDelegate: appDelegate)
        tableView.reloadData()
    }

}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource{
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! CustomTableCell

        let temp: NSManagedObject = fetchData()[indexPath.row]
        cell.nameLabel.text = temp.value(forKey: "name") as? String
        cell.countryLabel.text = temp.value(forKey: "country") as? String
        cell.imgView.kf.setImage(with: URL(string: temp.value(forKey: "logo") as? String ?? ""))
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDetailsVC = UIStoryboard(name: "LeagueDetailsStoryboard", bundle: nil).instantiateViewController(withIdentifier: "leagueDetails") as! LeagueDetailsViewController
        if reachability.isReachable(){
            let temp: NSManagedObject = likedLeagues[indexPath.row]
            leagueDetailsVC.currentLeague.league_key = temp.value(forKey: "id") as? Int ?? 0
            navigationController?.pushViewController(leagueDetailsVC, animated: true)
        }else{
            print("Network is not connected\n")
            self.showAlertNotConnected()
            tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
                managedContext.delete(likedLeagues[indexPath.row])
                likedLeagues.remove(at: indexPath.row)
                do{
                    try managedContext.save()
                }catch let error{
                    print(error.localizedDescription)
                }
            
                tableView.deleteRows(at: [indexPath], with: .left)
                tableView.reloadData()
            
        } 
    }
    
    
}

extension FavouritesViewController{
    func showAlertNotConnected() {
        let alert = UIAlertController(title: "Not Connected!", message: "Please, Check the internet connection.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func fetchData() -> [NSManagedObject] {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Leagues")
        do{
            self.likedLeagues = try managedContext.fetch(fetchRequest)
        }catch let error{
            print(error.localizedDescription)
        }
        return self.likedLeagues
        
    }
    
}
