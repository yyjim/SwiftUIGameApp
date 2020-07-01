//
//  MineSweeper.swift
//  SwiftUISnakeApp
//
//  Created by yyjim on 2020/7/1.
//

import Foundation

struct MineSweeper {

    let rows: Int
    let cols: Int
    let numberOfBombs: Int

    var cells: [Cell] = []

    struct Cell {
        enum Kind {
            case bomb(exploded: Bool)
            case safeZone
            case dangerZone(neighborBombs: Int)
        }

        var kind: Kind
        var revealed: Bool = false
    }

    init(rows: Int, cols: Int, numberOfBombs: Int) {
        self.rows = rows
        self.cols = cols
        self.numberOfBombs = numberOfBombs
        assert(numberOfBombs < rows * cols)

        cells = makeCells()
    }

    mutating func reveal(at index: Int) {
        if cells[index].revealed {
            return
        }

        cells[index].revealed = true

        switch cells[index].kind {
        case .dangerZone:
            break
        case .bomb:
            cells[index].kind = .bomb(exploded: true)
            gameover()
        case .safeZone:
            // flood fill
            neighbors(of: index).forEach {
                switch cells[$0].kind {
                case .bomb:
                    break
                default:
                    reveal(at: $0)
                }
            }
        }
    }

    mutating func gameStart() {
        cells = makeCells()
    }

    mutating func gameover() {
        (0..<cells.count).forEach { cells[$0].revealed = true }
    }

    private func makeCells() -> [Cell] {

        // Initialize cells
        let count = rows * cols
        var cells = Array(repeating: Cell(kind: .safeZone), count: count)

        // Insert bombs
        let bombIndexes = Array(0..<count)
            .shuffled()
            .prefix(numberOfBombs)
        bombIndexes.forEach { index in
            cells[index].kind = .bomb(exploded: false)
        }

        // Calculate dangerZone
        bombIndexes.forEach { index in
            let neighborIndexes = neighbors(of: index)
            neighborIndexes.forEach { x in
                let kind = cells[x].kind
                cells[x].kind = {
                    switch kind {
                    case .safeZone:
                        return .dangerZone(neighborBombs: 1)
                    case .dangerZone(let count):
                        return .dangerZone(neighborBombs: count + 1)
                    default:
                        return kind
                    }
                }()
            }
        }

        return cells
    }

    private func xy(of index: Int) -> (x: Int, y: Int) {
        let cx = Int(index % cols)
        let cy = Int(index / cols)
        return (x: cx, y: cy)
    }

    private func neighbors(of index: Int) -> [Int] {
        let (cx, cy) = xy(of: index)

        let minX = max(0, cx - 1)
        let maxX = min(cols - 1, cx + 1)
        let minY = max(0, cy - 1)
        let maxY = min(rows - 1, cy + 1)

        return (minX...maxX).flatMap { x -> [Int] in
            return (minY...maxY).compactMap { y -> Int? in
                if x == cx, y == cy {
                    return nil
                }
                return y * cols + x
            }
        }
    }

}
