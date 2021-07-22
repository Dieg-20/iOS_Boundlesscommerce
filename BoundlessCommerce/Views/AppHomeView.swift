//
//  AppHomeView.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI
struct AppHomeView: View {
    
    @EnvironmentObject var businesses: Businesses
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(spacing: 15) {
                    HStack(spacing: 20){
                        VStack(alignment: .leading, spacing: 5, content: {
                            (
                                Text("Discover")
                                +
                                Text("   Brands")
                            )
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)
                            .shadow(color: Color.black, radius: 5)
                            
                            NavigationLink(destination: AllBusinessesList()){
                                    Text("View All")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .padding(.vertical,10)
                                        .padding(.horizontal)
                                        .background(Color(.brown))
                                        .clipShape(Capsule())
                                        .padding(.top)
                            }
                            

                        })
                        .padding(.leading)
                        
                        Spacer(minLength: 0)
                        
                        Image(systemName: "bag.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color(.yellow))
                            .padding()
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .background(Color(UIColor("1e2432") ?? UIColor(.black)))
                    .cornerRadius(15)
                }
                .shadow(color: Color.black, radius: 5)
                .padding(.horizontal)
                .padding(.vertical)
                
                VStack {
                    HStack{
                        Text("Popular Now")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                        Spacer()
                        NavigationLink(destination: AllBusinessesList()){
                                Text("View all")
                                    .padding()
                                    .navigationBarTitle("")
                                    .navigationBarHidden(true)
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing:25) {
                            ForEach(businesses.businesses, id: \.self) { business in
                                NavigationLink(destination: BusinessView(businessId: business.id ?? "", businessName: business.name, aBusiness: business)){
                                    BusinessCardView(business: business)
                                }
                            }
                        }
                        .padding()
                    })
                }
                
                VStack {
                    HStack{
                        Text("Favorites")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                        Spacer()
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing:25) {
                            ForEach(businesses.businesses, id: \.self) { business in
                                if business.favorite ?? false {
                                    NavigationLink(destination: BusinessView(businessId: business.id ?? "", businessName: business.name, aBusiness: business)){
                                        FavoriteBusinessCardView(business:business)
                                    }
                                }
                            }
                        }
                        .padding()
                    })
                }
                
                
                
            })

    }
    }
}

struct AppHomeView_Previews: PreviewProvider {
    static var previews: some View {
        AppHomeView()
    }
}

