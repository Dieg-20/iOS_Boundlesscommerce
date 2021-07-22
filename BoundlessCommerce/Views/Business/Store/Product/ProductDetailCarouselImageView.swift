//
//  ProductDetailCarouselImageView.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI
import FirebaseStorage

struct ProductDetailCarouselImageView: View {
    
    @EnvironmentObject var selectedBusiness: theSelectedBusiness
    @State var updatedImage = UIImage()
    
    var theImage: String
    
    var body: some View {
        ZStack {
            Image(uiImage: updatedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.8)
        .shadow(color: Color.black, radius: 6)
        .cornerRadius(10)
        .ignoresSafeArea(.all)
        .onAppear(perform: {
            fetchImage()
        })
    }
    
    func fetchImage() {
        let storage = Storage.storage()
        let imageReference = storage.reference().child(theImage)

        imageReference.getData(maxSize: 15 * 1024 * 1024) { data, error in
            if let error = error {
                print("there was a problem downloading the image: \(error.localizedDescription)")
            } else {
                let image = UIImage(data: data!)
                self.updatedImage = image!
                print("Image donwloaded succesfully")
            }
        }
    }
}

struct ProductDetailCarouselImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailCarouselImageView(theImage: "")
    }
}
