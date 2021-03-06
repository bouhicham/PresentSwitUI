//
//  ContentView.swift
//  Social_Project
//
//  Created by HICHAM BOUZYARSIT on 09/12/2020.
//

import SwiftUI


struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Persons.entity(), sortDescriptors: [ NSSortDescriptor(keyPath: \Persons.name, ascending: true),
                                                               NSSortDescriptor(keyPath: \Persons.lastName, ascending: true),
                                                               NSSortDescriptor(keyPath: \Persons.adress, ascending: true),
                                                               NSSortDescriptor(keyPath: \Persons.city, ascending: true),
                                                               NSSortDescriptor(keyPath: \Persons.phone, ascending: true),
                                                               NSSortDescriptor(keyPath: \Persons.saved, ascending: false)
    ]) var family : FetchedResults<Persons>
    @State private var save: Bool = false
    var body: some View {
        NavigationView {// organiser notre page
            VStack {
                HStack {
                    Spacer()
                    Text("Inscrit").font(.caption).foregroundColor(.secondary)
                    ZStack {
                        Group {
                            Circle().fill(Color.green)
                                .frame(width: 23, height: 23)
                            
                            Text("\(self.family.count)").bold().foregroundColor(.white)
                            
                        }
                    }
                }.padding(.trailing)
                List {
                    ForEach(family, id: \.name) { big in
                        ZStack {
                            Rectangle().fill(Color.white)
                                .frame(width: UIScreen.main.bounds.width - 62, height: 100)
                                .cornerRadius(10).shadow(color: .gray, radius: 4)
                            
                            HStack { // assemble les vues horizontalement
                          Circle().fill(Color.green)
                         .frame(width: 23, height: 23)
                              
                                //  Image(systemName: "person.circle.fill")
                                // .font(.system(size: 45)).foregroundColor(.red)
                                
                                VStack(alignment: .leading) { // assemble les vues verticalement
                                    Text("\(big.name ?? "")").font(.headline)
                                    Text("\(big.lastName ?? "")").font(.subheadline)
                                    Text("\(big.adress ?? "")").font(.headline)
                                    Text("\(big.city ?? "")").font(.subheadline)
                                    Text("\(big.phone ?? "")").font(.headline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Button(action: {
                                    big.saved.toggle()
                                    try? self.moc.save()
                                }) {
                                    Image(systemName: big.saved ? "bookmark.fill": "bookmark")
                                }
                            }.padding()
                        }
                    }.onDelete(perform: remove)
                }
            }.navigationBarTitle("Famille")
            
            .navigationBarItems(leading: Image(systemName: "square.and.arrow.up"),
                                trailing: Button(action: { self.save.toggle()}) {
                                    Image(systemName: "plus.circle.fill")})
            .sheet(isPresented: $save) {
                AddNewFamily().environment(\.managedObjectContext, self.moc)
            }
        }
    }
    // fonction pour effacer une famille de la liste
    func remove(at offsets: IndexSet) {
        for index in offsets {
            let delete  = family[index]
            self.moc.delete(delete)
        }
        // To remove for the CoreData
        try? self.moc.save()
    }
}
// cette structure gére l'affichage du canvas
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
