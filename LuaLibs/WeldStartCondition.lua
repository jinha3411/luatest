WeldStartCondition = {}
WeldStartCondition.__index = WeldStartCondition
function WeldStartCondition:new()
  local output = {}
  output.GasPreTime = 0
  output.WeldStartTime = 0 
  output.WeldStartVol = 0
  output.WeldStartAmp = 0
  output.RobotPoseDataTable = {}
  output.count = 0
  setmetatable(output, WeldStartCondition)
  return output
end

function WeldStartCondition:create(gas, startt, startv, starta)
  local output = {}
  output.GasPreTime = gas
  output.WeldStartTime = startt 
  output.WeldStartVol = startv
  output.WeldStartAmp = starta
  output.RobotPoseDataTable = {}
  output.count = 0
  setmetatable(output, WeldStartCondition)
  return output
end

function WeldStartCondition:AddStartPosition(poseData)
  table.insert(self.RobotPoseDataTable, poseData)
  self.count = self.count + 1
end


function WeldStartCondition:GetStartPosition(index)
  if (index >= 1) and (index <= self.count) then
    local output = self.RobotPoseDataTable[index]
    return
  else
    return nil
  end
end

function WeldStartCondition:GetStartPositionCount()
  return self.count
end

function WeldStartCondition:ClearStartPosition()
  self.RobotPoseDataTable = {}
  self.count = 0
  return o
end
