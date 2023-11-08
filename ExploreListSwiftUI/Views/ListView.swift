//
//  ContentView.swift
//  ExploreListSwiftUI
//
//  Created by Macbook Pro on 8/11/2023.
//

import SwiftUI

struct ListView: View {
    
    // Just Samples
    @State var todayTodos = [
        TodoItem(title: "Practise List"),
        TodoItem(title: "Read one Article"),
        TodoItem(title: "Research SwiftUI")
    ]
    
    @State var tomorrowTodos = [
        TodoItem(title: "Practice"),
        TodoItem(title: "Research SwiftUI"),
    ]
    
    //
    
    //Multi-Selection
    @State var multiselection: Set<UUID> = Set<UUID>()
    
    var body: some View {
        NavigationStack {
            List(selection: $multiselection) {
                Section {
                    ForEach(todayTodos) { todo in
                        Text(todo.title)
                    }
                    .onDelete { index in
                        todayTodos.remove(atOffsets: index)
                    }
                    .onMove { indice, newOffset in
                        todayTodos.move(fromOffsets: indice, toOffset: newOffset)
                    }
                    
                } header: {
                    Text(Date().formatted(date: .abbreviated, time: .omitted))
                } footer: {
                   Text("Footer 1")
                        .fontWeight(.light)
                        .fontWidth(.condensed)
                }
                
                Section {
                    ForEach(tomorrowTodos) { todo in
                        /*@START_MENU_TOKEN@*/Text(todo.title)/*@END_MENU_TOKEN@*/
                    }
                    .onDelete { indexSet in
                        tomorrowTodos.remove(atOffsets: indexSet)
                    }
                    .onMove { indice, newOffsets in
                        tomorrowTodos.move(fromOffsets: indice, toOffset: newOffsets)
                    }
                    
                    
                } header: {
                    Text("Tommorow")
                        .fontWeight(.medium)
                        .foregroundColor(.blue)
                } footer: {
                    Text("Footer 2")
                        .fontWeight(.light)
                        .fontWidth(.condensed)

                }
            }
            .listStyle(.plain)
            .refreshable {
                var copyOfTodayTodos = todayTodos
                var copyOfTomorrowTodos = tomorrowTodos
                
                copyOfTodayTodos.append(TodoItem(title: "Buy Milk"))
                copyOfTomorrowTodos.append(TodoItem(title: "Plan for next day"))
                
                todayTodos.removeAll()
                tomorrowTodos.removeAll()
                //Simulate API
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    todayTodos = copyOfTodayTodos
                    tomorrowTodos = copyOfTomorrowTodos
                }
            }
            .navigationTitle("Todo List")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    EditButton()
                }
            }
            Text("\(multiselection.count) selected")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
