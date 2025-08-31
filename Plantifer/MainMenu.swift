//
//  MainMenu.swift
//  Plantifer
//
//  Created by Parth Sharma on 8/21/25.
//

import SwiftUI

struct MainMenu: View {
    @State var house_plants: [PlantData] = []
    
    var body: some View {
        NavigationStack {
            HStack {
                Spacer()
                
                Text("Main Menu")
                    .font(.title)
                Spacer()
            }
            
            
            Spacer().frame(height: 50)
            
            VStack{
                
                ForEach(house_plants) { plant in Plant(plant: plant)
                }
            }
            Spacer()
            NavigationLink(destination: AddingPlant(plants: $house_plants)) {
                HStack{
                    Text("Create Plant").fontWeight(.bold).foregroundColor(.black)
                    Image(systemName: "plus").foregroundColor(.black)
                    
                }.padding()
                    .frame(maxWidth: 180, alignment: .center)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.green.opacity(0.5))
                            .shadow(radius: 10)
                    )
                    .padding(.horizontal)
            }.navigationBarBackButtonHidden(true)
        }
    }
        
    }


struct PlantData: Identifiable {
    let id = UUID()
    var title: String
    var soilMoisture: Float
    
}


struct Plant: View {
    @State var plant: PlantData
    
    var body: some View {
        NavigationStack{
            NavigationLink(destination: PlantView(plant: $plant)){
                HStack{
                    VStack(alignment: .leading, spacing: 8) {
                        Text(plant.title)
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        Text("Soil Moisture: \(plant.soilMoisture, specifier: "%.1f")%")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                    }
                    Spacer()
                    if plant.soilMoisture < 11 {
                        VStack{
                            Image(systemName:"exclamationmark.triangle.fill")
                            Spacer().frame(height: 5)
                            Text("Moisture Low").font(.caption)
                        }.foregroundColor(.red)
                    }
                }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.yellow.opacity(0.5))
                            .shadow(radius: 10)
                        
                    )
                    .padding(.horizontal)
                
                    
            }
            }
    }
}

struct PlantView: View {
    @Binding var plant: PlantData
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            // Header Section
            VStack(spacing: 16) {
                // Plant Icon
                Image(systemName: "leaf.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.green, .mint],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: .green.opacity(0.3), radius: 8, x: 0, y: 4)
                
                // Current Plant Name Display
                Text(plant.title.isEmpty ? "My Plant" : plant.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 20)
            
            // Edit Section
            VStack(alignment: .leading, spacing: 12) {
                Text("Plant Name")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                
                TextField("Enter plant name", text: $plant.title)
                    .focused($isTextFieldFocused)
                    .font(.body)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(
                                        isTextFieldFocused ? Color.green : Color.clear,
                                        lineWidth: 2
                                    )
                            )
                    )
                    .overlay(
                        // Clear button
                        HStack {
                            Spacer()
                            if !plant.title.isEmpty {
                                Button(action: {
                                    plant.title = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.secondary)
                                        .font(.title3)
                                }
                                .padding(.trailing, 12)
                            }
                        }
                    )
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
                .padding(.bottom, 20)
                .onTapGesture {
                    isTextFieldFocused = false
                }
        }
    }
}

struct AddingPlant: View {
    @State private var newPlantName: String = ""
    @Binding public var plants: [PlantData]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack{
            Button("Take a picture", systemImage: "camera"){}
            Spacer().frame(height: 33)
            HStack{
                TextField("Enter plant name", text: $newPlantName)
                    .font(.body)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                    )
            }.padding(.trailing,15).padding(.leading,15)
            Spacer()
            Button("Add Plant"){
                if newPlantName != ""{
                    plants.append(PlantData(title:newPlantName,soilMoisture:10.3))
                }
                dismiss()
            }
        }
        
        
    }
}

#Preview {
    MainMenu(house_plants: [PlantData(title:"Rose",soilMoisture: 12.7)] )
}
