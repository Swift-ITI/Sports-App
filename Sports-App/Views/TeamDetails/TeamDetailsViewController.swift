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
    //any sport
    var players: [Player]?
    var team: Teams?
    //tennis
    var tennisPlayer: TennisPlayers?
    var stats: [Stats]?
    var sportID: String?
    var league_name: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let nib = UINib(nibName: "CustomTableCell", bundle: nil)
        tableView_teamDetails.register(nib, forCellReuseIdentifier: "leagueCell")
        //self.renderImage()
        switch self.sportID {
        case "tennis":
            teamName_label.text = tennisPlayer?.player_name
            stadiumName_label.text = self.league_name
            stadium_Image.image = UIImage(named: "stadium")
            teamLogoImage.kf.setImage(with: URL(string: tennisPlayer?.player_logo ?? ""))
            stats = tennisPlayer?.stats
        default:
            teamName_label.text = team?.team_name
            stadiumName_label.text = self.league_name
            stadium_Image.image = UIImage(named: "stadium")
            teamLogoImage.kf.setImage(with: URL(string: team?.team_logo ?? ""))
            players = team?.players
        }
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
        switch self.sportID {
        case "tennis":
            return stats?.count ?? 10
        default:
            return players?.count ?? 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! CustomTableCell
        switch self.sportID {
        case "tennis":
            cell.imgView.kf.setImage(with: URL(string: tennisPlayer?.player_logo ?? ""))
            cell.nameLabel.text = stats?[indexPath.row].season
            cell.countryLabel.text = stats?[indexPath.row].type
            cell.numberLabel.text = stats?[indexPath.row].rank
        default:
            cell.imgView.kf.setImage(with: URL(string: players?[indexPath.row].player_image ?? ""))
            cell.nameLabel.text = players?[indexPath.row].player_name
            cell.countryLabel.text = players?[indexPath.row].player_type
            cell.numberLabel.text = players?[indexPath.row].player_number
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch self.sportID {
        case "tennis":
            return "Statistics"
        default:
            return "Players"
        }
    }
    
}

