const std = @import("std");
const log = std.log;
const panic = std.debug.panic;

const input = @embedFile("input0");

pub fn main() !void {
    var it = std.mem.tokenize(u8, input, "\n");

    var value: i128 = 0;
    var aim: i128 = 0;
    var position: i128 = 0;
    var depth: i128 = 0;
    while (it.next()) |line| {
        var tokens = std.mem.tokenize(u8, line, " ");
        const command = tokens.next() orelse panic("Invalid input line: '{s}'", .{line});
        const value_buf = tokens.next() orelse panic("Invalid input line: '{s}'", .{line});

        value = try std.fmt.parseInt(i128, value_buf, 10);
        if (value < 0) {
            panic("Value must be positive: '{}'", .{value});
        }

        log.info("{s} {}", .{ command, value });
        if (std.mem.eql(u8, command, "forward")) {
            position += value;
            depth += aim * value;
        } else if (std.mem.eql(u8, command, "down")) {
            aim += value;
        } else if (std.mem.eql(u8, command, "up")) {
            aim -= value;
        }

        if (aim < 0) {
            panic("Aim cannot go below 0", .{});
        }
        if (depth < 0) {
            panic("Depth cannot go above 0", .{});
        }
    }
    log.info("Result: {}", .{position * depth});
}
