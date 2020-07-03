//
//  MineSweeperView.swift
//  SwiftUISnakeApp
//
//  Created by yyjim on 2020/7/1.
//

import SwiftUI

struct MineSweeperView : View {

    @State var game = MineSweeper(rows: 17, cols: 10, numberOfBombs: 20)

    init() {}

    var body: some View {
        VStack {
            Button(action: {
                game.gameStart()
            }, label: {
                Text("     ")
                    .padding(10)
                    .background(Color(0xA9A9A9))
                    .cornerRadius(10)
                    .overlay(
                        Image(systemName: "smiley.fill")
                            .foregroundColor(Color.yellow)
                    )
            })
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: game.cols)) {
                ForEach(0..<game.rows * game.cols) { index in
                    CellView(viewModel: game.cells[index]) {
                        self.game.reveal(at: index)
                    }
                }
            }
            Spacer()
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct MineSweeperView_Previews: PreviewProvider {
    static var previews: some View {
        return MineSweeperView()
    }
}

// ===================================================================================

struct CellView: View {

    let viewModel: MineSweeper.Cell
    let tapAction: () -> Void

    var debug: Bool = false
    var isRevealed: Bool {
        debug || viewModel.revealed
    }

    var symbol: some View {
        Group {
            if isRevealed {
                switch viewModel.kind {
                case .bomb:
                    Image(systemName: "sun.max.fill")
                            .foregroundColor(.black)
                case .safeZone:
                    Image(systemName: "")
                case .dangerZone(let count):
                    Text("\(count)")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundColor(count.color)
                }
            } else {
                Image(systemName: "")
            }
        }
    }

    var body: some View {
        Button(action: tapAction,
               label: {
                Rectangle()
                    .foregroundColor(buttonForegroundColor)
                    .cornerRadius(3.0)
                    .aspectRatio(1.0, contentMode: .fit)
                    .overlay(symbol)
               }).disabled(isRevealed)
    }

    var buttonForegroundColor: Color {
        let color = isRevealed ? Color(0xFEFEFE) : Color(0xA9A9A9)
        switch viewModel.kind {
        case .bomb(let exploded):
            return exploded ? .red : color
        default:
            return color
        }
    }
}

//struct CellView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            CellView(viewModel: MineSweeper.Cell(kind: .bomb(exploded: true), revealed: true),
//                     tapAction: {})
//            CellView(viewModel: MineSweeper.Cell(kind: .safeZone, revealed: true),
//                     tapAction: {})
//            CellView(viewModel: MineSweeper.Cell(kind: .dangerZone(neighborBombs: 5), revealed: true),
//                     tapAction: {})
//        }
//    }
//}
//
