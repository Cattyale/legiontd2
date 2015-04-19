
yx={}

lwang={0,0,0}
dwang={0,0,0}



if playerstats == nil then
	playerstats = class({})
end
PlayerS = {}

function playerstats:init()

 -- SendToConsole("dota_sf_hud_inventory 0")
 -- SendToConsole("dota_render_crop_height 0")

  local temp=Entities:FindByName(nil,"zibao") --所有单位假死沉睡的最终之地 神之居所瓦尔哈拉！
  zibao=temp:GetAbsOrigin()

  local temp=Entities:FindByName(nil,"wang_1")
  wang1=temp:GetAbsOrigin()                   --王1的坐标
          
  local temp=Entities:FindByName(nil,"wang_2")
  wang2=temp:GetAbsOrigin()                   --王二的坐标

  wang_1=CreateUnitByName("King_light", wang1, false, nil, nil, 2)
  wang_1:AddNewModifier(wang_1, nil, "modifier_rooted", nil)
  wang_2=CreateUnitByName("King_dark", wang2, false, nil, nil, DOTA_TEAM_BADGUYS)
  wang_2:AddNewModifier(wang_2, nil, "modifier_rooted", nil)
  --雇佣兵处的照明马甲

  local temp=Entities:FindByName(nil,"team1_hirer")
  hirer1=temp:GetAbsOrigin()                   --雇佣兵处1的坐标
  dummy1=CreateUnitByName("npc_dummy", hirer1, false, nil, nil, 2)
  
  
  local temp=Entities:FindByName(nil,"team2_hirer")
  hirer2=temp:GetAbsOrigin()                   --雇佣兵处1的坐标
  dummy2=CreateUnitByName("npc_dummy", hirer2, false, nil, nil, DOTA_TEAM_BADGUYS)

  for i=1,11,1 do
    local temp=Entities:FindByName(nil,"zhaomin2_"..tostring(i))
    local tempvec=temp:GetAbsOrigin()                   --雇佣兵处1的坐标
    local tempdumy=CreateUnitByName("npc_dummy", tempvec, false, nil, nil, 2)
  end

  for i=1,11,1 do
    local temp=Entities:FindByName(nil,"zhaomin1_"..tostring(i))
    local tempvec=temp:GetAbsOrigin()                   --雇佣兵处1的坐标
    local tempdumy=CreateUnitByName("npc_dummy", tempvec, false, nil, nil, DOTA_TEAM_BADGUYS)
  end

  for i=0,8 do
    PlayerS[i]= {}
    PlayerS[i]={350,100,0,12,0,{},0,0,0,nil,nil,0}    
    --1 Gold, 2 Lumber, 3 CurFood, 4 FullFood, 5 Point, 6 units, 7 farmerNum, 8 tech, 9 unitpoint, 12 income, 
    --15 基地， 16 农民， 17 雇佣兵， 18 人口, 19 兵种移动flag, 20 传送区域, 24 英雄
    
    PlayerS[i][19]=0;
  end
  PlayerS[4]=nil
  print("done playerstat init")
  
  PlayerS[0][10]="trigger_castarea_1"          --每个玩家的建造区域       
  PlayerS[0][11]="trigger_castarea_12"
  PlayerS[1][10]="trigger_castarea_2"
  PlayerS[1][11]="trigger_castarea_12"
  PlayerS[2][10]="trigger_castarea_3"
  PlayerS[2][11]="trigger_castarea_34"
  PlayerS[3][10]="trigger_castarea_4"
  PlayerS[3][11]="trigger_castarea_34"
  
  
  PlayerS[5][10]="trigger_castarea_5"
  PlayerS[5][11]="trigger_castarea_56"
  PlayerS[6][10]="trigger_castarea_6"
  PlayerS[6][11]="trigger_castarea_56"
  PlayerS[7][10]="trigger_castarea_7"
  PlayerS[7][11]="trigger_castarea_78"
  PlayerS[8][10]="trigger_castarea_8"
  PlayerS[8][11]="trigger_castarea_78"
  
  PlayerS[12]=0  --所有玩家兵的计数
  PlayerS[13]={} --所有玩家兵
  PlayerS[14]={} --所有玩家兵的所属玩家id
  PlayerS[15]={} --所有玩家兵的位置
  PlayerS[16]={} --所有玩家兵的名字
  PlayerS[17]={} --所有玩家兵的owner
  PlayerS[18]={} --所有玩家兵的team
  
  
  
  PlayerS[25]=0               --雇佣兵计数
  PlayerS[26]={}              --雇佣兵单位
  PlayerS[27]={}              --雇佣兵出生点
  PlayerS[28]={}              --雇佣兵的名字

  for i=0,8,1 do              --判断在线玩家
    if (not(i==4)) then
     if PlayerResource:IsValidPlayer(i) then

        print("playerconnected:",i)

        PlayerS[i][30]=1
      
      else
        
        PlayerS[i][30]=0
      
      end
    end
  end
  
  print("done init player's stat")
  sendinfotoui();
  
  for i=0,8,1 do               --15 base, 16 workers
                               --i为pid
    if (not(i==4)) and (PlayerS[i][30]==1)then
    
      if i<4 then
        wang_1:SetControllableByPlayer(i, true)
        dummy1:SetControllableByPlayer(i, true)
        q=i
      else
        wang_2:SetControllableByPlayer(i, true)
        dummy2:SetControllableByPlayer(i, true)
        q=i-1
      end
      --创建基地

      local temp=Entities:FindByName(nil,"player"..tostring(q+1).."_base")
      
      PlayerS[i][15]=CreateUnitByName("npc_player_base",temp:GetAbsOrigin(),false,nil,nil,2)

      PlayerS[i][15]:SetContext("name",tostring(i),0)
      
      PlayerS[i][16]={}
      
      PlayerS[i][15]:SetControllableByPlayer(i,true)
       
       PlayerS[i][15]:AddNewModifier(PlayerS[i][15], nil, "modifier_invulnerable", nil)
       PlayerS[i][15]:AddNewModifier(PlayerS[i][15], nil, "modifier_rooted", nil)

      if i<4 then
        PlayerS[i][15]:SetTeam(2)
     
      else
        PlayerS[i][15]:SetTeam(3)
  

      end
      --PlayerS[i][15]:SetPlayerID(i)
      
      --创建人口
      
      local temp=Entities:FindByName(nil,"player"..tostring(q+1).."_renkou")
      
      PlayerS[i][18]=CreateUnitByName("npc_renkou",temp:GetAbsOrigin(),false,nil,nil,2)
      
      
      PlayerS[i][18]:SetControllableByPlayer(i,true)
      
      PlayerS[i][18]:SetContext("name",tostring(i),0) --挂进pid

      PlayerS[i][18]:AddNewModifier(PlayerS[i][18], nil, "modifier_invulnerable", nil)
      PlayerS[i][18]:AddNewModifier(PlayerS[i][18], nil, "modifier_rooted", nil)
      if i<4 then
        PlayerS[i][18]:SetTeam(2)
      else
        PlayerS[i][18]:SetTeam(3)
      end
      --PlayerS[i][18]:SetPlayerID(i)
      
      
      for j=1,7,1 do           --7个农民
        temp=Entities:FindByName(nil,"player"..tostring(q+1).."_worker"..tostring(j))
        PlayerS[i][16][j]=CreateUnitByName("base_worker",temp:GetAbsOrigin(),false,nil,nil,2)
        PlayerS[i][16][j]:SetContext("name",tostring(i),0)
        PlayerS[i][16][j]:SetControllableByPlayer(i,true)
        PlayerS[i][16][j]:AddNewModifier(PlayerS[i][16][j], nil, "modifier_invulnerable", nil)
        
      if i<4 then
        PlayerS[i][16][j]:SetTeam(2)
      else
        PlayerS[i][16][j]:SetTeam(3)
      end
      end
      

      local temp=Entities:FindByName(nil,"trigger_teleport"..tostring(i))
      PlayerS[i][20]=temp

      
      --[[初始化英雄
      local j=0
      print(i)
      
      local hero = PlayerResource:GetPlayer(i):GetAssignedHero()
      
      hero:SetAbilityPoints(0)
      
      
      for j = 1,6,1 do
        local temp1=hero:GetAbilityByIndex(j)
        temp1:SetLevel(1)
      end
      ]]
      
      
    end
  end
  
  
  
  
  
  
end



function sendinfotoui() 
  local p={}
  local pp={}
  local i=0

  for i=0,8,1 do
    if not(i==4) then
      p[i]=tostring(PlayerS[i][1]).."       "..tostring(PlayerS[i][2]).."         "..tostring(PlayerS[i][7]).."/"..tostring(PlayerS[i][8]).."          "..tostring(PlayerS[i][9]).."           "..tostring(PlayerS[i][5]).."          "..tostring(PlayerS[i][12]).."           "..tostring(PlayerS[i][3]).."/"..tostring(PlayerS[i][4])
      --pp[i]=tostring(PlayerS[i][1]).."           "..tostring(PlayerS[i][2]).."            "..tostring(PlayerS[i][7]).."/"..tostring(PlayerS[i][8]).."             "..tostring(PlayerS[i][3]).."/"..tostring(PlayerS[i][4])
    end
  end



  FireGameEvent('ui_update', {player1=p[0],player2=p[1],player3=p[2],player4=p[3],player5=p[5],player6=p[6],player7=p[7],player8=p[8]})
  FireGameEvent('p_update',{
    pp1g=tostring(PlayerS[0][1]),
    pp1e=tostring(PlayerS[0][2]),
    pp1r=tostring(PlayerS[0][3]).."/"..tostring(PlayerS[0][4]),
    pp1k=tostring(PlayerS[0][7]).."/"..tostring(PlayerS[0][8]),

    pp2g=tostring(PlayerS[1][1]),
    pp2e=tostring(PlayerS[1][2]),
    pp2r=tostring(PlayerS[1][3]).."/"..tostring(PlayerS[1][4]),
    pp2k=tostring(PlayerS[1][7]).."/"..tostring(PlayerS[1][8]),

    pp3g=tostring(PlayerS[2][1]),
    pp3e=tostring(PlayerS[2][2]),
    pp3r=tostring(PlayerS[2][3]).."/"..tostring(PlayerS[2][4]),
    pp3k=tostring(PlayerS[2][7]).."/"..tostring(PlayerS[2][8]),

    pp4g=tostring(PlayerS[3][1]),
    pp4e=tostring(PlayerS[3][2]),
    pp4r=tostring(PlayerS[3][3]).."/"..tostring(PlayerS[3][4]),
    pp4k=tostring(PlayerS[3][7]).."/"..tostring(PlayerS[3][8]),

    pp5g=tostring(PlayerS[5][1]),
    pp5e=tostring(PlayerS[5][2]),
    pp5r=tostring(PlayerS[5][3]).."/"..tostring(PlayerS[5][4]),
    pp5k=tostring(PlayerS[5][7]).."/"..tostring(PlayerS[5][8]),

    pp6g=tostring(PlayerS[6][1]),
    pp6e=tostring(PlayerS[6][2]),
    pp6r=tostring(PlayerS[6][3]).."/"..tostring(PlayerS[6][4]),
    pp6k=tostring(PlayerS[6][7]).."/"..tostring(PlayerS[6][8]),

    pp7g=tostring(PlayerS[7][1]),
    pp7e=tostring(PlayerS[7][2]),
    pp7r=tostring(PlayerS[7][3]).."/"..tostring(PlayerS[7][4]),
    pp7k=tostring(PlayerS[7][7]).."/"..tostring(PlayerS[7][8]),

    pp8g=tostring(PlayerS[8][1]),
    pp8e=tostring(PlayerS[8][2]),
    pp8r=tostring(PlayerS[8][3]).."/"..tostring(PlayerS[8][4]),
    pp8k=tostring(PlayerS[8][7]).."/"..tostring(PlayerS[8][8])
    })

end

