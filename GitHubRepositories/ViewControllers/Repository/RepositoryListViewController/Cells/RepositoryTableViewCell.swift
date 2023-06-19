//
//  RepositoryTableViewCell.swift
//  GitHubRepositories
//
//  Created by mihmouda on 15/06/2023.
//

import UIKit
import SDWebImage

/// A table view cell used to display repository information.
class RepositoryTableViewCell: UITableViewCell {
    
    /// The label for displaying the owner's name.
    @IBOutlet private weak var ownerNameLabel: UILabel!
    
    /// The image view for displaying the owner's avatar.
    @IBOutlet private weak var ownerAvatarImageView: UIImageView!
    
    /// The label for displaying the repository's name.
    @IBOutlet private weak var nameLabel: UILabel!
    
    /// The label for displaying the repository's description.
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    /// The label for displaying the number of stars for the repository.
    @IBOutlet private weak var starsCountLabel: UILabel!
    
    /// The image view for displaying the star icon.
    @IBOutlet private weak var starsImageView: UIImageView!

    /// The delegate object for handling cell actions.
    weak var delegate: RepositoryTableViewCellDelegate?
    
    /// The index path of the cell in the table view.
    private var cellIndex: IndexPath!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configure cell appearance and behavior when it is awakened from nib.
        
        // Set the selection style of the cell to none.
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        
        // Configure the avatar image view.
        self.ownerAvatarImageView.layer.cornerRadius = 20.0
        self.ownerAvatarImageView.clipsToBounds = true
        self.ownerAvatarImageView.layer.borderWidth = 1
        self.ownerAvatarImageView.layer.borderColor = UIColor.gray.cgColor
        
        // Set the background configuration based on the iOS version.
        if #available(iOS 14.0, *) {
            self.backgroundConfiguration = UIBackgroundConfiguration.clear()
        } else {
            self.backgroundColor = UIColor.clear
        }
        
        // Add a tap gesture recognizer to the star image view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(didClickFavoriteImage))
        self.starsImageView.isUserInteractionEnabled = true
        self.starsImageView.addGestureRecognizer(tap)
        self.starsImageView.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
    }
    
    /// Configures the cell with the provided representable data and index path.
    ///
    /// - Parameters:
    ///   - representable: The representable object containing repository data.
    ///   - cellIndex: The index path of the cell in the table view.
    func setup(representable: RepositoryTableViewCellRepresentable, cellIndex: IndexPath) {
        self.cellIndex = cellIndex
        
        // Set the owner's name label.
        self.ownerNameLabel.text = representable.ownerName
        
        // Set the repository's name label.
        self.nameLabel.text = representable.name
        
        // Set the repository's description label.
        self.descriptionLabel.text = representable.description
        
        // Set the number of stars label.
        self.starsCountLabel.text = representable.starsCount.description
        
        // Set the tint color of the star image view based on whether the repository is marked as a favorite.
        if representable.isFavorite {
            self.starsImageView.tintColor = .systemOrange
        } else {
            self.starsImageView.tintColor = .systemGray
        }
        
        // Set the activity indicator style for the owner's avatar image view.
        self.ownerAvatarImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
        // Load the owner's avatar image from the provided URL.
        if let ownerAvatar = representable.ownerAvatar, let url = URL(string: ownerAvatar) {
            self.ownerAvatarImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "no_avatar"))
        }
    }
    
    /// Handles the tap gesture on the favorite image view and notifies the delegate.
    ///
    /// - Parameter sender: The object that triggered the action.
    @IBAction func didClickFavoriteImage(_ sender: Any) {
        self.delegate?.repositoryTableViewCellDidClickFavoriteImage(at: self.cellIndex)
    }

    /// Returns the reuse identifier for the repository table view cell.
    ///
    /// - Returns: The reuse identifier string.
    class func getReuseIdentifier() -> String {
        return "RepositoryTableViewCell"
    }

    /// Returns the height of the repository table view cell.
    ///
    /// - Returns: The height value.
    class func getCellHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
}

/// The delegate protocol for handling actions performed in the repository table view cell.
protocol RepositoryTableViewCellDelegate: NSObjectProtocol {
    
    /// Notifies the delegate that the favorite image was clicked at the specified index path.
    ///
    /// - Parameter indexPath: The index path of the cell in the table view.
    func repositoryTableViewCellDidClickFavoriteImage(at indexPath: IndexPath)
}
