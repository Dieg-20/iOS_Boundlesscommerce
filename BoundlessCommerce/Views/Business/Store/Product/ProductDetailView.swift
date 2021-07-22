//
//  ProductDetailView.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI
struct ProductDetailView: View {
    
    @EnvironmentObject var selectedBusiness: theSelectedBusiness
    @Environment(\.presentationMode) var presentationMode
  
    @State var show = false
    @State var offset: CGFloat = UIScreen.main.bounds.height
    
    var currentCategory: SelectedBusiness.Category
    var product: SelectedBusiness.Category.Product
    var aBusiness: Business
     
    @State var selectedVariant = SelectedBusiness.Category.Product.Variants(variantId: "", variantName: "", selectedOption: "", selectedVariant: "", variantOptions: [SelectedBusiness.Category.Product.Variants.Options]())
    
    @State var theSelectedOptionId = ""

    
    @State private var showingActionSheet = false
    
    @State var selectedOption = 0
    
    @State private var descriptionExpanded = false
    
    @State private var showingAddToCartSheet = false
    
    @State private var productAddedToCart = false

    @State var total = 0.0
    
    
    func initiatePriceCalculation(option: String) {
        selectedBusiness.calculateProductPrice(product: product, selectedOption: option)
    }
    
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
            

            VStack {
            ScrollView(showsIndicators: false) {
                    
                    VStack {
                        ProductDetailImagesCarouselView(product: product, aBusiness: aBusiness)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.8)
                    }
                
                Spacer()
                VStack {
                    HStack {
                        Text(product.productName)
//                            .foregroundColor(Color(UIColor(selectedBusiness.business.mainColor ?? "000000") ?? UIColor(.black)))
//                            .foregroundColor(Color(theColor ?? .black ))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.leading)
                            .padding(.top)
                            .padding(.bottom, UIScreen.main.bounds.height/500)
                        Spacer()
                    }
                    .padding(.leading)

                    HStack {
                        Text("$ \(selectedBusiness.orderTotal, specifier: "%.2f")")
                            .font(.title3)
                            .foregroundColor(.black)
                            .padding(.leading)
                            .padding(.bottom)
                        Spacer()
                    }
                    .padding(.leading)

                  
                    HStack {
                        if var unwrappedProductVariants2 = product.productVariants {

                                ForEach(unwrappedProductVariants2.indices, id: \.self) { productVariantIdx in
//                                    HStack {
                                        Text("Select \(unwrappedProductVariants2[productVariantIdx].variantName)")
                                           
//                                            .padding(.leading)
//                                            .padding(.bottom)
//                                        Spacer()
//                                    }
                                   
                                    
                                    ForEach(unwrappedProductVariants2[productVariantIdx].variantOptions.indices, id: \.self) { variantOptionIdx in
                                       
                                        if(theSelectedOptionId == unwrappedProductVariants2[productVariantIdx].variantOptions[variantOptionIdx].optionId) {
                                            Button(action: {
                                                unwrappedProductVariants2[productVariantIdx].selectedOption = unwrappedProductVariants2[productVariantIdx].variantOptions[variantOptionIdx].optionId
                                                
                                                theSelectedOptionId = unwrappedProductVariants2[productVariantIdx].variantOptions[variantOptionIdx].optionId
                                                
                                                initiatePriceCalculation(option: unwrappedProductVariants2[productVariantIdx].variantOptions[variantOptionIdx].optionId)
                                            }) {
//                                                HStack {
                                                Text(unwrappedProductVariants2[productVariantIdx].variantOptions[variantOptionIdx].optionName)
                                                    .font(.title3)
                                                    .padding()
                                                    .multilineTextAlignment(.center)
                                                    .background(Rectangle().stroke())
                                                    .foregroundColor(Color.black)
//                                                    .fontWeight(.bold)
//                                                    .padding()
                                                 
//                                                    Spacer()
//                                                }
                                            }
                                        } else {
                                            Button(action: {
                                                unwrappedProductVariants2[productVariantIdx].selectedOption = unwrappedProductVariants2[productVariantIdx].variantOptions[variantOptionIdx].optionId
                                                
                                                theSelectedOptionId = unwrappedProductVariants2[productVariantIdx].variantOptions[variantOptionIdx].optionId
                                                
                                                initiatePriceCalculation(option: unwrappedProductVariants2[productVariantIdx].variantOptions[variantOptionIdx].optionId)
                                            }) {
                                                Text(unwrappedProductVariants2[productVariantIdx].variantOptions[variantOptionIdx].optionName)
                                                    .font(.title3)
                                                    .padding()
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(Color.black)
                                            }
                                        }
                                    }
                                    
                                }

                        }
                    }


                    VStack {
                        Divider()
                            Button(action: {
                                withAnimation(.linear) {
                                self.descriptionExpanded.toggle()
                                }
                            }) {
                                HStack {
                                    Text("Description")
                                        .fontWeight(.medium)
                                        .padding(.leading)

                                    Spacer()
                                    Image(systemName: "plus")
                                }
                                .padding(.bottom, UIScreen.main.bounds.height/250)
                                .font(.title2)
                                .foregroundColor(Color.black)
                              
                            }


                        if self.descriptionExpanded {
                            Text(product.productDescription)
                                .font(.title3)
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                                .padding(.leading)
                                .padding(.trailing)
                            Spacer()
                    }
                        Divider()
                        
//                        Divider()
//                        HStack {
//                            Text("Shipping")
//                                .fontWeight(.medium)
//                                .padding(.leading)
//
//                            Spacer()
//                            Image(systemName: "plus")
//                        }
//                        .padding(.bottom, UIScreen.main.bounds.height/250)
//                        .font(.title2)
//                        .foregroundColor(Color.black)
//                        Divider()
                    }
                    .padding()

                    if currentCategory.categoryProducts.count > 1 {
//                        RelatedProductsView(currentProductIdx: productIdx, currentCategoryIdx: categoryIdx)
                    }





            }
            }

            Spacer()
            
                HStack {
            VStack {
                Button(action: {


                    let theProduct = SelectedBusiness.Category.Product(id: product.id, images: product.images, productName: product.productName , productPrice: selectedBusiness.orderTotal, productDescription: product.productDescription, quantity: 1,
                                                                       productVariants: product.productVariants)

                    selectedBusiness.order.orderProducts.append(theProduct)

//                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self.productAddedToCart = true
//                    }
                }){
                    Text("Add to Cart")

                        .font(.title2)
                        .foregroundColor(Color(.white))
                        .fontWeight(.bold)
                        .shadow(radius: 2)
                        .frame(width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/16, alignment: .center)
                        
                    
                            .background(Color(UIColor(selectedBusiness.storeTheme.mainColor  ?? "000000") ?? UIColor(.black)))
//                        .background(Color(selectedBusiness.business.productCartButtonColor ?? "000000"))
//                        .background(Color(#colorLiteral(red: 0.2784313725, green: 0.4156862745, blue: 0.5215686275, alpha: 1)))
           
                        
                }

                .clipShape(Capsule())
                .cornerRadius(4.0)
                .shadow(radius: 2)
            }
            .padding(.bottom, 20)
                }
        }
            
     
        
        .navigationBarItems(trailing:
                                Button(action: {
                                    print("tapped")
                                    showingAddToCartSheet = true
                                }) {
                                    if !productAddedToCart {
                                        Image(systemName: "bag.fill")
                                                                .font(.system(size: 30))
                                                                .foregroundColor(.white)
                                    } else {
                                        Image(systemName:"bag.fill.badge.plus")
                                            .font(.system(size: 30))
                                            .foregroundColor(.white)
                                    }
                                }
            .sheet(isPresented: $showingAddToCartSheet) {
                NavigationView {
                    CartSheetView()
                        .environmentObject(selectedBusiness)
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                }
          


            }
        )
        
//        .background((self.show ? Color.black.opacity(0.3): Color.clear).edgesIgnoringSafeArea(.all).onTapGesture {
//            self.show.toggle()
//        })
        .ignoresSafeArea(.all)
//        .onTapGesture {
//            self.show.toggle()
//        }

        
    
        .onAppear(perform: {
//            selectedBusiness.calculatePrice(categoryIdx: categoryIdx, productIdx: productIdx, selectedOption: "")
            selectedBusiness.calculateProductPrice(product: product, selectedOption: "")
            
 

        })

    }

}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView( currentCategory: SelectedBusiness.Category(id: "", categoryName: "", hasImage: false, categoryChecked: false, categoryProducts: [SelectedBusiness.Category.Product]()), product: SelectedBusiness.Category.Product(id: "", images: [String](), productName: "", productPrice: 0.0, productDescription: "", quantity: 0, productVariants: [SelectedBusiness.Category.Product.Variants]()), aBusiness: Business(id: "", name: "", subscribtionActive: false, merchantActive: false, favorite: false))
    }
}
