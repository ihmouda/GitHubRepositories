# GitHubRepositories

[![License](https://img.shields.io/cocoapods/l/JNMentionTextView.svg?style=flat)](https://cocoapods.org/pods/JNMentionTextView)
[![Platform](https://img.shields.io/cocoapods/p/JNMentionTextView.svg?style=flat)](https://cocoapods.org/pods/JNMentionTextView)

**GitHubRepositories** A swift application displays the most trending public GitHub repositories.



## Preview

<img src="https://github.com/ihmouda/GitHubRepositories/raw/main/GitHubRepositories/Resources/Gifs/preview.gif" width="260"/>


## Requirements

- Xcode 14+
- iOS 14.0+
- Swift 5+


## Installation

you will need to have Git installed on your system. If you don't have Git installed, you can download it from the official website: [Git Downloads](https://git-scm.com/downloads)
.
Once you have Git installed, you can clone this repository to your local machine using the following command:

```swift
git clone https://github.com/ihmouda/GitHubRepositories.git
```

## Usage:

This project serves as a curated list of the most trending public GitHub repositories. You can explore the repositories listed here to find projects, libraries, and resources related to various domains.
The user can filter the list by search for specific name or selecting a specific timeframe [Last Day/Week/Month].
When select a specific repository cell, a detail view will appear with additional info. You can favorite items and view the list of favorite items.

## Project Structure:

The structure of our project is based on grouping by function, where we grouped all related swift files into one folder. Ex. Utils / Entities / …etc.

## Design Patterns:

- **Model View View Model (MVVM):**

    We applied the “MVVM” design pattern as the basic design pattern in our app replacing the traditional MVC to eliminate the massive controller problem by separates entities into three objects:

    - **View:**
    UI elements & visual elements that can viewed and interact with . They are typically subclass from UIView. (The ViewController is exist in MVVM  in View but it’s role is minimized.).

    - **Model:**
    Hold data. Struct / Class. And it must be isolated from business logic (data is returned). For testable/reusable/maintainable.

    - **ViewModel:**
    Transform model object into values are ready to appear on the screen.

- **Singleton:**

    Singleton is a design pattern that ensures a class can have only one instance. Used to define mangers and helper classes for global access.
   
- **Protocol-Delegation:**

    A design pattern that enables a class or structure to hand off (or delegate) some of its responsibilities to an instance of another type.
    
- **Repository pattern:**

    Is abstract layer separate between the domain and data mapping layers using a collection-like interface. The repository design pattern adherence the SOLID Principles by: 
    
    
    - **Single Responsibility:**
    The Repository performs one task, it is an interface for one domain layer to access its data stores.

    - **Open Closed Principle:**
    Repository is open to extension as long as it conforms to the Repository interface. And closed for modification.

    - **Liskov Substitution principle:**
    Every concrete implementation of the Repository must confirm to the Repository protocol and injected in the manager initialization method.
    
    - **Dependency inversion principle:**
    The manager doesn’t need to know any details about the Repository implementation.
    
    
## Utils:
  
- **DateUtils:**
        
    A helper class contain **"getDateStringFrom"** & **"getDateFromString"** methods.

 - **UserDefaultUtils:**
      
    A helper class for basic user default operations: (Add/Delete/Get)
        
- **AlertViewUtils:**
        
    A helper class too simplifies the process of showing and managing alert views in the app.

## Managers:

- **NetworkingManager:**
        
    A manager class responsible for handling network requests using Alamofire.

- **ConfigurationManager:**
      
    A singleton class responsible for managing the enviroment configuration settings.
        

-  **Handling network Reachability:**
  
    The app is efficiently respond to network reachability status; by rich UI experience by:
    
    - A “No Internet connection” full screen will appear if the network is not reachable with when trying to get the data list.
    - A “No Internet connection” UIAlertController will appear if the network is not reachable with existing data list.
    - When the network reachability status is updated and the connection is retrieved, the app will automatically hide the “No Internet connection” full screen or UIAlertController and request to get the data again.
      
<img src="https://github.com/ihmouda/GitHubRepositories/raw/main/GitHubRepositories/Resources/Gifs/no-internet-1.gif" width="260"/>

<img src="https://github.com/ihmouda/GitHubRepositories/raw/main/GitHubRepositories/Resources/Gifs/no-internet-2.gif" width="260"/>

      p
## Work Process:

1. Analyze the assignment requirements and specify the required functional and non-functional requirements.
2. Create a UI design using Sketch design tool for the required screens.
3. Translate the requirements into a code design using “Miro” project management tool.
4. Start the code development process.
5. Test, review, optimize and document the code.
6. Push the code to remote Github repository.
        
 
## Not implemented features:

**If I could have more time I wish to implement / enhance the following:**

1. Implement the  image caching without using the “SDWebImage” SDK.
2. Using “URLSession” API to perform network requests instead of “Alamofire” library.
3. Using a SplitViewController to adapt the master/detail behavior for iPhone and iPad devices.


## Contributing:

 **If you would like to contribute to this repository and add a GitHub repository that you find valuable, follow the steps below:**

1. Fork this repository.
2. Create a new branch with a descriptive name:

    ```swift
    git checkout -b your-branch-name
    ```
3. Update your README file.
4. Commit your changes: git commit -am 'Add new repository: repository-name'.
5. Push to the branch: git push origin your-branch-name.
6. Open a pull request in this repository, explaining the repository you are adding and why you find it valuable.

**Please ensure that any repositories you add are relevant, well-maintained, and provide value to the community.**
 
## Author

Mohammad Ihmouda

## License

GitHubRepositories is available under the MIT license. See the [LICENSE](https://github.com/ihmouda/GitHubRepositories/blob/master/LICENSE) file for more info.
