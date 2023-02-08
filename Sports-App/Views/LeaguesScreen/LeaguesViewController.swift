
//
//  LeaguesViewController.swift
//  Sports-App
//
//  Created by Adham Samer on 02/02/2023.
//

import UIKit

class LeaguesViewController: UIViewController {

    @IBOutlet weak var newLeagueTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newLeagueTV.delegate = self
        newLeagueTV.dataSource = self
//        navigationController?.setNavigationBarHidden(true, animated: true)
        let nib = UINib(nibName: "CustomTableCell", bundle: nil)
        newLeagueTV.register(nib, forCellReuseIdentifier: "leagueCell")
        // Do any additional setup after loading the view.
    }
    

}

extension LeaguesViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! CustomTableCell
        cell.imgView.image = UIImage(named: "SplashLogo")
        cell.nameLabel.text = "Premiere League: Soccerr"
        cell.countryLabel.text = "England"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetails", sender: self)
    }
}
