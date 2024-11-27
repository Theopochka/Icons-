local sampev = require("lib.samp.events")
local ffi = require("ffi")

local fa = require("fAwesome6_solid")
local imgui = require 'mimgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

local new = imgui.new

title = ""
text = ""
button1 = ""
button2 = ""
dialogID = ""

local statsrender = new.bool()
local windowmm = new.bool()


function sampev.onShowDialog(did, style, dialogTitle, b1, b2, dialogText) 
    sampAddChatMessage(did, -1)
    if did == 0 then
        title = dialogTitle
        text = dialogText
        button1 = b1
        button2 = b2
        dialogID = did

        statsrender[0] = true
        return false   
    end
    if did == 722 then
        windowmm[0] = true
        return false
    end
end

imgui.OnInitialize(function()
    imgui.GetIO().IniFilename = nil
    fa.Init(15)
    xey()
end)

function removeColorCodes(str)
    return str:gsub("{%x%x%x%x%x%x}", "")
end

local dark_grey = imgui.OnFrame(
    function() return statsrender[0] end,
    function(player)
        local resX, resY = getScreenResolution()
        imgui.SetNextWindowPos(imgui.ImVec2(resX / 2, resY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        if imgui.Begin(u8'stats', statsrender, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoMove) then
            if title ~= "" and text ~= "" then
                imgui.TextColoredRGB(text)
                imgui.SetCursorPosX(100)
                 
                if imgui.Button(u8(button1), imgui.ImVec2(70 * MONET_DPI_SCALE)) then 
                    sampSendDialogResponse(dialogID, 0, nil, nil)
                end
                imgui.SameLine()
                if imgui.Button(u8(button2), imgui.ImVec2(70 * MONET_DPI_SCALE)) then 
                    statsrender[0] = false
                end
            else
                imgui.Text(u8("Нет данных для отображения."))
            end

            imgui.End()
        end
    end
)

local xey = imgui.OnFrame(
    function() return windowmm[0] end,
    function(player)
        local resX, resY = getScreenResolution()
        imgui.SetNextWindowPos(imgui.ImVec2(resX / 2, resY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        if imgui.Begin(u8'', windowmm, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoMove) then
            if imgui.Button(fa.USER..u8" Персонаж", imgui.ImVec2(123 * MONET_DPI_SCALE, 120 * MONET_DPI_SCALE)) then
                sampSendDialogResponse(722, 1, 0, nil)
                windowmm[0] = false
            end
            imgui.PopFont()
            imgui.SameLine()
            if imgui.Button(fa.HAMMER..u8" Хелп меню", imgui.ImVec2(123 * MONET_DPI_SCALE, 120 * MONET_DPI_SCALE)) then
                sampSendDialogResponse(722, 1, 1, nil)
                windowmm[0] = false
            end            
            imgui.SameLine()
            if imgui.Button(fa.BUG..u8" Репорт", imgui.ImVec2(123 * MONET_DPI_SCALE, 120 * MONET_DPI_SCALE)) then
                sampSendChat("/rep")
                windowmm[0] = false
            end
            imgui.SameLine()
            if imgui.Button(fa.CIRCLE_INFO..u8" Хелп меню", imgui.ImVec2(123 * MONET_DPI_SCALE, 120 * MONET_DPI_SCALE)) then
                sampSendChat("/help")
                windowmm[0] = false
            end
            imgui.SameLine()
            if imgui.Button(fa.GEARS..u8" Настройки", imgui.ImVec2(123 * MONET_DPI_SCALE, 120 * MONET_DPI_SCALE)) then
                sampSendChat("/settings")
                windowmm[0] = false
            end
            imgui.SameLine()
            if imgui.Button(fa.MONEY_CHECK..u8" Донат", imgui.ImVec2(123 * MONET_DPI_SCALE, 120 * MONET_DPI_SCALE)) then
                sampSendChat("/donate")
                windowmm[0] = false
            end
            -- нижния полоска
            if imgui.Button(fa.PHONE..u8" Телефон", imgui.ImVec2(123 * MONET_DPI_SCALE, 120 * MONET_DPI_SCALE)) then
                sampSendChat("/phone")
                windowmm[0] = false
            end
            imgui.SameLine()
            if imgui.Button(fa.USERS..u8" История ников", imgui.ImVec2(123 * MONET_DPI_SCALE, 120 * MONET_DPI_SCALE)) then
                sampSendDialogResponse(722, 1, 7, nil)
                windowmm[0] = false
            end
            imgui.SameLine()
            if imgui.Button(fa.USER_SECRET..u8" Наказания", imgui.ImVec2(123 * MONET_DPI_SCALE, 120 * MONET_DPI_SCALE)) then
                sampSendDialogResponse(722, 1, 8, nil)
                windowmm[0] = false
            end
            imgui.SameLine()
            if imgui.Button(fa.CROWN..u8" Премиум игроки", imgui.ImVec2(123 * MONET_DPI_SCALE, 120 * MONET_DPI_SCALE)) then
                sampSendDialogResponse(722, 1, 9, nil)
                windowmm[0] = false
            end
            imgui.SameLine()
            if imgui.Button(fa.WALLET..u8" Промо-код", imgui.ImVec2(123 * MONET_DPI_SCALE, 120 * MONET_DPI_SCALE)) then
                sampSendDialogResponse(722, 1, 10, nil)
                windowmm[0] = false
            end
            imgui.SameLine()
            if imgui.Button(fa.CROWN..u8" VIP Статус", imgui.ImVec2(123 * MONET_DPI_SCALE, 120 * MONET_DPI_SCALE)) then
                sampSendDialogResponse(722, 1, 11, nil)
                windowmm[0] = false
            end
            if imgui.Button(fa.XMARK..u8" Закрыть", imgui.ImVec2(778 * MONET_DPI_SCALE, 20 * MONET_DPI_SCALE)) then
                windowmm[0] = false
            end
            imgui.End()
        end
    end
)

function main()
    while not isSampAvailable() do wait(0) end
    wait(-1)
end
function imgui.TextColoredRGB(text)
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4
    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end
    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImVec4(r/255, g/255, b/255, a/255)
    end
    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else imgui.Text(u8(w)) end
        end
    end
    render_text(text)
end
function xey()
    local style = imgui.GetStyle();
    local colors = style.Colors;
    style.Alpha = 1;
    style.WindowPadding = imgui.ImVec2(8.00, 8.00);
    style.WindowRounding = 12;
    style.WindowBorderSize = 1;
    style.WindowMinSize = imgui.ImVec2(32.00, 32.00);
    style.WindowTitleAlign = imgui.ImVec2(0.50, 0.50);
    style.ChildRounding = 11;
    style.ChildBorderSize = 1;
    style.PopupRounding = 12;
    style.PopupBorderSize = 1;
    style.FramePadding = imgui.ImVec2(4.00, 3.00);
    style.FrameRounding = 12;
    style.FrameBorderSize = 0;
    style.ItemSpacing = imgui.ImVec2(8.00, 4.00);
    style.ItemInnerSpacing = imgui.ImVec2(4.00, 4.00);
    style.IndentSpacing = 21;
    style.ScrollbarSize = 14;
    style.ScrollbarRounding = 12;
    style.GrabMinSize = 10;
    style.GrabRounding = 8;
    style.TabRounding = 12;

    style.ButtonTextAlign = imgui.ImVec2(0.50, 0.50);
    style.SelectableTextAlign = imgui.ImVec2(0.00, 0.00);
    colors[imgui.Col.Text] = imgui.ImVec4(1.00, 1.00, 1.00, 1.00);
    colors[imgui.Col.TextDisabled] = imgui.ImVec4(0.50, 0.50, 0.50, 1.00);
    colors[imgui.Col.WindowBg] = imgui.ImVec4(0.60, 0.56, 0.45, 1.00);
    colors[imgui.Col.ChildBg] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00);
    colors[imgui.Col.PopupBg] = imgui.ImVec4(0.08, 0.08, 0.08, 0.94);
    colors[imgui.Col.Border] = imgui.ImVec4(0.00, 0.00, 0.00, 0.50);
    colors[imgui.Col.BorderShadow] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00);
    colors[imgui.Col.FrameBg] = imgui.ImVec4(0.29, 0.27, 0.19, 0.54);
    colors[imgui.Col.FrameBgHovered] = imgui.ImVec4(0.26, 0.59, 0.98, 0.40);
    colors[imgui.Col.FrameBgActive] = imgui.ImVec4(0.26, 0.59, 0.98, 0.67);
    colors[imgui.Col.TitleBg] = imgui.ImVec4(0.32, 0.29, 0.21, 1.00);
    colors[imgui.Col.TitleBgActive] = imgui.ImVec4(0.37, 0.34, 0.25, 1.00);
    colors[imgui.Col.TitleBgCollapsed] = imgui.ImVec4(0.00, 0.00, 0.00, 0.51);
    colors[imgui.Col.MenuBarBg] = imgui.ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[imgui.Col.ScrollbarBg] = imgui.ImVec4(0.02, 0.02, 0.02, 0.53);
    colors[imgui.Col.ScrollbarGrab] = imgui.ImVec4(0.31, 0.31, 0.31, 1.00);
    colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.41, 0.41, 0.41, 1.00);
    colors[imgui.Col.ScrollbarGrabActive] = imgui.ImVec4(0.51, 0.51, 0.51, 1.00);
    colors[imgui.Col.CheckMark] = imgui.ImVec4(0.76, 0.72, 0.60, 1.00);
    colors[imgui.Col.SliderGrab] = imgui.ImVec4(0.24, 0.52, 0.88, 1.00);
    colors[imgui.Col.SliderGrabActive] = imgui.ImVec4(0.26, 0.59, 0.98, 1.00);
    colors[imgui.Col.Button] = imgui.ImVec4(0.40, 0.35, 0.28, 1.00);
    colors[imgui.Col.ButtonHovered] = imgui.ImVec4(0.70, 0.65, 0.50, 1.00);
    colors[imgui.Col.ButtonActive] = imgui.ImVec4(0.80, 0.75, 0.60, 1.00);
    colors[imgui.Col.Header] = imgui.ImVec4(0.26, 0.59, 0.98, 0.31);
    colors[imgui.Col.HeaderHovered] = imgui.ImVec4(0.26, 0.59, 0.98, 0.80);
    colors[imgui.Col.HeaderActive] = imgui.ImVec4(0.26, 0.59, 0.98, 1.00);
    colors[imgui.Col.Separator] = imgui.ImVec4(0.43, 0.43, 0.50, 0.50);
    colors[imgui.Col.SeparatorHovered] = imgui.ImVec4(0.10, 0.40, 0.75, 0.78);
    colors[imgui.Col.SeparatorActive] = imgui.ImVec4(0.10, 0.40, 0.75, 1.00);
    colors[imgui.Col.ResizeGrip] = imgui.ImVec4(0.26, 0.59, 0.98, 0.25);
    colors[imgui.Col.ResizeGripHovered] = imgui.ImVec4(0.26, 0.59, 0.98, 0.67);
    colors[imgui.Col.ResizeGripActive] = imgui.ImVec4(0.26, 0.59, 0.98, 0.95);
    colors[imgui.Col.Tab] = imgui.ImVec4(0.18, 0.35, 0.58, 0.86);
    colors[imgui.Col.TabHovered] = imgui.ImVec4(0.26, 0.59, 0.98, 0.80);
    colors[imgui.Col.TabActive] = imgui.ImVec4(0.20, 0.41, 0.68, 1.00);
    colors[imgui.Col.TabUnfocused] = imgui.ImVec4(0.07, 0.10, 0.15, 0.97);
    colors[imgui.Col.TabUnfocusedActive] = imgui.ImVec4(0.14, 0.26, 0.42, 1.00);
    colors[imgui.Col.PlotLines] = imgui.ImVec4(0.61, 0.61, 0.61, 1.00);
    colors[imgui.Col.PlotLinesHovered] = imgui.ImVec4(1.00, 0.43, 0.35, 1.00);
    colors[imgui.Col.PlotHistogram] = imgui.ImVec4(0.90, 0.70, 0.00, 1.00);
    colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(1.00, 0.60, 0.00, 1.00);
    colors[imgui.Col.TextSelectedBg] = imgui.ImVec4(0.26, 0.59, 0.98, 0.35);
    colors[imgui.Col.DragDropTarget] = imgui.ImVec4(1.00, 1.00, 0.00, 0.90);
    colors[imgui.Col.NavHighlight] = imgui.ImVec4(0.26, 0.59, 0.98, 1.00);
    colors[imgui.Col.NavWindowingHighlight] = imgui.ImVec4(1.00, 1.00, 1.00, 0.70);
    colors[imgui.Col.NavWindowingDimBg] = imgui.ImVec4(0.80, 0.80, 0.80, 0.20);
    colors[imgui.Col.ModalWindowDimBg] = imgui.ImVec4(0.80, 0.80, 0.80, 0.35);
end

function dark_grey()
    local style = imgui.GetStyle();
    local colors = style.Colors;
    style.Alpha = 1;
    style.WindowPadding = imgui.ImVec2(8.00, 8.00);
    style.WindowRounding = 7;
    style.WindowBorderSize = 0;
    style.WindowMinSize = imgui.ImVec2(32.00, 32.00);
    style.WindowTitleAlign = imgui.ImVec2(0.00, 0.50);
    style.ChildRounding = 12;
    style.ChildBorderSize = 1;
    style.PopupRounding = 0;
    style.PopupBorderSize = 0;
    style.FramePadding = imgui.ImVec2(4.00, 3.00);
    style.FrameRounding = 12;
    style.FrameBorderSize = 1;
    style.ItemSpacing = imgui.ImVec2(8.00, 4.00);
    style.ItemInnerSpacing = imgui.ImVec2(4.00, 4.00);
    style.IndentSpacing = 21;
    style.ScrollbarSize = 14;
    style.ScrollbarRounding = 12;
    style.GrabMinSize = 10;
    style.GrabRounding = 12;
    style.TabRounding = 9;
    style.ButtonTextAlign = imgui.ImVec2(0.50, 0.50);
    style.SelectableTextAlign = imgui.ImVec2(0.00, 0.00);
    colors[imgui.Col.Text] = imgui.ImVec4(1.00, 1.00, 1.00, 1.00);
    colors[imgui.Col.TextDisabled] = imgui.ImVec4(0.50, 0.50, 0.50, 1.00);
    colors[imgui.Col.WindowBg] = imgui.ImVec4(0.09, 0.09, 0.09, 1.00);
    colors[imgui.Col.ChildBg] = imgui.ImVec4(0.13, 0.13, 0.13, 1.00);
    colors[imgui.Col.PopupBg] = imgui.ImVec4(0.12, 0.12, 0.12, 1.00);
    colors[imgui.Col.Border] = imgui.ImVec4(0.19, 0.19, 0.19, 1.00);
    colors[imgui.Col.BorderShadow] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00);
    colors[imgui.Col.FrameBg] = imgui.ImVec4(0.08, 0.08, 0.08, 0.54);
    colors[imgui.Col.FrameBgHovered] = imgui.ImVec4(0.16, 0.16, 0.16, 0.54);
    colors[imgui.Col.FrameBgActive] = imgui.ImVec4(0.17, 0.17, 0.17, 0.54);
    colors[imgui.Col.TitleBg] = imgui.ImVec4(0.21, 0.21, 0.21, 1.00);
    colors[imgui.Col.TitleBgActive] = imgui.ImVec4(0.37, 0.37, 0.37, 1.00);
    colors[imgui.Col.TitleBgCollapsed] = imgui.ImVec4(0.00, 0.00, 0.00, 0.51);
    colors[imgui.Col.MenuBarBg] = imgui.ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[imgui.Col.ScrollbarBg] = imgui.ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[imgui.Col.ScrollbarGrab] = imgui.ImVec4(0.18, 0.18, 0.18, 1.00);
    colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.18, 0.18, 0.18, 1.00);
    colors[imgui.Col.ScrollbarGrabActive] = imgui.ImVec4(0.36, 0.36, 0.36, 1.00);
    colors[imgui.Col.CheckMark] = imgui.ImVec4(1.00, 1.00, 1.00, 1.00);
    colors[imgui.Col.SliderGrab] = imgui.ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[imgui.Col.SliderGrabActive] = imgui.ImVec4(0.37, 0.37, 0.37, 1.00);
    colors[imgui.Col.Button] = imgui.ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[imgui.Col.ButtonHovered] = imgui.ImVec4(0.37, 0.37, 0.37, 1.00);
    colors[imgui.Col.ButtonActive] = imgui.ImVec4(0.37, 0.37, 0.37, 1.00);
    colors[imgui.Col.Header] = imgui.ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[imgui.Col.HeaderHovered] = imgui.ImVec4(0.37, 0.37, 0.37, 1.00);
    colors[imgui.Col.HeaderActive] = imgui.ImVec4(0.37, 0.37, 0.37, 1.00);
    colors[imgui.Col.Separator] = imgui.ImVec4(0.71, 0.71, 0.71, 1.00);
    colors[imgui.Col.SeparatorHovered] = imgui.ImVec4(0.71, 0.71, 0.71, 1.00);
    colors[imgui.Col.SeparatorActive] = imgui.ImVec4(0.71, 0.71, 0.71, 1.00);
    colors[imgui.Col.ResizeGrip] = imgui.ImVec4(0.71, 0.71, 0.71, 1.00);
    colors[imgui.Col.ResizeGripHovered] = imgui.ImVec4(0.48, 0.48, 0.48, 1.00);
    colors[imgui.Col.ResizeGripActive] = imgui.ImVec4(0.48, 0.48, 0.48, 1.00);
    colors[imgui.Col.Tab] = imgui.ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[imgui.Col.TabHovered] = imgui.ImVec4(0.37, 0.37, 0.37, 1.00);
    colors[imgui.Col.TabActive] = imgui.ImVec4(0.37, 0.37, 0.37, 1.00);
    colors[imgui.Col.TabUnfocused] = imgui.ImVec4(0.07, 0.10, 0.15, 0.97);
    colors[imgui.Col.TabUnfocusedActive] = imgui.ImVec4(0.14, 0.26, 0.42, 1.00);
    colors[imgui.Col.PlotLines] = imgui.ImVec4(0.61, 0.61, 0.61, 1.00);
    colors[imgui.Col.PlotLinesHovered] = imgui.ImVec4(1.00, 0.43, 0.35, 1.00);
    colors[imgui.Col.PlotHistogram] = imgui.ImVec4(0.90, 0.70, 0.00, 1.00);
    colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(1.00, 0.60, 0.00, 1.00);
    colors[imgui.Col.TextSelectedBg] = imgui.ImVec4(0.26, 0.59, 0.98, 0.35);
    colors[imgui.Col.DragDropTarget] = imgui.ImVec4(1.00, 1.00, 0.00, 0.90);
    colors[imgui.Col.NavHighlight] = imgui.ImVec4(0.26, 0.59, 0.98, 1.00);
    colors[imgui.Col.NavWindowingHighlight] = imgui.ImVec4(1.00, 1.00, 1.00, 0.70);
    colors[imgui.Col.NavWindowingDimBg] = imgui.ImVec4(0.80, 0.80, 0.80, 0.20);
    colors[imgui.Col.ModalWindowDimBg] = imgui.ImVec4(0.80, 0.80, 0.80, 0.35);
    end
