//
//  ViewController.swift
//  MoviDB
//
//  Created by Phinder 2022 on 16/11/22.
//

import UIKit

// Observable
class Observable<T> {
    var value: T{
        didSet{
            listeners.forEach{$0(value)}
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    private var listeners: [((T) -> Void)] = []
    
    func bind(_ listener:@escaping (T) -> Void) {
        //Check this
        //listener(value)
        self.listeners.append(listener)
    }
    
    func removeAllListeners(){
        listeners.removeAll()
    }
}


class ViewController: UIViewController, UITextFieldDelegate {
    
    var viewModel = LoginViewModel()
    
    var movieDataToken: MovieDataResponse?
    
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var labelError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getToken()
        
        userNameText.delegate = self
        passwordText.delegate = self
        
        passwordText.isSecureTextEntry = true
        
        viewModel.statusCode.bind { [weak self] code in
            self?.hideLoader()
            if code == .success{
                print("Todo OK, Login")
                self?.performSegue(withIdentifier: "loginSegue", sender: nil)
               // self?.navigationController?.popViewController(animated: true)
            }else{
                self?.labelError.isHidden = false
                print("Error de Login")
            }
        }
        
    }
    
    func getToken() {
        if let url = URL(string: ApiConstants.tokenBase){
            if let data = try? Data(contentsOf: url){
                let decoder = JSONDecoder()
                
                if let datosDecodificados = try? decoder.decode(MovieDataResponse.self, from: data){
                    print(datosDecodificados.request_token ?? "ERROR al decodificar TOKEN" )
                    print(datosDecodificados.expires_at ?? "Error al decodificar los datos")
               
                    movieDataToken?.request_token = datosDecodificados.request_token ?? "Error token"
                    ProfileInfo.shared.token = datosDecodificados.request_token
                
                }
            }
        }
           
    }

    @IBAction func makeLogin(_ sender: Any) {
        
        self.view.endEditing(true)
        let userName = userNameText.text ?? ""
        let password = passwordText.text ?? ""
        
        showLoader()
        viewModel.makeLogin(userName: userName, password: password)
    }
    
}

extension UIViewController{
    func showLoader(){
        hideLoader()
        
        let loader = LoaderView()
        view.addSubview(loader)
        
        loader.anchor(top: nil,
                      leading: nil,
                      bottom: nil,
                      trailing: nil,
                      size: CGSize(width: view.frame.width, height: view.frame.height))
        
        loader.startIndicator()
        
    }
    
    func hideLoader(){
        view.subviews.forEach { currentView in
            if let loader = currentView as? LoaderView{
                loader.stopIndicator()
                loader.removeFromSuperview()
            }
        }
    }
}

