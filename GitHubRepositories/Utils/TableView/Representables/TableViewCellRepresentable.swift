//
//  TableViewCellRepresentable.swift
//  GitHubRepositories
//
//  Created by mihmouda on 15/06/2023.
//

import Foundation

protocol TableViewCellRepresentable {
   
   /// The height of the table view cell.
   var cellHeight: CGFloat { get set }
   
   /// The index path of the item data associated with the table view cell.
   var itemDataIndexPath: IndexPath { get set }
}
