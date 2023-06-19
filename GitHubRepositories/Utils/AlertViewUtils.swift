//
//  AlertViewUtils.swift
//  GitHubRepositories
//
//  Created by mihmouda on 17/06/2023.
//

import UIKit

class AlertViewUtils {
   
   /// The currently presented alert controller.
   static var alertController: UIAlertController?
   
   /**
    Shows an alert view with the specified title, message, actions, and style.
    
    - Parameters:
       - title: The title of the alert view. Default is `nil`.
       - message: The message of the alert view. Default is `nil`.
       - actions: An array of `UIAlertAction` objects representing the actions to add to the alert view. Default is an empty array.
       - preferredStyle: The style of the alert view. Default is `.alert`.
       - viewController: The view controller to present the alert view on.
    */
   static func showAlert(title: String? = nil, message: String? = nil, actions: [UIAlertAction] = [], preferredStyle: UIAlertController.Style = .alert, viewController: UIViewController) {

       self.alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)

       for action in actions {
           self.alertController?.addAction(action)
       }
       
       DispatchQueue.main.async {
           viewController.present(self.alertController!, animated: true)
       }
   }

   /**
    Defines an option action with the specified title, style, and completion handler.
    
    - Parameters:
       - title: The title of the option action.
       - style: The style of the option action. Default is `.default`.
       - completion: The completion handler to execute when the option action is selected. Default is `nil`.
    
    - Returns: An `UIAlertAction` object representing the defined option action.
    */
   static func defineOptionAction(title: String, style: UIAlertAction.Style = .default, completion:  (()->())? = nil) -> UIAlertAction {
       
       let action = UIAlertAction(title: title, style: style) { _ in
           completion?()
       }
       
       return action
   }
   
   /**
    Hides/dismisses the currently presented alert controller.
    */
   static func hideAlertController() {
       self.alertController?.dismiss(animated: true)
   }
}

