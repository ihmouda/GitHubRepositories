//
//  GeneralResourceTableViewCellRepresentable.swift
//  GitHubRepositories
//
//  Created by mihmouda on 15/06/2023.
//

import UIKit

class GeneralResourceTableViewCellRepresentable: TableViewCellRepresentable {
   
   /// The index path of the item data associated with the table view cell.
   var itemDataIndexPath: IndexPath
   
   /// The height of the table view cell.
   var cellHeight: CGFloat
   
   /// The reuse identifier for the table view cell.
   var cellReuseIdentifier: String
   
   /// The loading indicator status of the table view cell.
   var isLoading: Bool
   
   /// The image name for the table view cell.
   private(set) var imageName: String?
   
   /// The type of general resource for the table view cell.
   private(set) var type : GeneralResourceType
   
   /**
    Initializes a new instance of `GeneralResourceTableViewCellRepresentable`.
    
    This initializer sets the initial values for the properties.
    */
   init() {
       
       // Set initial values
       self.cellHeight = 0.0
       self.cellReuseIdentifier = EmptyTableViewCell.getReuseIdentifier()
       self.isLoading = false
       self.itemDataIndexPath = IndexPath(row: -1, section: -1)
       self.imageName = ""
       self.type = GeneralResourceType.loading
   }
   
   /**
    Initializes a new instance of `GeneralResourceTableViewCellRepresentable` with a given general resource.
    
    This initializer sets the initial values and assigns the properties based on the provided general resource.
    
    - Parameter generalResource: The general resource object to configure the representable object.
    */
   convenience init(generalResource: GeneralResource) {
       self.init()
       
       // Assign properties based on the provided general resource
       self.imageName = generalResource.imageName
       self.type = generalResource.type
   }
}
