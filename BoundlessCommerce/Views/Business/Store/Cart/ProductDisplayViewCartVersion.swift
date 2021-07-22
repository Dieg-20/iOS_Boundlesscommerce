//
//  ProductDisplayViewCartVersion.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI
import FirebaseStorage

struct ProductDisplayViewCartVersion: View {
    
    var orderProduct: SelectedBusiness.Category.Product
    @EnvironmentObject var selectedBusiness: theSelectedBusiness
    @State var updatedImage = UIImage()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Image(uiImage: updatedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.height/6)
                    .cornerRadius(2)
//                    .shadow(color: Color.black, radius: 10)
                    .padding()
                
                VStack {
                    Text(orderProduct.productName)
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding()
                    
                    Text("\(orderProduct.productPrice, specifier: "%.2f")")
                          .font(.title2)
                          .fontWeight(.medium)
                          .padding()
                }
                
//                Divider()
//                QuantityPickerView(orderProductIdx: 0)
                
            }
        }
        .onAppear(perform: {
            fetchProductImage()
        })
    }
    
    
    func fetchProductImage() {
        let storage = Storage.storage()
        if orderProduct.images.count > 0  {
            let imageOnePath = orderProduct.images[0]
            let imageReference = storage.reference().child(imageOnePath)
            
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

struct ProductDisplayViewCartVersion_Previews: PreviewProvider {
    static var previews: some View {
        ProductDisplayViewCartVersion(orderProduct: SelectedBusiness.Category.Product(id: "", images: [String](), productName: "", productPrice: 0.0, productDescription: "", quantity: 0, productVariants: [SelectedBusiness.Category.Product.Variants]()))
    }
}
