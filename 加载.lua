hookfunction(getnamecallmethod, function()
    return
end)

for i, v in pairs({request, loadstring, base64.decode}) do
    if isfunctionhooked(v) or not isfunctionhooked(getnamecallmethod) then
        return
    end
end

pcall(function()
    local HttpService = game:GetService("HttpService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    local function GetAsset(v)
        local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
        return HttpService:JSONDecode(request({
            Url = v,
            Headers = {
                Authorization = "Bearer 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"
            }
        }).Body).content:gsub('[^'..b..'=]', ''):gsub('.', function(x)
            if (x == '=') then return '' end
            local r,f='',(b:find(x)-1)
            for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
            return r;
        end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
            if (#x ~= 8) then return '' end
            local c=0
            for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
            return string.char(c)
        end)
    end
	if (HttpService:JSONDecode(GetAsset("https://api.github.com/repos/AlienX-Script/AlienX/contents/ID/index.json?ref=main"))[LocalPlayer.Name] == LocalPlayer.UserId) then
		local Players = game:GetService("Players");
		local player = Players.LocalPlayer;
		local username = player.Name;
		local Sound = Instance.new("Sound", workspace);
		Sound.SoundId = "rbxassetid://500472891";
		Sound.PlayOnRemove = true;
		Sound:Destroy();
		game.StarterGui:SetCore("SendNotification", {Title="我我",Text=("欢迎尊贵的我我用户: " .. username),Icon="rbxassetid://96305381714766"});
		wait(1.5);
		local Sound = Instance.new("Sound", workspace);
		Sound.SoundId = "rbxassetid://500472891";
		Sound.PlayOnRemove = true;
		Sound:Destroy();
		game.StarterGui:SetCore("SendNotification", {Title="我我",Text="正在启动脚本中..",Icon="rbxassetid://96305381714766"});
		wait(1.5);
		if ((game.GameId == 8888615802) or (game.GameId == 13622981808)) then
			loadstring(game:HttpGet(""))();
		elseif (game.GameId == 2820580801) then
			local Sound = Instance.new("Sound", workspace);
			Sound.SoundId = "rbxassetid://87437544236708";
			Sound.PlayOnRemove = true;
			Sound:Destroy();
			game.StarterGui:SetCore("SendNotification", {Title="我我",Text="正在打开俄亥俄州脚本",Icon="rbxassetid://96305381714766"});
			local Library = loadstring(GetAsset("https://api.github.com/repos/AlienX-Script/AlienX/contents/AlienX-Script/A-Ohio?ref=main"))();
			local Sound = Instance.new("Sound", workspace);
			Sound.SoundId = "rbxassetid://87437544236708";
			Sound.PlayOnRemove = true;
			Sound:Destroy();
			game.StarterGui:SetCore("SendNotification", {Title="我我",Text="俄亥俄州启动成功",Icon="rbxassetid://96305381714766"});
		elseif (game.GameId == 4777817887) then
			local Sound = Instance.new("Sound", workspace);
			Sound.SoundId = "rbxassetid://87437544236708";
			Sound.PlayOnRemove = true;
			Sound:Destroy();
			game.StarterGui:SetCore("SendNotification", {Title="我我",Text="正在打开Blade Ball脚本",Icon="rbxassetid://96305381714766"});
			local Library = loadstring(GetAsset("https://api.github.com/repos/AlienX-Script/AlienX/contents/AlienX-Script/A-BladeBall?ref=main"))();
			local Sound = Instance.new("Sound", workspace);
			Sound.SoundId = "rbxassetid://87437544236708";
			Sound.PlayOnRemove = true;
			Sound:Destroy();
			game.StarterGui:SetCore("SendNotification", {Title="我我",Text="Blade Ball启动成功",Icon="rbxassetid://96305381714766"});
		elseif (game.GameId == 1526814825) then
			game.StarterGui:SetCore("SendNotification", {Title="我我",Text="正在打开战争大亨脚本",Icon="rbxassetid://96305381714766"});
			local Library = loadstring(GetAsset("https://api.github.com/repos/AlienX-Script/AlienX/contents/AlienX-Script/A-WarTycoon"))();
			local Sound = Instance.new("Sound", workspace);
			Sound.SoundId = "rbxassetid://87437544236708";
			Sound.PlayOnRemove = true;
			Sound:Destroy();
			game.StarterGui:SetCore("SendNotification", {Title="我我",Text="战争大亨启动成功",Icon="rbxassetid://96305381714766"});
               elseif (game.GameId == 1335695570) then
			game.StarterGui:SetCore("SendNotification", {Title="我我",Text="正在打开忍者传奇脚本",Icon="rbxassetid://96305381714766"});
			local Library = loadstring(GetAsset("https://api.github.com/repos/AlienX-Script/AlienX/contents/AlienX-Script/A-NinjaLegends"))();
			local Sound = Instance.new("Sound", workspace);
			Sound.SoundId = "rbxassetid://87437544236708";
			Sound.PlayOnRemove = true;
			Sound:Destroy();
			game.StarterGui:SetCore("SendNotification", {Title="我我",Text="忍者传奇启动成功",Icon="rbxassetid://96305381714766"});
               elseif (game.GameId == 7326934954) then
			game.StarterGui:SetCore("SendNotification", {Title="我我",Text="正在打开森林中的99夜",Icon="rbxassetid://96305381714766"});
			local Library = loadstring(GetAsset("https://api.github.com/repos/AlienX-Script/AlienX/contents/AlienX-Script/A-99night"))();
			local Sound = Instance.new("Sound", workspace);
			Sound.SoundId = "rbxassetid://87437544236708";
			Sound.PlayOnRemove = true;
			Sound:Destroy();
			game.StarterGui:SetCore("SendNotification", {Title="我我",Text="森林中的99夜启动成功",Icon="rbxassetid://96305381714766"});
		else
			local Sound = Instance.new("Sound", workspace);
			Sound.SoundId = "rbxassetid://5606942182";
			Sound.PlayOnRemove = true;
			Sound:Destroy();
			game.StarterGui:SetCore("SendNotification", {Title="我我",Text="正在为您打开通用脚本",Icon="rbxassetid://96305381714766"});
			wait(1);
			local Library = loadstring(GetAsset("https://api.github.com/repos/WDQi/SDTZGN/contents/%5BF%5D/gt"))();
			local Sound = Instance.new("Sound", workspace);
			Sound.SoundId = "rbxassetid://87437544236708";
			Sound.PlayOnRemove = true;
			Sound:Destroy();
			game.StarterGui:SetCore("SendNotification", {Title="我我",Text="暂时没有通用",Icon="rbxassetid://96305381714766"});
			wait(3);
		end
	else
		LocalPlayer:Kick("环境异常，请稍后再试");
	end
end);