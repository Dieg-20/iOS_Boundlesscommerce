//
//  BusinessViewForList.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI
import FirebaseStorage

struct BusinessViewForList: View {
    @EnvironmentObject var businesses: Businesses
    var businessIdx: Int
    @State var updatedImage = UIImage()
    
    
    var body: some View {
        ZStack {
            if updatedImage == UIImage() {
                ProgressView()
                    .scaleEffect(2, anchor: .center)
                    .frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/5)
                
            } else {
                HStack(spacing:15) {
                    Text(businesses.businesses[businessIdx].name)
                        .font(.title2)
                        .fontWeight(.medium)
                    Spacer()
                    if businesses.businesses[businessIdx].favorite ?? true {
                        Image( systemName:  "suit.heart.fill")
                            .font(.title2)
                            .onTapGesture {
                                businesses.businesses[businessIdx].favorite = false
                            }
                    } else {
                        Image( systemName:  "suit.heart")
                            .font(.title2)
                            .onTapGesture {
                                businesses.businesses[businessIdx].favorite = true
                            }
                    }
                 
                    Spacer()
                    Image(uiImage: updatedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width/5, height: UIScreen.main.bounds.height/8)
                        .cornerRadius(25)
                }
            }
            
        }
        .onAppear(perform: {
            fetchImage()
        })
    }
    
    func fetchImage() {
        
        let storage = Storage.storage()
        let path = "\(businesses.businesses[businessIdx].id ?? "")/Business/\(businesses.businesses[businessIdx].id ?? "")"

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

struct BusinessViewForList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessViewForList(businessIdx: 0)
    }
}

