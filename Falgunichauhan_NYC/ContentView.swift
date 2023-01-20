//
//  ContentView.swift
//  Falgunichauhan_NYC
//
//  Created by Falguni Chauhan on 1/19/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = NYCSchoolViewModel()
    @State var schools: [NYCSchool] = []
    @State var showScoolDetailScreen: Bool = false
    @State var schoolDetailScreen: SchoolDetailScreen?

    var body: some View {
        NavigationView {
            VStack {
                Text("NYC Schools")
                    .font(.title)
                ScrollView {
                    NavigationLink(destination: schoolDetailScreen, isActive: $showScoolDetailScreen) {
                        EmptyView()
                            .hidden()
                    }
                    ForEach(schools, id: \.self) { school in
                        VStack(alignment: .leading) {
                            Text(school.school_name ?? "")
                                .font(.title3)
                                .bold()
                            Spacer()
                            Text("\(school.city ?? ""), \(school.state_code ?? ""), \(school.zip ?? "")")
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.blue)
                            Divider()
                        }
                        .padding()
                        .onTapGesture {
                            schoolDetailScreen = SchoolDetailScreen(school: school)
                            showScoolDetailScreen = true
                        }
                    }
                }
            }
            .padding()
            .onAppear {
                viewModel.getData { success in
                    if success {
                        schools = viewModel.nycSchoolData
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

