//
//  MyFriendsView.swift
//  G2_findevents
//
//  Created by Created by Zahra Shahin - Golnaz Chehrazi on 2023-06-25 on 2023-06-25.
//

import SwiftUI

struct MyFriendsView: View {
    @EnvironmentObject var authHelper: FireAuthController
    @EnvironmentObject var dbHelper: FirestoreController
    
    var body: some View {
        VStack {
            Text("Your Friends List").font(.title)
            
            Button(action: {
                dbHelper.deleteAllMyFriends()
               
            }) {
                Text("Remove All")
            }
            .buttonStyle(.borderedProminent)
           
            
            List {
                if dbHelper.myFriendsList.isEmpty {
                    Text("No Friends exist to Show")
                }
                ForEach(dbHelper.myFriendsList, id:\.self) { myFrnd in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(myFrnd.name)
                                .font(.headline)
                            Text(myFrnd.contactNumber)
                                .font(.subheadline)
                        }
                    
                       // Text("\(dbHelper.myFriendsList.count)")
                        
                        Spacer()
                        if let imageData = myFrnd.image {
                            Image(uiImage: UIImage(data: imageData)!)
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    }
                }.onDelete(perform: { indexSet in
                    for index in indexSet {
                        if let friendID = dbHelper.myFriendsList[index].id {
                            dbHelper.deleteMyFriend(friendID: friendID)
                            print("Friend removed at index: \(index)")
                            dbHelper.myEventsList.removeAll()

                        } else {
                            print("Friend ID is nil at index: \(index)")
                        }
                    
                    }
                 })


            }
            Spacer()
        }//VSTACK
        .onAppear {
           dbHelper.reloadFriends()
        }
    }
}
