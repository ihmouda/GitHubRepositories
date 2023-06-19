//
//  LoadingTableViewCell.swift
//  GitHubRepositories
//
//  Created by mihmouda on 15/06/2023.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
   
   private var loadingIndicator: UIActivityIndicatorView!
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       
       self.setupView()
   }
   
   required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       
       self.setupView()
   }
   
   /**
    Sets up the view hierarchy and layout constraints for the cell.
    */
   private func setupView() {
       
       self.loadingIndicator = UIActivityIndicatorView(style: .large)
       self.contentView.addSubview(self.loadingIndicator)
       
       self.loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
       self.loadingIndicator.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
       self.loadingIndicator.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
       
       self.selectionStyle = UITableViewCell.SelectionStyle.none
   }
   
   /**
    Configures the loading indicator color and starts animating it.
    
    - Parameter color: The color to be applied to the loading indicator.
    */
   func setup(color: UIColor){
       
       self.loadingIndicator.color = color
       self.loadingIndicator.startAnimating()
   }
   
   /**
    Returns the reuse identifier for the loading table view cell.
    
    - Returns: The reuse identifier string.
    */
   class func getReuseIdentifier() -> String {
       return "LoadingTableViewCell"
   }
   
   /**
    Registers the loading table view cell for dequeuing in a table view.
    
    - Parameter tableView: The table view in which to register the cell.
    */
   class func registerCell(inTable tableView: UITableView) {
       
       tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.getReuseIdentifier())
   }
   
   /**
    Returns the height of the loading table view cell for a given table view.
    
    - Parameter tableView: The table view for which to calculate the cell height.
    - Returns: The height of the loading table view cell.
    */
   class func getCellHeight(forTableView tableView: UITableView) -> CGFloat {
       return tableView.frame.size.height - 200.0
   }
}
