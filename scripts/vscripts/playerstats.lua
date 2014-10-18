

if playerstats == nil then
	playerstats = class({})
end
PlayerS = {}

function playerstats:init()

  for i=0,8 do
    PlayerS[i]= {}
    PlayerS[i]={300,100,0,12,0,{},1,0,0,nil,nil,0}    --1 Gold, 2 Lumber, 3 CurFood, 4 FullFood, 5 Point, 6 units, 7 farmerNum, 8 tech, 9 unitpoint, 12 income
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
  
  
  PlayerS[25]=0;               --��Ӷ������
  PlayerS[26]={};              --��Ӷ����λ
  
  
  
  print("done init player's stat")
  sendinfotoui();
  
  for i=0,0,1 do               --15 base, 16 workers
    if not(i==4) then

      local temp=Entities:FindByName(nil,"player"..tostring(i+1).."_base")
      
      PlayerS[i][15]=CreateUnitByName("npc_player_base",temp:GetAbsOrigin(),false,nil,nil,2)
      
      PlayerS[i][16]={}
      
      PlayerS[i][15]:SetControllableByPlayer(0,true)
      

      
      
      for j=1,7,1 do
        temp=Entities:FindByName(nil,"player"..tostring(i+1).."_worker"..tostring(j))
        PlayerS[i][16][j]=CreateUnitByName("base_worker",temp:GetAbsOrigin(),false,nil,nil,2)

        PlayerS[i][16][j]:SetControllableByPlayer(0,true)
      end
      
      temp=Entities:FindByName(nil,"player"..tostring(i+1).."_hirer1")
      PlayerS[i][17]=CreateUnitByName("hirer_1",temp:GetAbsOrigin(),false,nil,nil,2)  --��Ӷ��Ӫ1��
      PlayerS[i][17]:SetControllableByPlayer(0,true)
      
    end
  end
  
  
  
  
  
  
end



function sendinfotoui() 
  local p={}
  local i=0
  p[0]="lol"
  for i=0,8,1 do
    if not(i==4) then
      p[i]=tostring(PlayerS[i][1]).."         "..tostring(PlayerS[i][2]).."         "..tostring(PlayerS[i][7]).."/"..tostring(PlayerS[i][8]).."         "..tostring(PlayerS[i][9]).."         "..tostring(PlayerS[i][5]).."         "..tostring(PlayerS[i][12])
      print(i,"'s player: ",p[i])
    end
  end



  FireGameEvent('ui_update', { player1=p[0],player2=p[1],player3=p[2],player4=p[3],player5=p[5],player6=p[6],player7=p[7],player8=p[8],jaja="cao"})
  print("done update ui")
end