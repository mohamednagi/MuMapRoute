//
//  APIService.swift
//  MyMapRoute
//
//  Created by Sierra on 7/18/18.
//  Copyright © 2018 Nagiz. All rights reserved.
//

import UIKit
//
//@objc protocol CountryServiceDelegate{
//    @objc optional func GettingCountry(country:Country)
//    func Error (message : String)
//}

class APIService {
    
  //  static  var delegate : CountryServiceDelegate?
    
    static func GetDetails(city:String){
        
        let Sstring = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=7ae9e49c738ef80279e2b0fe3958be22"
        
        let path = URL(string:Sstring)
        let request = URLRequest(url: path!)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpresponse = response as? HTTPURLResponse{
                print("***********")
                print(httpresponse.statusCode)
                print("***********")
            }
            do{
                if error == nil {
                    if let mydata = data{
                        let json = try JSON(data: mydata)
                        var status = 0
                        if let cod = json["cod"].int {
                            status = cod
                        }else if let cod2 = json["cod"].string {
                            status = Int(cod2)!
                        }
                        if status == 200 {
                            let lat = json["coord"]["lat"].double
                            let lon = json["coord"]["lon"].double
                         //   let country = Country(lat: lat!, lon: lon!)
                         //   if delegate != nil {
                             //   DispatchQueue.main.async {
                                  //  self.delegate?.GettingCountry!(country: country)
                                    defaults.set(lat, forKey: latKey)
                                    defaults.set(lon, forKey: lonKey)
                                    defaults.synchronize()
                                    print("API :: lat \(lat!) & lon : \(lon!)")
                                    print("Succeeded")
                              //  }
                          //  }
                        }else if status == 404 {
                          //  if self.delegate != nil {
                                DispatchQueue.main.async {
                                  //  self.delegate?.Error(message: "City NotFound")
                                    print("City Not Found")
                                }
                          //  }
                        }else {
                        //    if self.delegate != nil {
                                DispatchQueue.main.async {
                                  //  self.delegate?.Error(message: "SomeThing Went Wrong")
                                    print("SomeThing Went Wrong")
                                }
                      //  }
                    }
                    }
                }
            }catch {
                print("Error")
            }
            }.resume()
}
}
