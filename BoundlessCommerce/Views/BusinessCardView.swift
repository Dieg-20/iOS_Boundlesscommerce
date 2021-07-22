//
//  BusinessCardView.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI
import FirebaseStorage

struct BusinessCardView: View {
    
    var business: Business
    @State var updatedImage = UIImage()
    var body: some View {
        ZStack {
            if updatedImage == UIImage() {
                ProgressView()
                    .scaleEffect(2, anchor: .center)
                    .frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/5)
                
            } else {
                VStack {
                VStack{
                    Image(uiImage: updatedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width/2.5, height: UIScreen.main.bounds.height/4)
                        .cornerRadius(25)

                 
                }
                .shadow(color: Color.black, radius: 5)
                    
                    Text(business.name)
                        .font(.title2)
                        .fontWeight(.medium)
                }
            }
            
        }
        .onAppear(perform: {
            fetchImage()
        })
        .padding()
    }
    
    func fetchImage() {
        
        let storage = Storage.storage()
        let path = "\(business.id ?? "")/Business/\(business.id ?? "")"

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

struct BusinessCardView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessCardView(business: Business(id: "", name: "", subscribtionActive: false, merchantActive: false, favorite: false))
    }
}


