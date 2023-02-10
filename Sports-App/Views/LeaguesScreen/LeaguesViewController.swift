
//
//  LeaguesViewController.swift
//  Sports-App
//
//  Created by Adham Samer on 02/02/2023.
//

import UIKit
import Kingfisher

class LeaguesViewController: UIViewController {

    @IBOutlet weak var leaguesTableView: UITableView!
        var leaguesArray: [League]?
        var leagueVM: ViewModel?
    var SportID: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leaguesTableView.delegate = self
        leaguesTableView.dataSource = self
//        navigationController?.setNavigationBarHidden(true, animated: true)
        let nib = UINib(nibName: "CustomTableCell", bundle: nil)
        leaguesTableView.register(nib, forCellReuseIdentifier: "leagueCell")
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()

        leagueVM = ViewModel()
        leagueVM?.getLeagues(endPoint: SportID ?? "football")
        leagueVM?.bindDataToVC = { () in
            self.renderView()
            indicator.stopAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        leaguesTableView.reloadData()
    }

}

extension LeaguesViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leaguesArray?.count ?? 20
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! CustomTableCell
        
        //cell.configureLeagueCell(league: leaguesArray?[indexPath.row] )
        
        cell.imgView?.kf.setImage(with: URL(string: (leaguesArray?[indexPath.row].league_logo) ?? "" ))
        cell.nameLabel.text = leaguesArray?[indexPath.row].league_name
        cell.countryLabel.text = leaguesArray?[indexPath.row].country_name
        cell.youtubeBtn.addTarget(self, action: #selector(goToYouTube), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetails", sender: self)
    }
    
}



extension LeaguesViewController {
    func renderView() {
        DispatchQueue.main.async {
            self.leaguesArray = self.leagueVM?.leagues ?? []
            self.leaguesTableView.reloadData()
        }
    }

    
    @objc func goToYouTube(){
        let youtubeID: String = ""
        if let youtubeURL = URL(string: "youtube://\(youtubeID)"),UIApplication.shared.canOpenURL(youtubeURL){
            UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
        }else{
            let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(youtubeID)")
            UIApplication.shared.open(youtubeURL!, options: [:], completionHandler: nil)
        }
    }
    
    
}
