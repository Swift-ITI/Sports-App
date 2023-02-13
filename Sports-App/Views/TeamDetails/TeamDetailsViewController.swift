//
//  TeamDetailsViewController.swift
//  Sports-App
//
//  Created by MESHO on 07/02/2023.
//

import UIKit
import SwiftUI
import Kingfisher

class TeamDetailsViewController: UIViewController {

    @IBOutlet var tableView_teamDetails: UITableView!
    @IBOutlet var stadiumName_label: UILabel!
    @IBOutlet var teamName_label: UILabel!
    @IBOutlet var stadium_Image: UIImageView!
    @IBOutlet var teamLogoImage: UIImageView!
    var players: [Player]?
    var team: Teams?
    var league_name: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let nib = UINib(nibName: "CustomTableCell", bundle: nil)
        tableView_teamDetails.register(nib, forCellReuseIdentifier: "leagueCell")
        //self.renderImage()
        teamName_label.text = team?.team_name
        stadiumName_label.text = self.league_name
        stadium_Image.image = UIImage(named: "stadium")
        teamLogoImage.kf.setImage(with: URL(string: team?.team_logo ?? ""))
        players = team?.players
        tableView_teamDetails.reloadData()
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissVC))
        swipe.direction = .down
        
        self.view.addGestureRecognizer(swipe)
        
    }
    @objc func dismissVC(){
        self.dismiss(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: Rendering
extension TeamDetailsViewController: UITableViewDelegate, UITableViewDataSource{
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! CustomTableCell
        cell.imgView.kf.setImage(with: URL(string: players?[indexPath.row].player_image ?? ""))
        cell.nameLabel.text = players?[indexPath.row].player_name
        cell.countryLabel.text = players?[indexPath.row].player_type
        cell.numberLabel.text = players?[indexPath.row].player_number
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Players"
    }
    
}

