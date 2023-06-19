//
//  RepositoryDetailTableViewCell.swift
//  GitHubRepositories
//
//  Created by mihmouda on 16/06/2023.
//

import UIKit
import SDWebImage

/**
 A custom table view cell for displaying repository details.
 
 The `RepositoryDetailTableViewCell` class is a subclass of `RepositoryTableViewCell` and provides additional UI elements for displaying specific details of a repository, such as creation date, forks count, repository link, and programming language.
 */
class RepositoryDetailTableViewCell: RepositoryTableViewCell {
    
    /// The label displaying the creation date of the repository.
    @IBOutlet private weak var createdAtLabel: UILabel!
    
    /// The label displaying the forks count of the repository.
    @IBOutlet private weak var forksCountLabel: UILabel!
    
    /// The image view displaying the forks icon.
    @IBOutlet private weak var forksImageView: UIImageView!
    
    /// The text view displaying the repository link.
    @IBOutlet private weak var repoLinkTextView: UITextView!
    
    /// The label displaying the programming language of the repository.
    @IBOutlet private weak var languageLabel: UILabel!
    
    /// The image view displaying the programming language icon.
    @IBOutlet private weak var languageImageView: UIImageView!


    /**
     Performs initialization steps after the cell is loaded from the storyboard.
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configure repoLinkTextView
        self.repoLinkTextView.textContainer.maximumNumberOfLines = 1
        self.repoLinkTextView.textContainer.lineBreakMode = .byTruncatingTail
    }
    
    /**
     Configures the cell with the given representable and index path.
     
     - Parameters:
        - representable: The representable object containing the data for the cell.
        - cellIndex: The index path of the cell in the table view.
     */
    override func setup(representable: RepositoryTableViewCellRepresentable, cellIndex: IndexPath) {
        
        super.setup(representable: representable, cellIndex: cellIndex)
        
        // Set created date
        if let createdDate = representable.createdDate {
            self.createdAtLabel.text = DateUtils.getDateStringFrom(createdDate, formatter: "MMM d, yyyy")
        }
        
        // Set forks count
        self.forksCountLabel.text = representable.forksCount.description
        
        // Set repository link
        self.repoLinkTextView.text = representable.urlPath
        
        // Set programming language
        if let language = representable.language {
            self.languageLabel.text = language
            self.languageImageView.isHidden = false
        } else {
            self.languageLabel.isHidden = true
            self.languageImageView.isHidden = true
        }
    }
    
    /**
     Returns the reuse identifier for the cell.
     
     - Returns: The reuse identifier for the cell.
     */
    override class func getReuseIdentifier() -> String {
        return "RepositoryDetailTableViewCell"
    }

    /**
     Returns the height of the cell.
     
     - Returns: The height of the cell.
     */
    override class func getCellHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
}

