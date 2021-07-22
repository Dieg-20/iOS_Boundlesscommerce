//
//  BannerBlockView.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI
import FirebaseStorage

struct BannerBlockView: View {
    
    var blockId: String
    var businessId: String
    
    @State private var updatedImage = UIImage()
    @EnvironmentObject var selectedBusiness: theSelectedBusiness
    
    var body: some View {
        ZStack {
            if updatedImage == UIImage() {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(3, anchor: .center)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.8)
                    
            } else {
                Image(uiImage: updatedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.8)
        .shadow(color: Color.black, radius: 6)
        .cornerRadius(10)
        .ignoresSafeArea(.all)
        .onAppear(perform: {
            fetchBannerImage()
        })
        
        Spacer()
    }
    
    func fetchBannerImage() {
        let storage = Storage.storage()
        let path = "\(businessId)/StoreStructure/\(blockId)"

        let imageReference = storage.reference(withPath: path)

        imageReference.getData(maxSize: 15 * 1024 * 1024) { data, error in
            if let error = error {
                print("there was a problem downloading the image for banner \( error.localizedDescription)")
            } else {
                let image = UIImage(data: data!)
                self.updatedImage = image ?? UIImage()
                print("Image for banner donwloaded succesfully")
            }
        }
    }
}

struct BannerBlockView_Previews: PreviewProvider {
    static var previews: some View {
        BannerBlockView(blockId: "", businessId: "")
    }
}
