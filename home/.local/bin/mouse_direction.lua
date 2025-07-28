#!/bin/lua

local function set_mouse_direction(direction)
    if direction ~= 'left' and direction ~= 'right' then
        print('Invalid argument, only "left" or "right" valid')
        return
    end

    local direction_string = '1 2 3'

    if direction == 'left' then
        direction_string = '3 2 1'
    end

    os.execute("xmodmap -e 'pointer = " .. direction_string .. "'")
end

if #arg < 1 then
    print("Usage: lua invert_mouse.lua [left|right]")
else
    set_mouse_direction(arg[1])
end
