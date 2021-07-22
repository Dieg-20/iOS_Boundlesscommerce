//
//  CategoryDisplayView.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI
import FirebaseStorage

struct CategoryDisplayView: View {
    
    var category: SelectedBusiness.Category
    var aBusiness: Business
    
    @EnvironmentObject var selectedBusiness: theSelectedBusiness
    @State var updatedImage = UIImage()
    
    var body: some View {
        ZStack {
            if updatedImage == UIImage() {
                ProgressView()
                    .scaleEffect(2, anchor: .center)
                    .frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/5)
                
            } else {
                VStack {
                    ZStack {
                        Image(uiImage: updatedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/5)
                            .cornerRadius(10)
                            .shadow(color: Color.black, radius: 5)
                    }
                }
            }
            
        }
        .padding()
        .onAppear(perform: {
            fetchImage()
        })
    }
    
    func fetchImage() {
        
        let storage = Storage.storage()
        let path = "\(aBusiness.id ?? "")/Categories/\(category.id ?? "")"

        let imageReference = storage.reference().child(path)

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

struct CategoryDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDisplayView(category: SelectedBusiness.Category(id: "", categoryName: "", hasImage: false, categoryChecked: false, categoryProducts: [SelectedBusiness.Category.Product]()), aBusiness: Business(id: "", name: "", subscribtionActive: false, merchantActive: false, favorite: false) )
    }
}
