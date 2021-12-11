const std = @import("std");
const input = @embedFile("input1");

pub fn parse(optional_line: ?[]const u8) !i128 {
    if (optional_line) |line| {
        return try std.fmt.parseInt(i128, line, 10);
    }
    std.process.exit(1);
}

pub fn main() anyerror!void {
    var it = std.mem.tokenize(u8, input, "\n");

    var counter: u64 = 0;
    var prev_3 = try parse(it.next());
    var prev_2 = try parse(it.next());
    var prev_1 = try parse(it.next());
    while (it.next()) |line| {
        var current = try parse(line);
        if (current > prev_3) {
            counter += 1;
        }
        prev_3 = prev_2;
        prev_2 = prev_1;
        prev_1 = current;
    }
    std.log.info("Result: {}", .{counter});
}
