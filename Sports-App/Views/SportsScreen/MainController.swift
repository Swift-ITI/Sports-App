//
//  ViewController.swift
//  Sports-App
//
//  Created by Adham Samer on 01/02/2023.
//

import UIKit

class MainController: UIViewController{

    @IBOutlet weak var SportsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.SportsCollectionView.dataSource = self
        self.SportsCollectionView.delegate = self
        
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        SportsCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
    }


}



extension MainController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell

        //cell.sportsImageView.image = UIImage(named: "thor")
        cell.sportName.text = "Football"
        
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
