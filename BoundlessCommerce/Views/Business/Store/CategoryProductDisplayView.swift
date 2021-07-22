//
//  CategoryProductDisplayView.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI
import FirebaseStorage

struct CategoryProductDisplayView: View {
    
    var product: SelectedBusiness.Category.Product
    
    @EnvironmentObject var selectedBusiness: theSelectedBusiness
    @State var updatedImage = UIImage()
    
    var body: some View {
        ZStack {
            VStack {
                if updatedImage == UIImage() {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2, anchor: .center)
                        .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/1.8)
                } else {
                    ZStack {
                        VStack {
                        Image(uiImage: updatedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/2.4)
                            .cornerRadius(4)
                            .shadow(color: Color.black, radius: 2)
                            .cornerRadius(2)
                            .shadow(color: Color.black, radius: 5)
                            
                            Text(product.productName)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text("$ \(product.productPrice, specifier: "%.2f")")
                                .font(.title3)
                                .foregroundColor(.black)
                                .padding(.leading)
                                .padding(.bottom)
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear(perform: {
            fetchProductImage()
        })
    }
    
    func fetchProductImage() {
        let storage = Storage.storage()
        if product.images.count > 0 {
            let theImage = product.images[0]
            let imageReference = storage.reference().child(theImage)
            
            imageReference.getData(maxSize: 15 * 1024 * 1024) { data, error in
                if let error = error {
                    print("there was a problem downloading the image: \(error.localizedDescription)")
                } else {
                    let image = UIImage(data: data!)
                    self.updatedImage = image ?? UIImage()
                    print("Image donwloaded succesfully")
                }
            }
        }
    }
}

struct CategoryProductDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryProductDisplayView(product: SelectedBusiness.Category.Product(id: "", images: [String](), productName: "", productPrice: 0.0, productDescription: "", quantity: 0, productVariants: [SelectedBusiness.Category.Product.Variants]()))
    }
}
