//
//  ViewController.swift
//  Sports-App
//
//  Created by Adham Samer on 01/02/2023.
//

import Kingfisher
import UIKit
import Reachability

class MainController: UIViewController {
    @IBOutlet var SportsCollectionView: UICollectionView!
    var sports: [String]?
    var sportsAPI: [String]?
    var reachability:Reachability!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SportsCollectionView.dataSource = self
        SportsCollectionView.delegate = self
        sports = ["Football","Basketball","Cricket","Tennis","Ice Hockey","Baseball","American Football"]
        sportsAPI = ["football","basketball","cricket","tennis","hockey","baseball","american-football"]
        reachability = Reachability.forInternetConnection()
        
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        SportsCollectionView.register(nib, forCellWithReuseIdentifier: "cell")

        SportsCollectionView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        SportsCollectionView.reloadData()
    }
}

extension MainController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sports?.count ?? 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        
        cell.sportName.text = sports?[indexPath.row]
        cell.sportsImageView.image = UIImage(named: sports?[indexPath.row] ?? "")
        //cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (SportsCollectionView.frame.width / 2) - 8, height: SportsCollectionView.frame.height / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if reachability.isReachable(){
            let leaguesVC = UIStoryboard(name: "LeaguesStoryboard", bundle: nil).instantiateViewController(withIdentifier: "leaguesStoryboard") as! LeaguesViewController
            switch  sportsAPI?[indexPath.row]{
            case "hockey","baseball","american-football":
                showAlertNotConnected(Title: "On preparing Sport", Message: "Sorry for this issue, Hope a nice day for You")
            default:
                leaguesVC.sportID = sportsAPI?[indexPath.row] ?? ""
                navigationController?.pushViewController(leaguesVC, animated: true)
            }
            
        }else{
            showAlertNotConnected(Title: "Internet Connection is Unavailable!", Message: "Please Check the internet connection.")
        }
        //performSegue(withIdentifier: "goToLeagues", sender: self)
        //        let goto = UIStoryboardSegue(identifier: "Main", source: self, destination: leaguesVC) {
        //            leaguesVC.SportID = self.sportsAPI?[indexPath.row] ?? ""
        //        }
        //        goto.perform()
        //        performSegue(withIdentifier: goto, sender: self)
    }
    
    func showAlertNotConnected(Title: String, Message: String) {
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.actionSheet)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}


