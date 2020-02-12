
RobotPoseData = {}
RobotPoseData.__index = RobotPoseData

function RobotPoseData:new()
  rpd = {}
  rpd.PoseType = 0
  rpd.Speed = 0
  rpd.f1 = 0
  rpd.f2 = 0
  rpd.f3 = 0
  rpd.f4 = 0
  rpd.f5 = 0
  rpd.f6 = 0
  setmetatable(rpd, RobotPoseData)
  return rpd
end

function RobotPoseData:createFromIndividual(iPoseType, iSpeed, if1, if2, if3, if4, if5, if6)
  rpd = {}
  rpd.PoseType = iPoseType
  rpd.Speed = iSpeed
  rpd.f1 = if1
  rpd.f2 = if2
  rpd.f3 = if3
  rpd.f4 = if4
  rpd.f5 = if5
  rpd.f6 = if6
  setmetatable(rpd, RobotPoseData)
  return rpd
end

function RobotPoseData:createFromTable(table)
  rpd = {}
  rpd.PoseType = table.PoseType
  rpd.Speed = table.Speed
  rpd.f1 = table.f1
  rpd.f2 = table.f2
  rpd.f3 = table.f3
  rpd.f4 = table.f4
  rpd.f5 = table.f5
  rpd.f6 = table.f6
  setmetatable(rpd, RobotPoseData)
  return rpd
end


function RobotPoseData:addOffset(offset_x, offset_y, offset_z)
  self.f1 = self.f1 + offset_x 
  self.f2 = self.f2 + offset_y
  self.f3 = self.f3 + offset_z
end

function RobotPoseData:printData()
  print(self.PoseType)
  print(self.Speed)
  print(self.f1)
  print(self.f2)
  print(self.f3)
  print(self.f4)
  print(self.f5)
  print(self.f6)
  
end
