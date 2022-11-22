//
//  LoginViewModel.swift
//  MoviDB
//
//  Created by Phinder 2022 on 20/11/22.
//

import Foundation

class LoginViewModel {
    
    var token  = Observable("")
    var statusCode = Observable(CodeResponse.success)
    var codeRestore = Observable(CodeResponse.success)
    var message = ""
   
    init() {
    }
    
    //Función que hace el request a la Api, para logear
    func makeLogin(userName: String, password: String){
        let parameters = LoginRequets(username: userName, password: password, request_token: ProfileInfo.shared.token)
        API.request(url: ApiConstants.login,
                    method: .POST,
                    parameters:parameters.dictionary) {[weak self] (response:MovieDataResponse?, statusCode) in
            
            self?.message = response?.expires_at ?? ""
            self?.statusCode.value = statusCode
            
            guard let res = response?.request_token else{
                return
            }
            
            if statusCode == .success{
                print("OK...")
                self?.token.value = ProfileInfo.shared.token ?? "Error  decode Token"
            }
            
            
        }
    }
    
    
}
//JSON decodable
extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}
