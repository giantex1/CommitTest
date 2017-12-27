//  Created by Stanislav Khvalinskyi on 7/30/17.
//  Copyright © 2017 Atlassian. All rights reserved.

import Foundation
import XCTest

class CreateRemoteRepository2: XCTestCase
{
    //# MARK: - Service variables
    
    var appSupport = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first
    let app = XCUIApplication()
    let fileManager = FileManager.default
    let constants = Constants()
    
    //# MARK: - setup and teardown
    
    override func setUp()
    {
        super.setUp()
        continueAfterFailure = false
        //storeConfigs()
        XCUIApplication().launch()
    }
    
    override func tearDown()
    {
        super.tearDown()
        removeRepoFolder()
        deleteGHRepo(
            userName: Constants.ghAcc, repoName: constants.RepoName, pass: Constants.ghPass
        )
        //deleteBBRepo(
        //    userName: Constants.bbcAcc, repoName: constants.RepoName, pass: Constants.bbcPass
        //)
    }

//# MARK: - UI tests}

    
//# MARK: - Service Functions

    /// Deletes temporary remote repo
    ///
    /// - Parameters:
    ///   - userName: user name
    ///   - repoName: remository name
    ///   - pass: password to GH account
    func deleteGHRepo(userName: String, repoName: String, pass: String)
    {
        let data: Data?
        let response: URLResponse?
        let error: Error?
        let url = URL(string: "https://api.github.com/repos/\(Constants.ghAcc)/\(constants.RepoName)")
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
        request.httpMethod = "DELETE"
        (data, response, error) = URLSession.shared.synchronousDataTask(with: request)
        print(data ?? "no data")
        print(response ?? "no responce")
        print(error ?? "no errors")
        
        if let result = response as? HTTPURLResponse
        {
            print(result.statusCode)
        }
        do
        {
        let json: NSDictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
        print(json["name"]!)
        }
        catch let parseError
        {
            print(parseError)
        }
/*
        let result = Just.delete(
            "https://api.github.com/repos/\(userName)/\(repoName)",
            auth:(userName, pass))
        print(result)
 */
    }
    
}
