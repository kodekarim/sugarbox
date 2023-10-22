//
//  DetailViewController.swift
//  SugarBox
//
//  Created by abdul karim on 22/10/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var lDescriptionLabel: UILabel!
    @IBOutlet weak var bWatchButton: UIButton!
    @IBOutlet weak var lContentRatings: UILabel!
    @IBOutlet weak var ivImageView: UIImageView!
    
    var viewModel:DetailViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    fileprivate func configureView() {
        guard let imageUrl = getImageLink(assets: viewModel?.content?.assets) else  {
            return
        }
        ivImageView.setImage(fromURL: imageUrl)
        
        let duration = viewModel?.content?.metaData?.duration ?? 0
        let ageRating = viewModel?.content?.metaData?.ageRating ?? "-"
        lContentRatings.text = "\(duration)" + MIN + EMPTY_SPACE + "|" + EMPTY_SPACE + RATING + ":" + ageRating
        
        lDescriptionLabel.text = viewModel?.content?.description ?? ""
    }

}
