//
//  ContentView.swift
//  FoodPicker
//
//  Created by Jane Chao on 22/09/14.
//

import SwiftUI


struct ContentView: View {
    let food = Food.examples
    @State private var selectedFood: Food?
    @State private var showInfo: Bool = false
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Group {
                    if selectedFood != .none {
                        Text(selectedFood!.image)
                            .font(.system(size: 200))
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                    } else {
                        Image("dinner")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                    }
                }
                .frame(height:250)
                .border(.blue)
                
                
                Text("今天吃什麼？").bold()
                
                if selectedFood != .none {
                    HStack {
                        Text(selectedFood!.name)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.green)
                            .id(selectedFood!.name)
                            .transition(.asymmetric(
                                insertion: .opacity
                                    .animation(.easeInOut(duration: 0.5).delay(0.2)),
                                removal: .opacity
                                    .animation(.easeInOut(duration: 0.4))))
                        Button {
                            showInfo.toggle()
                        } label: {
                            Image(systemName: "info.square").foregroundColor(.secondary)
                        }.buttonStyle(.plain)

                    }
                    
                    Text("热量 \(selectedFood!.calorie.formatted()) 大卡")
                    
                    VStack {
                        if showInfo {
                            Grid(horizontalSpacing:12, verticalSpacing: 12) {
                                Group {
                                    GridRow {
                                        Text("蛋白质")
                                        Text("脂肪")
                                        Text("碳水")
                                    }
                                    
                                    Divider()
                                        .gridCellUnsizedAxes(.horizontal)
                                        .padding(.horizontal, -10)
                                    
                                    GridRow {
                                        Text(selectedFood!.protein.formatted() + " g")
                                        Text(selectedFood!.fat.formatted() + " g")
                                        Text(selectedFood!.carb.formatted() + " g")
                                    }
                                }.foregroundColor(Color(.black))
                            }
                            .font(.title3)
                            .padding(.horizontal)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)).foregroundColor(Color(.systemBackground))
                            .transition(.move(edge: .top).combined(with: .opacity))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .clipped(antialiased: true)
                    
                }
                
                Spacer().layoutPriority(1)
                
                Button {
                    selectedFood = food.shuffled().first { $0 != selectedFood }
                } label: {
                    Text(selectedFood == .none ? "告訴我" : "換一個").frame(width: 200)
                        .animation(.none, value: selectedFood)
                        .transformEffect(.identity)
                }.padding(.bottom, -15)
                
                Button {
                    selectedFood = .none
                } label: {
                    Text("重置").frame(width: 200)
                }.buttonStyle(.bordered)
            }
            .padding()
            .frame(maxWidth:.infinity, minHeight: UIScreen.main.bounds.height - 100)
            .background(Color(.secondarySystemBackground))
            .font(.title)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .animation(.spring(dampingFraction: 0.55), value: showInfo)
            .animation(.easeInOut(duration: 0.6), value: selectedFood)
        }.background(Color(.secondarySystemBackground))
    }
}

extension ContentView {
    init(selectFood: Food) {
        _selectedFood = State(wrappedValue: selectFood)
    }
}

extension PreviewDevice {
    static let iPhoneSE = PreviewDevice(rawValue: "iPhone SE (3rd generation)")
    static let iPad = PreviewDevice(rawValue: "iPad Pro (12.9-inch) (5th generation)")
    static let iPhone12mini = PreviewDevice(rawValue: "iPhone 12 mini")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView()
        ContentView(selectFood: .examples.first!).previewDevice(.iPad)
//        ContentView(selectFood: .examples.first!).previewDevice(.iPhoneSE)
        
    }
}
