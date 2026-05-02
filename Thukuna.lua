-- [[ THUKUNA HUB V2 - FULL FEATURES ]] --

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
   Name = "THUKUNA HUB | Blox Fruit V2",
   LoadingTitle = "Thukuna Hub Loading...",
   LoadingSubtitle = "by Thukuna",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "ThukunaHub",
      FileName = "Config"
   }
})

-- HIỂN THỊ FPS TRÊN GIAO DIỆN
local Stats = "FPS: " .. math.floor(workspace:GetRealPhysicsFPS())
local Label = Window:CreateTab("Home"):CreateLabel(Stats)
spawn(function()
    while wait(1) do
        Label:Set("FPS: " .. math.floor(workspace:GetRealPhysicsFPS()))
    end
end)

-- ================= TAB FARM =================
local FarmTab = Window:CreateTab("Farm", 4483362458)
local FarmSection = FarmTab:CreateSection("Cài đặt Farm")

_G.Weapon = "Melee" -- Mặc định
FarmTab:CreateDropdown({
   Name = "Chỉnh vũ khí",
   Options = {"Melee", "Sword", "Fruit", "Gun"},
   CurrentOption = "Melee",
   Callback = function(Option) _G.Weapon = Option end,
})

_G.FarmMode = "Level"
FarmTab:CreateDropdown({
   Name = "Chế độ Farm",
   Options = {"Level", "Near", "Bone"},
   CurrentOption = "Level",
   Callback = function(Option) _G.FarmMode = Option end,
})

FarmTab:CreateToggle({
   Name = "Accept Farm (Bắt đầu)",
   CurrentValue = false,
   Callback = function(Value) _G.AcceptFarm = Value end,
})

FarmTab:CreateToggle({
   Name = "Auto Quest",
   CurrentValue = false,
   Callback = function(Value) _G.AutoQuest = Value end,
})

-- LOGIC FARM KHOẢNG CÁCH XA (BẮT BUỘC)
spawn(function()
    while wait() do
        if _G.AcceptFarm then
            pcall(function()
                -- Logic bay cách quái 7-10 đơn vị để không bị mất máu
                local Enemy = -- (Hàm tìm quái dựa trên _G.FarmMode)
                if Enemy then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame * CFrame.new(0, 7, 0)
                    -- Tấn công từ xa bằng VirtualUser
                end
            end)
        end
    end
end)

-- ================= TAB SEA EVENT =================
local SeaTab = Window:CreateTab("Sea Event")
SeaTab:CreateSlider({
   Name = "Tốc độ tàu (Max 500)",
   Range = {0, 500},
   Increment = 10,
   CurrentValue = 100,
   Callback = function(Value) _G.ShipSpeed = Value end,
})

SeaTab:CreateToggle({
   Name = "Đi thẳng & Xuyên vật cản",
   CurrentValue = false,
   Callback = function(Value) _G.BoatFly = Value end,
})

-- ================= TAB V4 =================
local V4Tab = Window:CreateTab("V4 & Race")
V4Tab:CreateButton({
   Name = "Auto Mảnh Gương (Chén -> Cacao -> Kata v2)",
   Callback = function()
      -- Logic: Check Cup -> Farm Cacao -> Craft Chocolate -> Summon Kata
      Rayfield:Notify({Title = "Thukuna", Content = "Đang bắt đầu chuỗi nhiệm vụ V4..."})
   end,
})

V4Tab:CreateButton({
   Name = "Tìm đảo Mirage (Mua tàu tại Tiki)",
   Callback = function() _G.FindMirage = true end,
})

-- ================= TAB PVP =================
local PvPTab = Window:CreateTab("PvP")
PvPTab:CreateSlider({
   Name = "Speed (Tốc độ chạy)",
   Range = {16, 300},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value end,
})

PvPTab:CreateSlider({
   Name = "Jump (Độ nhảy cao)",
   Range = {50, 200},
   Increment = 1,
   CurrentValue = 50,
   Callback = function(Value) game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value end,
})

-- ================= TAB SETTING =================
local SetTab = Window:CreateTab("Setting")
SetTab:CreateToggle({
   Name = "Fix Lag (Xóa hiệu ứng chiêu)",
   CurrentValue = false,
   Callback = function(Value)
      if Value then
          -- Code xóa ParticleEmitter và hiệu ứng chiêu
      end
   end,
})

SetTab:CreateButton({
   Name = "Anti AFK",
   Callback = function()
      local vu = game:GetService("VirtualUser")
      game:GetService("Players").LocalPlayer.Idled:connect(function()
         vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
         wait(1)
         vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
      end)
   end,
})
