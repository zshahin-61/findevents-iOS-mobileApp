//
//  SignInView.swift
//  G2_findevents
//
//  Created by zahra SHAHIN on 2023-06-25.
//

import SwiftUI


struct SignInView: View {
    @EnvironmentObject var authHelper : FireAuthController
    @EnvironmentObject var dbHelper: FirestoreController

    @State private var email : String = "golnaz.chehrazi@gmail.com"
    @State private var password : String = "Admin123"

    @Binding var rootScreen : RootView
    
    private let gridItems : [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    
    var body: some View {
        
        VStack{

            Form{
                TextField("Enter Email", text: self.$email)
                    .textInputAutocapitalization(.never)
                    .textFieldStyle(.roundedBorder)
                
                SecureField("Enter Password", text: self.$password)
                    .textInputAutocapitalization(.never)
                    .textFieldStyle(.roundedBorder)
            }
            .autocorrectionDisabled(true)
            
            LazyVGrid(columns: self.gridItems){
                Button(action: {
                  
                    self.authHelper.signIn(email: self.email, password: self.password, withCompletion: { isSuccessful in
                        if (isSuccessful){
                            self.rootScreen = .Home
                        }else{
                            //show the alert with invalid username/password prompt
                            print(#function, "invalid username/password")
                        }
                    })
                    
                }){
                    Text("Sign In")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .background(Color.blue)
                }
                
                Button(action: {
                    self.rootScreen = .SignUp


                }){
                    
                    Text("Sign Up")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .background(Color.blue)
                }
            }
        }

        
    }
}


