--|-------------------------------------------------------|-- 
--| regm.lua                                   2007.09.19 |-- 
--|                                                       |-- 
--|                                                       |-- 
--| author: ale][ela                                      |-- 
--| (c) 2007 All rights reserved, GNU GPL license         |-- 
--|-------------------------------------------------------|-- 
-- ������� ������� 
regme="regme" -- ���������������� ������������ (�������� �����������) 
renick="renick" -- ��������������� ��� � ����������� ����� 
--reglist="reglist" 


BotNick="BotAT" 


function Main() 
    r,bot = VH:GetConfig("config", "hub_security") 
    if r then 
        BotNick = bot 
    end 
end 

function VH_OnUserCommand(nick, data) 
    local UserClass = GetClass(nick) 
    res, sIP = VH:GetUserIP(nick) 
-- ��������� ���������� 
    local _,_,cmd,param = string.find(data,"^%+(%S*)%s*(.*)") 
-- ����������� ������ ������ 
    if cmd == regme then 
   mIP = GetIP(nick) 
        if UserClass > 0 then 
       VH:SendDataToUser("<"..BotNick.."> �� ��� ����������������.|", nick) 
       if mIP ~= sIP then 
      VH:SendDataToUser("<"..BotNick.."> ��� IP �� ��������� � ��������������� \n\t\t������� IP - "..sIP.."\n\t\t������������������ IP - "..mIP.."|", nick) 
       end 
            return 0 
        end 
   if param == "" then 
       VH:SendDataToUser("<"..BotNick.."> �������� ��������! ����� ������� - +regme ���_������.|", nick) 
            return 0 
   else 
       _,_,pass = string.find(param, "^(%S+)") 
   end 
   query = "INSERT INTO reglist (nick,class,reg_date,reg_op,pwd_change,login_pwd,pwd_crypt,note_op) ".."VALUES ('"..nick.."','1','"..(os.time()).."','Lua','0','"..pass.."','0','Lua')" 
   res,rows = VH:SQLQuery(query) 
   if res then 
       res, old_timer_reloadcfg_period = VH:GetConfig("config", "timer_reloadcfg_period") if not res then return 1 else end 
       res, err = VH:SetConfig("config" , "timer_reloadcfg_period", "0") 
       Time = 5 
       VH:SendDataToUser("<"..BotNick.."> ����������� ���������. ��� ������ �� ���� ����: -> "..pass.." <- \n\t ��� ����, ����� �� ������� ������ ��� ������, \n\t������� � �������� ���������� �� ������� \"������� ����\"\n\t� ������� ���� ���� ��� � ������\n\n\t ��� ��������� ����������, ����� �� ����� ��� ������������������ ������������.|", nick) 
       VH:CloseConnection(nick) 
       VH:SendDataToAll("<"..BotNick.."> ����� ������������������ ������������: "..nick.." :-)|",0,10) 
   else 
       VH:SendDataToUser("<"..BotNick.."> ������, ���������� ��� ���.|", nick) 
   VH:SendDataToAll("<"..BotNick..">: cmd- "..cmd.."   param- "..param.."  pass- "..pass.." :-)|",0,10) 
   return 0 
   end 
    end 
-- end regme 
-- ���������������� ���� 
    if cmd == renick then 
   if param == "" then 
       VH:SendDataToUser("<"..BotNick.."> �������� ��������! ����� ������� - +renick �����_���.|", nick) 
            return 0 
   else 
       _,_,newnick = string.find(param, "^(%S+)") 
   end 
   query = "UPDATE `verlihub`.`reglist` SET `nick` = \""..newnick.."\" WHERE `nick` LIKE  \""..nick.."\" LIMIT 1;" 
   res, rows = VH:SQLQuery(query) 
   VH:SendDataToUser("<"..BotNick.."> res= rows="..rows.."|", nick) 
   if res then 
       VH:SendDataToUser("<"..BotNick.."> ��� ����� ��� -> "..newnick.." <-. \n\t������ ��� ������� ����������, ��� ����� ��������������.\n\t�� �������� �������� ��� � ���������� ���������� �� �������� \"������� ����\"|", nick) 
       VH:CloseConnection(nick) 
   else 
       VH:SendDataToUser("<"..BotNick.."> ������, ���������� ��� ���.|", nick) 
   end 
   return 0 
    end 
-- end renick 
    return 1 
end 


------------------------------------------------------------------------------------ 
function GetIP(nick) 
    local r,c = VH:SQLQuery("SELECT `login_ip` FROM `reglist` WHERE `nick` LIKE  \""..nick.."\" LIMIT 0, 1;") 
    local res, mIP = VH:SQLFetch(0) 
    return mIP 
end 

function VH_OnTimer() 
    if Time ~= nil and Time > 0 then Time = Time - 1 return end 
    if Time == 0 then 
   res, err = VH:SetConfig("config" , "timer_reloadcfg_period", old_timer_reloadcfg_period) 
   Time = nil 
    end 
return 1 
end 


function GetClass(nick) 
    res, class = VH:GetUserClass(nick) 
    if res and class then 
   return class 
    else 
        return false 
    end 
end