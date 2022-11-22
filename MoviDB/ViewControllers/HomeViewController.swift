//
//  HomeViewCOntroller.swift
//  MoviDB
//
//  Created by Phinder 2022 on 22/11/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    var dataModel = ListMovies()
    var viewModel =  ListShowsViewModel()
    
    @IBOutlet weak var collectionMovies: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MOVIES"
        collectionMovies.delegate = self
        collectionMovies.dataSource = self
    getListMovies()
    
    }
    
    func getListMovies(){
        if let url = URL(string: ApiConstants.listMovies){
            if let data = try? Data(contentsOf: url){
                let decoder = JSONDecoder()
                
                if let datosDecodificados = try? decoder.decode(ListMovies.self, from: data){
                    print("LIST OF MOVIES")
                    print(datosDecodificados.total_pages ?? "Error al decodificar Lista")
                    dataModel.results?.description = datosDecodificados.results?.description
                    dataModel.results?.name = datosDecodificados.results?.name
                    dataModel.results?.iso_639_1 = datosDecodificados.results?.iso_639_1
                    dataModel.results?.poster_path = datosDecodificados.results?.poster_path
                    
                }
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    private func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionMovie", for: indexPath) as! CollectionViewCell
        cell.titleMovie.text = dataModel.results?.name
        cell.DescriptionMovie.text = dataModel.results?.description
        cell.imageMovie.downloaded(from: dataModel.results?.poster_path ?? "default value")
        cell.fechaMovie.text = dataModel.results?.getDate()
        return cell
    }

    
    
}
