//
//  ViewController.swift
//  TableViewConfig
//
//  Created by Sudheshna Tholikonda on 21/07/24.
//

import UIKit



class ViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    
   // var products: [Products] = []
    let session = URLSession(configuration: URLSessionConfiguration.default)
 

 override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
       // self.parseGetAPI()
        self.fetchdata(pageNo: 1)
//            APIManager.shared.fetchData { response in
//                switch response {
//                case .success(let products):
//                    self.products = products
//                case .failure(let error):
//                    print(error)
//                }
//            }
        // Do any additional setup after loading the view.
    }
    func fetchdata(pageNo:Int) {
        if let url = URL(string: "https://reqres.in/api/users?page=\(pageNo)"){
            URLSession.shared.dataTask(with: url) { data,response, error in
                if let resData = data{
                    do {
                        let res = try JSONDecoder().decode(Products.self, from: resData)
                        print(res.first_name)
                        guard pageNo == 2 else {
                            return
                        }
                        self.fetchdata(pageNo: 2)
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            } .resume()
        }
    }
    
    func parseGetAPI(){

        let url = URL(string: "https://api.github.com/users/hadley/orgs")!
        //let url = URL(string: "https://api.github.com/users/hadley/orgs")!

        print("parseGetAPI",url)
        let task = session.dataTask(with: url) { data, response, error in
            // ensure there is no error for this HTTP response
            guard error == nil else {
                print ("ConnectionManagerError: \(error!)")
                return
            }
            // ensure there is data returned from this HTTP response
            guard let content = data else {
                print("ConnectionManagerError:","No data")
                return
            }
            // serialise the data / NSData object into Dictionary [String : Any]
            do {
                //create json object from data
                    let json = try JSONSerialization.jsonObject(with: content, options: [])
                  
                    if let object = json as? [String: Any] {
                        // json is a dictionary
                       print("JSONSerialization",object)
                    } else if let object = json as? [Any] {
                        // json is an array
                        print("Array File",object)

                    } else {
                        print("JSON Structure is invalid!")
                    }
                    // handle json...
            } catch let error {
                print("ConnectionManagerError:",error.localizedDescription)
            }
        }
        // execute the HTTP request
        task.resume()
    }

}

