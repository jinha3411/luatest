require "WeldStartCondition"
require "WeldMainCondition"
require "WeldEndCondition"
require "Libraries"
WeldInformation = {}
WeldInformation.__index = WeldInformation

function WeldInformation:new()
  local output = {}
  output.ArcOnFlag = true
  output.ContinueFlag = true
  output.MultipathFlag = false
  output.MultipathNumber = 1
  output.OffsetX = 0
  output.OffsetY = 0
  output.OffsetZ = 0  
  output.OffsetWorkAngle = 0
  output.OffsetTravelAngle = 0
  output.InitCondition = WeldStartCondition:new()
  output.MainCondition = {}
  output.EndCondition = WeldEndCondition:new()
  output.MainConditionCount = 0
  setmetatable(output, WeldInformation)
  return output
end


function WeldInformation:AddMainCondition(mainCondition)
  table.insert(self.MainCondition, mainCondition)
  self.MainConditionCount = self.MainConditionCount + 1
end

function WeldInformation:GetMainCondition(index)
  if (index >= 1) and (index <= self.MainConditionCount) then
    return self.MainCondition[index]
  else
    return nil
  end
end

function WeldInformation:GetMainConditionCount()
  return self.MainConditionCount
end

function WeldInformation:ClearMainCondition()
  self.MainCondition = {}
  self.MainConditionCount = 0
end

function WeldInformation:ApplyOffset(OffsetStart, OffsetEnd, OffsetX, OffsetY, OffsetZ, OffsetWorkAngle, OffsetTravelAngle)
  count = self.MainConditionCount
  SPose = self.MainCondition[1]:GetStartPose()
  EPose = self.MainCondition[count]:GetStartPose()
  
  Vx, Vy, Vz, length = RobotStartEndToDirCal(SPose, EPose)
  ToolX, ToolY, ToolZ = RobotPoseToTooldirCal(SPose)
  
  FloorDir = 0
  if (math.abs(Vy) > math.abs(Vz)) then
    if (Vy > 0) then
      FloorDir = 1
    else
      FloorDir = 2
    end
  else
    if (ToolY > 0) then
      FloorDir = 1
    else
      FloorDir = 2
    end
  end
  
  for i = 1, count do
    maincon = self:GetMainCondition(i)
    if ((i + 1) <= count) then
      maincon_next = self:GetMainCondition(i + 1)
    else
      maincon_next = self:GetMainCondition(i)
    end
    
    mainSPose = maincon:GetStartPose()
    mainEPose = maincon:GetEndPose()
    nextSPose = maincon_next:GetStartPose()
    nextEPose = maincon_next:GetEndPose()
    
    nowX, nowY, nowZ, nowL = RobotStartEndToDirCal(mainSPose, mainEPose)
    nextX, nextY, nextZ, nextL = RobotStartEndToDirCal(nextSPose, nextEPose)
    
    nowToolX, nowToolY, nowToolZ = RobotPoseToTooldirCal(mainSPose)
    nextToolX, nextToolY, nextToolZ = RobotPoseToTooldirCal(nextSPose)
    
    nowCrossX, nowCrossY, nowCrossZ = VectorCrossProduct(nowToolX, nowToolY, nowToolZ, nowX, nowY, nowZ)
    nextCrossX, nextCrossY, nextCrossZ = VectorCrossProduct(nextToolX, nextToolY, nextToolZ, nextX, nextY, nextZ)

    if i == 1 then
      temppose = self:GetMainCondition(i):GetStartPose()
      temppose.f1 = temppose.f1 + nowX * OffsetStart
      temppose.f2 = temppose.f2 + nowY * OffsetStart
      temppose.f3 = temppose.f3 + nowZ * OffsetStart
      self:GetMainCondition(i):SetStartPose(temppose)
    end
    
    if i == count then
      temppose = self:GetMainCondition(count):GetEndPose()
      temppose.f1 = temppose.f1 - nowX * OffsetEnd
      temppose.f2 = temppose.f2 - nowY * OffsetEnd
      temppose.f3 = temppose.f3 - nowZ * OffsetEnd
      self:GetMainCondition(i):SetEndPose(temppose)
    end
    
    tempposeS = self:GetMainCondition(i):GetStartPose()
    tempposeM = self:GetMainCondition(i):GetMidPose()
    tempposeE = self:GetMainCondition(i):GetEndPose()
    tempposeS.f1 = (tempposeS.f1 + OffsetX)
    tempposeS.f2 = (tempposeS.f2 + OffsetY)
    tempposeS.f3 = (tempposeS.f3 + OffsetZ)
    tempposeM.f1 = (tempposeM.f1 + OffsetX)
    tempposeM.f2 = (tempposeM.f2 + OffsetY)
    tempposeM.f3 = (tempposeM.f3 + OffsetZ)
    tempposeE.f1 = (tempposeE.f1 + OffsetX)
    tempposeE.f2 = (tempposeE.f2 + OffsetY)
    tempposeE.f3 = (tempposeE.f3 + OffsetZ)
    
    ORx = tempposeS.f4
    ORy = tempposeS.f5
    ORz = tempposeS.f6
    if (FloorDir == 1) then
      RRx, RRy, RRz = RobotBaseRotation(ORx, ORy, ORz, nowX, nowY, nowZ, OffsetWorkAngle)
    else
      RRx, RRy, RRz = RobotBaseRotation(ORx, ORy, ORz, nowX, nowY, nowZ, -1 * OffsetWorkAngle)
    end
    tempposeS.f4 = RRx
    tempposeS.f5 = RRy
    tempposeS.f6 = RRz
    
    ORx = tempposeE.f4
    ORy = tempposeE.f5
    ORz = tempposeE.f6
    if (FloorDir == 1) then
      RRx, RRy, RRz = RobotBaseRotation(ORx, ORy, ORz, nextX, nextY, nextZ, OffsetWorkAngle)
    else
      RRx, RRy, RRz = RobotBaseRotation(ORx, ORy, ORz, nextX, nextY, nextZ, -1 * OffsetWorkAngle)
    end
    tempposeE.f4 = RRx
    tempposeE.f5 = RRy
    tempposeE.f6 = RRz
    
    ORx = tempposeS.f4
    ORy = tempposeS.f5
    ORz = tempposeS.f6
    RRx, RRy, RRz = RobotBaseRotation(ORx, ORy, ORz, nowCrossX, nowCrossY, nowCrossZ, OffsetTravelAngle)
    tempposeS.f4 = RRx
    tempposeS.f5 = RRy
    tempposeS.f6 = RRz
    
    ORx = tempposeE.f4
    ORy = tempposeE.f5
    ORz = tempposeE.f6
    RRx, RRy, RRz = RobotBaseRotation(ORx, ORy, ORz, nextCrossX, nextCrossY, nextCrossZ, OffsetTravelAngle)
    tempposeE.f4 = RRx
    tempposeE.f5 = RRy
    tempposeE.f6 = RRz
    
    self:GetMainCondition(i):SetStartPose(tempposeS)
    self:GetMainCondition(i):SetMidPose(tempposeM)
    self:GetMainCondition(i):SetEndPose(tempposeE)
  end
  
end


  
function WeldInformation:CalcWeldLength()
  length = 0
  count = self:GetMainConditionCount()
  for i = 1, count do
    Vx, Vy, Vz, SingleL = RobotStartEndToDirCal(self:GetMainCondition(i):GetStartPose(), self:GetMainCondition(i):GetEndPose())
    length = length + SingleL
  end
  
  return length
end

function WeldInformation:CalcWeldTime()
  time = 0
  count = self:GetMainConditionCount()
  for i = 1, count do
    Vx, Vy, Vz, SingleL = RobotStartEndToDirCal(self:GetMainCondition(i):GetStartPose(), self:GetMainCondition(i):GetEndPose())
    speed = self:GetMainCondition(i).WeldSpd / ((self:GetMainCondition(i).WeavLeftStopTime + self:GetMainCondition(i).WeavRightStopTime) * self:GetMainCondition(i).WeavHz + 1) / 6
    time = time + SingleL / speed
  end
  return time
end

