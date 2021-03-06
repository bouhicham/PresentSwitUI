//
//  AddNewFamily.swift
//  Social_Project
//
//  Created by HICHAM BOUZYARSIT on 09/12/2020.
//

import SwiftUI

struct AddNewFamily: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @State private var name : String = ""
    @State private var lastName : String = ""
    @State private var adress : String = ""
    @State private var city: String = ""
    @State private var phone: String = ""
    @State private var saved : Bool = false



    var body: some View {
      
        NavigationView {
            Form {
                VStack {
                    TextField("Nom...", text: self.$name).padding()
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0))
                    TextField("Prénom...", text: self.$lastName).padding()
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0))
                    TextField("Adresse...", text: self.$adress).padding()
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0))
                    TextField("Ville...", text: self.$city).padding()
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0))
                    TextField("Téléphone...", text: self.$phone).padding()
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0))
                    Button(action: {
                        let add = Persons(context: self.moc)
                        add.name = self.name
                        add.lastName = self.lastName
                        add.adress = self.adress
                        add.city = self.city
                        add.phone = self.phone
                        add.saved = self.saved
                        
                        try? self.moc.save()
                        
                        self.name = ""
                        self.lastName = ""
                        self.adress = ""
                        self.city = ""
                        self.phone = ""
                    }) {
                        Text("Ajouter une famille").padding()
                            .font(.system(size: 23))
                            .foregroundColor((self.name.count > 0 && self.lastName.count > 0 && self.adress.count > 0 && self.city.count > 0 && self.phone.count > 0 ) ?
                                Color.white :
                                Color.gray)
                    
                    }.background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                }
            }
        }
    }
}

struct AddNew_Previews: PreviewProvider {
    static var previews: some View {
        AddNewFamily()
    }
}

