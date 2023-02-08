//
//  ViewController.swift
//  Sports-App
//
//  Created by Adham Samer on 01/02/2023.
//

import Kingfisher
import UIKit

class MainController: UIViewController {
    @IBOutlet var SportsCollectionView: UICollectionView!
    var sportsArray: [Sport] = []
//    var sportsImages: [String] = []
    var sportVM: SportVM?
    override func viewDidLoad() {
        super.viewDidLoad()
//        sportsImages = ["Football","Tennis","Basketball","Ice Hockey","Volleyball","Handball"]
        SportsCollectionView.dataSource = self
        SportsCollectionView.delegate = self

        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        SportsCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
        sportVM = SportVM()
        sportVM?.getSports()
        sportVM?.bindDataToSportVC = { () in
            self.renderView()
        }
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
        sportsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell

        cell.sportName.text = sportsArray[indexPath.row].name
//        cell.sportsImageView.image = UIImage(named: sportsImages[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (SportsCollectionView.frame.width / 2) - 8, height: SportsCollectionView.frame.height / 5)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let leagueSB = UIStoryboard(name: "LeaguesStoryboard", bundle: nil)
//        let leaguesVC = leagueSB.instantiateViewController(withIdentifier: "leaguesStoryboard") as! LeaguesViewController
//        self.navigationController?.pushViewController(leaguesVC, animated: true)
        performSegue(withIdentifier: "goToLeagues", sender: self)
    }
}

extension MainController {
    func renderView() {
        DispatchQueue.main.async {
            self.sportsArray = self.sportVM?.sports ?? []
            self.SportsCollectionView.reloadData()
        }
    }
}
