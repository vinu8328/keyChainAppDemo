


import UIKit

class TokenTableViewCell: UITableViewCell {

   
    @IBOutlet weak var imageToken: UIImageView!
    
    @IBOutlet weak var tokenAmount: UILabel!
    
    @IBOutlet weak var titleToken: UILabel!
    
    @IBOutlet weak var titleSubtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    
}

