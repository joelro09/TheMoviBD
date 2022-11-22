//
//  CollectionViewCell.swift
//  MoviDB
//
//  Created by Phinder 2022 on 22/11/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var calificacion: UILabel!
    @IBOutlet weak var fechaMovie: UILabel!
    @IBOutlet weak var DescriptionMovie: UILabel!
    
    var movies: Results?{
        didSet{
            
            titleMovie.text = movies?.name
            DescriptionMovie.text = movies?.description
            fechaMovie.text = movies?.getDate()
            //noticiasImage.image = #imageLiteral(resourceName: "logo_CISA_corredor")
            imageMovie.contentMode = .scaleAspectFit
            imageMovie.downloaded(from: movies?.imageURL,contentMode: .scaleAspectFill)
        }
    }

}

extension UIImageView{
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
