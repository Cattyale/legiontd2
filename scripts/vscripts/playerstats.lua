
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

  local temp=Entities:FindByName(nil,"zibao") --���е�λ������˯������֮�� ��֮�����߶�������
  zibao=temp:GetAbsOrigin()

  local temp=Entities:FindByName(nil,"wang_1")
  wang1=temp:GetAbsOrigin()                   --��1������
          
  local temp=Entities:FindByName(nil,"wang_2")
  wang2=temp:GetAbsOrigin()                   --����������

  wang_1=CreateUnitByName("King_light", wang1, false, nil, nil, 2)
  wang_1:AddNewModifier(wang_1, nil, "modifier_rooted", nil)
  wang_2=CreateUnitByName("King_dark", wang2, false, nil, nil, DOTA_TEAM_BADGUYS)
  wang_2:AddNewModifier(wang_2, nil, "modifier_rooted", nil)
  --��Ӷ�������������

  local temp=Entities:FindByName(nil,"team1_hirer")
  hirer1=temp:GetAbsOrigin()                   --��Ӷ����1������

  print(hirer1)

  dummy1=CreateUnitByName("npc_dummy", hirer1, false, nil, nil, 2)
  
  print(dummy1)
  print(dummy1:GetAbsOrigin())
  local temp=Entities:FindByName(nil,"team2_hirer")
  hirer2=temp:GetAbsOrigin()                   --��Ӷ����1������
  dummy2=CreateUnitByName("npc_dummy", hirer2, false, nil, nil, DOTA_TEAM_BADGUYS)

  for i=0,8 do
    PlayerS[i]= {}
    PlayerS[i]={350,100,0,12,0,{},0,0,0,nil,nil,0}    
    --1 Gold, 2 Lumber, 3 CurFood, 4 FullFood, 5 Point, 6 units, 7 farmerNum, 8 tech, 9 unitpoint, 12 income, 
    --15 ���أ� 16 ũ�� 17 ��Ӷ���� 18 �˿�, 19 �����ƶ�flag, 20 ��������, 24 Ӣ��
    
    PlayerS[i][19]=0;
  end
  PlayerS[4]=nil
  print("done playerstat init")
  
  PlayerS[0][10]="trigger_castarea_1"          --ÿ����ҵĽ�������       
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
  
  PlayerS[12]=0  --������ұ��ļ���
  PlayerS[13]={} --������ұ�
  PlayerS[14]={} --������ұ����������id
  PlayerS[15]={} --������ұ���λ��
  PlayerS[16]={} --������ұ�������
  PlayerS[17]={} --������ұ���owner
  PlayerS[18]={} --������ұ���team
  
  
  
  PlayerS[25]=0               --��Ӷ������
  PlayerS[26]={}              --��Ӷ����λ
  PlayerS[27]={}              --��Ӷ��������
  PlayerS[28]={}              --��Ӷ��������

  for i=0,8,1 do              --�ж��������
    if (not(i==4)) then
     if PlayerResource:IsValidPlayer(i) then

        print("playerconnected:")
        print(i)

        PlayerS[i][30]=1
      
      else
        
        PlayerS[i][30]=0
      
      end
    end
  end
  
  print("done init player's stat")
  sendinfotoui();
  
  for i=0,8,1 do               --15 base, 16 workers
                               --iΪpid
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
      --��������

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
      
      --�����˿�
      
      local temp=Entities:FindByName(nil,"player"..tostring(q+1).."_renkou")
      
      PlayerS[i][18]=CreateUnitByName("npc_renkou",temp:GetAbsOrigin(),false,nil,nil,2)
      
      
      PlayerS[i][18]:SetControllableByPlayer(i,true)
      
      PlayerS[i][18]:SetContext("name",tostring(i),0) --�ҽ�pid

      PlayerS[i][18]:AddNewModifier(PlayerS[i][18], nil, "modifier_invulnerable", nil)
      PlayerS[i][18]:AddNewModifier(PlayerS[i][18], nil, "modifier_rooted", nil)
      if i<4 then
        PlayerS[i][18]:SetTeam(2)
      else
        PlayerS[i][18]:SetTeam(3)
      end
      --PlayerS[i][18]:SetPlayerID(i)
      
      
      for j=1,7,1 do           --7��ũ��
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

      
      --[[��ʼ��Ӣ��
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
      p[i]=tostring(PlayerS[i][1]).."      "..tostring(PlayerS[i][2]).."        "..tostring(PlayerS[i][7]).."/"..tostring(PlayerS[i][8]).."          "..tostring(PlayerS[i][9]).."          "..tostring(PlayerS[i][5]).."          "..tostring(PlayerS[i][12]).."           "..tostring(PlayerS[i][3]).."/"..tostring(PlayerS[i][4])
      pp[i]=tostring(PlayerS[i][1]).."         "..tostring(PlayerS[i][2]).."          "..tostring(PlayerS[i][7]).."/"..tostring(PlayerS[i][8]).."           "..tostring(PlayerS[i][3]).."/"..tostring(PlayerS[i][4])
    end
  end



  FireGameEvent('ui_update', {player1=p[0],player2=p[1],player3=p[2],player4=p[3],player5=p[5],player6=p[6],player7=p[7],player8=p[8]})
  FireGameEvent('p_update',{pp1=pp[0],pp2=pp[1],pp3=pp[2],pp4=pp[3],pp5=pp[5],pp6=pp[6],pp7=pp[7],pp8=pp[8]})

end

