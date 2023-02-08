//
//  TeamDetailsViewController.swift
//  Sports-App
//
//  Created by MESHO on 07/02/2023.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    @IBOutlet var tableView_teamDetails: UITableView!
    @IBOutlet var stadiumName_label: UILabel!
    @IBOutlet var teamName_label: UILabel!
    @IBOutlet var stadium_Image: UIImageView!
    @IBOutlet var teamLogoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "CustomTableCell", bundle: nil)
        tableView_teamDetails.register(nib, forCellReuseIdentifier: "leagueCell")
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

extension TeamDetailsViewController: UITableViewDelegate, UITableViewDataSource{
   
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Players"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    
    
}
