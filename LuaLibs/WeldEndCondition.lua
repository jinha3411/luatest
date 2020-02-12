WeldEndCondition = {}
WeldEndCondition.__index = WeldEndCondition

function WeldEndCondition:new()
  local output = {}
  output.GasPostTime = 0
  output.WeldEndTime = 0 
  output.WeldEndVol = 0
  output.WeldEndAmp = 0
  output.WeldEndLength = 0
  output.RobotPoseDataTable = {}
  output.count = 0
  setmetatable(output, WeldEndCondition)
  return output
end

function WeldEndCondition:create(gas, endt, endv, enda, endl)
  local output = {}
  output.GasPostTime = gas
  output.WeldEndTime = endt
  output.WeldEndVol = endv
  output.WeldEndAmp = enda
  output.WeldEndLength = endl
  output.RobotPoseDataTable = {}
  output.count = 0
  setmetatable(output, WeldEndCondition)
  return output
end

function WeldEndCondition:AddEndPosition(poseData)
  table.insert(self.RobotPoseDataTable, poseData)
  self.count = self.count + 1
end

function WeldEndCondition:GetEndPosition(index)
  if (index >= 1) and (index <= self.count) then
    local output = self.RobotPoseDataTable[index]
    return output
  else
    return nil
  end
end

function WeldEndCondition:GetEndPositionCount()
  return self.count
end

function WeldEndCondition:ClearEndPosition()
  self.RobotPoseDataTable = {}
  self.count = 0
end
