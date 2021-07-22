//
//  ImageWithTextBlockView.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI
import FirebaseStorage

struct ImageWithTextBlockView: View {
    
    var blockId: String
    var aBusiness: Business
    var blockText: String
    
    @State private var updatedImage = UIImage()
    @EnvironmentObject var selectedBusiness: theSelectedBusiness
    
    var body: some View {
        VStack {
            if updatedImage == UIImage() {
                ProgressView()
                    .scaleEffect(4, anchor: .center)
                    
            } else {
                VStack {
                    
                        Image(uiImage: updatedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)

                            .frame(width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/2)
                         .cornerRadius(10)
                            .padding()

                    VStack {
                        Text(blockText)
                        .font(.title3)
                    }
                    Spacer()
                }
            }
            
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
        .padding()
        .background(Color.white)
        .onAppear(perform: {
            fetchImageWithTextImage()
        })
    }
    
    func fetchImageWithTextImage() {
        let storage = Storage.storage()
        guard let businessId = aBusiness.id else {return}
        let path = "\(businessId)/StoreStructure/\(blockId)"

        let imageReference = storage.reference(withPath: path)

        imageReference.getData(maxSize: 15 * 1024 * 1024) { data, error in
            if let error = error {
                print("there was a problem downloading the image for the ImageWithText \( error.localizedDescription)")
            } else {
                let image = UIImage(data: data!)
                self.updatedImage = image ?? UIImage()
                print("Image for banner donwloaded succesfully")
            }
        }
    }
}

struct ImageWithTextBlockView_Previews: PreviewProvider {
    static var previews: some View {
        ImageWithTextBlockView(blockId: "", aBusiness: Business(id: "", name: "", subscribtionActive: false, merchantActive: false, favorite: false), blockText: "")
    }
}

