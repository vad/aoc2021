const std = @import("std");
const log = std.log;
const panic = std.debug.panic;
const tokenize = std.mem.tokenize;
const parseInt = std.fmt.parseInt;

const input = @embedFile("input1");

const MarkableNumber = struct {
    number: u32,
    marked: bool,
};
const Board = struct {
    numbers: [5][5]MarkableNumber = undefined,
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var alloc = gpa.allocator();

    const L = std.ArrayList(Board);

    var boards = L.init(alloc);
    var first_line: []const u8 = undefined;
    {
        var it = tokenize(u8, input, "\n");

        first_line = it.next().?;
        var i: u8 = 0;
        var board: *Board = undefined;
        while (it.next()) |line| : (i += 1) {
            i %= 5;
            if (i == 0) {
                board = try boards.addOne();
            }
            log.info("Line: {s}", .{line});

            var board_line_it = tokenize(u8, line, " ");
            var j: u8 = 0;
            while (j < 5) : (j += 1) {
                board.numbers[i][j] = .{ .number = try parseInt(u32, board_line_it.next().?, 10), .marked = false };
            }
            // log.info("Board lines: {}", .{board_lines.items.len});
        }
    }

    {
        var numbers = tokenize(u8, first_line, ",");
        extr: while (numbers.next()) |estratto| {
            const ue = try parseInt(u32, estratto, 10);
            log.info("Extracted number: {}", .{ue});

            for (boards.items) |*board| {
                var i: u8 = 0;
                while (i < 5) : (i += 1) {
                    var j: u8 = 0;
                    var solved: bool = true;

                    while (j < 5) : (j += 1) {
                        var cell = &board.numbers[i][j];
                        // log.info("Current number: {}", .{cell.number});
                        if (cell.number == ue) {
                            // log.info("Match found: {} == {}", .{ cell.number, ue });
                            cell.marked = true;
                        }
                        if (!cell.marked) {
                            solved = false;
                        }
                    }

                    if (solved) {
                        var sum: usize = 0;
                        var k: u8 = 0;
                        while (k < 5) : (k += 1) {
                            var l: u8 = 0;

                            while (l < 5) : (l += 1) {
                                var cell = &board.numbers[k][l];
                                if (!cell.marked) {
                                    sum += cell.number;
                                }
                            }
                        }
                        log.info("Bingo! Sum: {}, number: {}, Result: {}", .{ sum, ue, sum * ue });
                        break :extr;
                    }
                }
            }
        }
    }
}
