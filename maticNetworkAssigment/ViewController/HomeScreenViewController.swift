//
//  HomeScreenViewController.swift
//  maticNetworkAssigment
//
//  Created by QLC on 04/08/19.
//  Copyright © 2019 Vinayak Tudayekar. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class HomeScreenViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate
{
    var bitcoinArray = ["$pac","0xbtc","2give","abt","act","actn","ada","add","adx ","ae","aeon","aeur","agi","agrs","aion","amb","amp","ant ","apex","appc"]
    var bitcoinImage = ["$pac.png","0xbtc.png","2give.png","abt.png","act.png","actn.png","ada.png","add.png","adx.png","ae.png","aeon.png","aeur.png","agi.png","agrs.png","aion.png","amb.png","amp.png","ant.png","apex.png","appc.png"]
    var detailBitArray = ["PAC","OXBTC","2GIVE","ABT","ACT","ACTN","ADA","ADD","ADX","AE","AEON","AEUR","AGI","AGRS","AION","AMB","AMP","ANT","APEX","APPC"]
    var tokenAmoutArray =   ["10.0","12","345","14","56","789","90","54","27","74","48","94","69","83.6","28","40.5","77","98","73","89"]
    
    @IBOutlet weak var showHashBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:-View life cycle methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
       
        var longPress = UILongPressGestureRecognizer(target: self, action: #selector(HomeScreenViewController.tapEdit(recognizer:)))
        longPress.minimumPressDuration = 1.0
        self.tableView.addGestureRecognizer(longPress)
        
        let nib = UINib(nibName: "TokenTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "TokenTableViewCell")
        
      //setupNavBar()
        // Do any additional setup after loading the view.
    }
    @objc func tapEdit(recognizer: UILongPressGestureRecognizer)
    {
        if recognizer.state == UIGestureRecognizer.State.began
        {
            let tapLocation = recognizer.location(in: self.tableView)
            if let tapIndexPath = self.tableView.indexPathForRow(at: tapLocation)
            {
                if let tappedCell = self.tableView.cellForRow(at: tapIndexPath) as? TokenTableViewCell {
                    
                    let imageAlert = ImageAlertPresenter.init(root: self, image: UIImage(named: bitcoinImage[tapIndexPath.row])! ,config: ImageAlertPresenterConfig(title: bitcoinArray[tapIndexPath.row], message: ""))
                    
                    imageAlert.delegate = self
                    imageAlert.present()
                    
                }
            }
        }
    }
   
   
    //MARK:tableview Datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return bitcoinArray.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TokenTableViewCell", for: indexPath) as! TokenTableViewCell
      
        cell.titleToken.text = bitcoinArray[indexPath.row]
        cell.titleSubtitle.text = detailBitArray[indexPath.row]
       cell.imageToken.image = UIImage(named: bitcoinImage[indexPath.row])
     
        cell.tokenAmount.text = tokenAmoutArray[indexPath.row]
        
      
        return cell
    }
    //tableView Delegate methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
       
        vw.backgroundColor = UIColor.lightGray
        let label = UILabel()
        label.text = "My Tokens"
        label.fontSize = 20
        label.frame = CGRect(x: 15, y:10, width: 100, height: 35)
        vw.addSubview(label)
        
        return vw
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 60.0
    }
    
 /*   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let imageAlert = ImageAlertPresenter.init(root: self, image: UIImage(named: bitcoinImage[indexPath.row])! ,config: ImageAlertPresenterConfig(title: bitcoinArray[indexPath.row], message: ""))
        
        imageAlert.delegate = self
        imageAlert.present()
       
       /* let alert = UIAlertController(title: "alert", message: "alertview", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "", style: .default, handler: nil))
        let image = UIImage(named: "test.jpg")
        alert.addImage(image: image!)
        self.present(alert, animated: true, completion: nil)
 */
    }
 */
    func myTableDelegate() {
        print("tapped")
        //modify your datasource here
    }

    
    
    
    

    @IBAction func showHashBtn(_ sender: Any) {
        
        // Create the alert controller
         let retrieveduserNamePassword: String? = KeychainWrapper.standard.string(forKey: "userNamePassword")
       
        
        let alertController = UIAlertController(title: "Hash", message: retrieveduserNamePassword, preferredStyle: .alert)
        
       
        let cancelAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
      
       
        alertController.addAction(cancelAction)
        var height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.25)
        alertController.view.addConstraint(height);
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    /* func setupNavBar() {
     
     
     self.navigationController?.navigationBar.prefersLargeTitles = true
     self.navigationController?.navigationBar.isTranslucent = false
     
     navigationController?.navigationBar.addSubview(showHashBtn)
     showHashBtn.tag = 1
     showHashBtn.frame = CGRect(x: self.view.frame.width, y: 15, width: 300, height: 20)
     
     let targetView = self.navigationController?.navigationBar
     
     let trailingContraint = NSLayoutConstraint(item: showHashBtn, attribute:
     .centerY, relatedBy: .lessThanOrEqual, toItem: targetView,
     attribute: .centerY, multiplier: 1.0, constant: -16)
     // let bottomConstraint = NSLayoutConstraint(item: showHashBtn, attribute: .bottom, relatedBy: .equal,
     //  toItem: targetView, attribute: .bottom, multiplier: 1.0, constant: -6)
     showHashBtn.translatesAutoresizingMaskIntoConstraints = false
     NSLayoutConstraint.activate([trailingContraint])
     
     }
     */

}
extension HomeScreenViewController: ImageAlertPresenterDelegate {
    func completed() {
        print("Completed")
    }
}
