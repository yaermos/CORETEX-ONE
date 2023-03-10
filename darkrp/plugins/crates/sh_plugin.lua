PLUGIN.name = "Crates"
PLUGIN.author = "Dobytchick"
PLUGIN.description = "Crates system for 8301 with love"

if CLIENT then
    surface.CreateFont(	"codecracker", {size = 9, weight = 500, antialias = true, outline = false,  scanlines = 5, shadow = false, font = "Arial"})
    surface.CreateFont(	"codecracker_big", {size = 32,	weight = 500, antialias = true, outline = false, extended = true, scanlines = 3, shadow = false, font = "Arial"})
end

STORAGE = {}
STORAGE.CFG = {}

--[[
    НАСТРОЙКИ ПЛАГИНА
]]

STORAGE.CFG.ItemMin = 4 -- Минимальное кол-во предметов, которое может заспавниться при взломе ящика
STORAGE.CFG.ItemMax = 10 -- Максимальное кол-во предметов, которое может заспавниться при взломе ящика

STORAGE.CFG.StorageWidth = 10 -- Ширина инвентаря хранилища
STORAGE.CFG.StorageHeight = 10 -- Высота инвентаря хранилища

STORAGE.CFG.HackFactions = "Сопротивление" -- Фракция, которые могут взламывать ящик
STORAGE.CFG.SecurityFaction = "Патруль Альянса" -- Фракция, которые может обезвреживать ящик

STORAGE.CFG.HackTime = 5 -- Время взлома (в минутах)

STORAGE.CFG.ItemList = {"nova", "glock", "para", "gol", "medishot", "spas12", "grenade", "ar15", "p90",} -- Предметы, которые падают в ящике

--[[
    НАСТРОЙКИ ПЛАГИНА
]]

ix.util.Include("sv_plugin.lua")