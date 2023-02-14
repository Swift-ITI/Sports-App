
//
//  LeaguesViewController.swift
//  Sports-App
//
//  Created by Adham Samer on 02/02/2023.
//

import Kingfisher
import UIKit

class LeaguesViewController: UIViewController {
    @IBOutlet var leaguesTableView: UITableView! {
        didSet{
            leaguesTableView.delegate = self
            leaguesTableView.dataSource = self
        }
    }
    var leaguesArray: [League]?
    var leagueVM: LeaguesVM?
    var sportID: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "CustomTableCell", bundle: nil)
        leaguesTableView.register(nib, forCellReuseIdentifier: "leagueCell")

        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()

        leagueVM = LeaguesVM()
        leagueVM?.getLeagues(endPoint: sportID ?? "football")
        leagueVM?.bindLeaguesToVC = { () in
            self.renderView()
            indicator.stopAnimating()
            
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        leaguesTableView.reloadData()
    }
}

extension LeaguesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leaguesArray?.count ?? 20
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! CustomTableCell
        switch self.sportID {
        case "cricket":
            cell.imgView?.kf.setImage(with: URL(string: (leaguesArray?[indexPath.row].league_logo) ?? ""))
            cell.nameLabel.text = leaguesArray?[indexPath.row].league_name
            cell.countryLabel.text = leaguesArray?[indexPath.row].league_year
        default:
            cell.imgView?.kf.setImage(with: URL(string: (leaguesArray?[indexPath.row].league_logo) ?? ""))
            cell.nameLabel.text = leaguesArray?[indexPath.row].league_name
            cell.countryLabel.text = leaguesArray?[indexPath.row].country_name
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDetailsVC = UIStoryboard(name: "LeagueDetailsStoryboard", bundle: nil).instantiateViewController(withIdentifier: "leagueDetails") as! LeagueDetailsViewController
        leagueDetailsVC.currentLeague = (leaguesArray?[indexPath.row])!
        leagueDetailsVC.leagueId = leaguesArray?[indexPath.row].league_key
        leagueDetailsVC.league_country = leaguesArray?[indexPath.row].country_name
        leagueDetailsVC.sportId = self.sportID
        navigationController?.pushViewController(leagueDetailsVC, animated: true)
//        leagueDetailsVC.modalPresentationStyle = .fullScreen
//        self.present(leagueDetailsVC, animated: true)
//        performSegue(withIdentifier: "goToDetails", sender: self)
    }
}

extension LeaguesViewController {
    func renderView() {
        DispatchQueue.main.async {
            self.leaguesArray = self.leagueVM?.leagues ?? []
            self.leaguesTableView.reloadData()
        }
    }
}
