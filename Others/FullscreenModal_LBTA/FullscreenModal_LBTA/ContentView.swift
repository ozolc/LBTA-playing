//
//  ContentView.swift
//  FullscreenModal_LBTA
//
//  Created by Maksim Nosov on 02.01.2020.
//  Copyright © 2020 Maksim Nosov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var isPresented = false
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    Button(action: {
                        withAnimation {
                            self.isPresented.toggle()
                        }
                    }, label: {
                        Text("Show standard modal")
                    })
                }.navigationBarTitle("Standard")
            }
            
            ZStack {
                
                HStack {
                    Spacer()
                    VStack {
                        
                        HStack {
                            Button(action: {
                                withAnimation {
                                    self.isPresented.toggle()
                                }
                            }, label: {
                                Text("Dismiss")
                                    .font((.headline))
                                    .foregroundColor(.white)
                            })
                            Spacer()
                            
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.white)
                                .onTapGesture {
                                    withAnimation {
                                        self.isPresented.toggle()
                                    }
                            }
                        }
                            
                            
                        .padding(.top, UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.safeAreaInsets.top)
                        Spacer()
                    }
                    Spacer()
                }
                
            }.background(Color.yellow)
                .edgesIgnoringSafeArea(.all)
                .offset(x: 0, y: self.isPresented ? 0 : (UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.frame.height ?? 0))
        }
    }
}



//                    .sheet(isPresented: $isPresented, content: {
//
//                        Button(action: {
//                            self.isPresented.toggle()
//                        }) {
//                            Text("Here is my modal")
//                        }
//
//                    })


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
