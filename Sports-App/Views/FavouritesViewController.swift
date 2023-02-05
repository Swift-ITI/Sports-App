//
//  FavouritesViewController.swift
//  Sports-App
//
//  Created by MESHO on 02/02/2023.
//

import UIKit

class FavouritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: "cell")
        let nib = UINib(nibName: "CustomTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "leagueCell")
    }

}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource{
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! CustomTableCell
//        cell.favImageView.image = UIImage(named: "thor")
//        cell.favLabel.text = "Premiere League: Soccer"
        cell.imgView.image = UIImage(named: "SplashLogo")
        cell.nameLabel.text = "Premiere League: Soccerrrrrrrrrr"
        cell.countryLabel.text = "England"
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Favorites"
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    
    
}
