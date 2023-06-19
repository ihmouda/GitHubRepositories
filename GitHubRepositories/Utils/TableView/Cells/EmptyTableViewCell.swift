//
//  EmptyTableViewCell.swift
//  GitHubRepositories
//
//  Created by mihmouda on 17/06/2023.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {
 
    private var emptyImageView: UIImageView!
    
    /**
     Initializer method
     */
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Setup view
        self.setupView()
    }
    
    /**
     Initializer method
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Setup view
        self.setupView()
    }
    
    // MARK: - Build view
    
    /**
     Sets up the view
     */
    private func setupView() {
        
        // Create empty image view
        self.emptyImageView = UIImageView()
        self.emptyImageView.contentMode = .scaleAspectFit
        
        // Add empty image view
        self.contentView.addSubview(self.emptyImageView)
        
        self.emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        self.emptyImageView.heightAnchor.constraint(equalTo: self.emptyImageView.widthAnchor, multiplier: 1).isActive = true
        self.emptyImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.emptyImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        
        // Set cell selection style
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    // MARK: - Setup cell
    
    /**
     Setup cell
     - Parameter attributedString : The attributed string to set on the cell label
     - Parameter image : The image to set for the empty cell
     */
    func setup(image : UIImage? = nil) {
        
        if image != nil {
            self.emptyImageView?.image = image
        }
    }
    
    // MARK: - Class methods
    
    /**
     Get cell reuse identifier
     - Returns : Cell reuse identifier
     */
    class func getReuseIdentifier() -> String {
        return "EmptyTableViewCell"
    }
    
    /**
     Register class nib in the table
     - Parameter tableView : The table view to register the cell in it
     */
    class func registerCell(inTable tableView:UITableView) {
        
        // Register cell
        tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.getReuseIdentifier())
    }
    
    /**
     Get cell height depends on the controller
     - Parameter tableView : The table view to register the cell in it
     */
    class func getCellHeight(forTableView tableView:UITableView) -> CGFloat {
        return tableView.frame.size.height - 200.0
    }
}
