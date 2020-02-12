require "RobotPoseData"
WeldMainCondition = {}
WeldMainCondition.__index = WeldMainCondition

function WeldMainCondition:new()
  local output = {}
  output.PathType = 1
  output.PathStartPosition = RobotPoseData:new()
  output.PathMidPosition = RobotPoseData:new()
  output.PathEndPosition = RobotPoseData:new()

  output.WeldVol = 0
  output.WeldAmp = 0
  output.WeldSpd = 0
  
  output.Weaving = 0;
  output.WeavHz = 0
  output.WeavLength = 0
  output.WeavLeftStopTime = 0
  output.WeavRightStopTime = 0
  
  output.ArcSen = 0
  output.ArcSenTimeShift = 0
  output.ArcSenHFactor = 0
  output.ArcSenVFactor = 0
  output.ArcSenHMaxdL = 0
  output.ArcSenVMaxdL = 0
  output.ArcSenHOncedL = 0
  output.ArcSenVOncedL = 0
  output.ArcSenWeightedFactorRight = 0
  output.ArcSenWeightedFactorLeft = 0
  setmetatable(output, WeldMainCondition)
  return output
end

function WeldMainCondition:SetStartPose(startPose)
  self.PathStartPosition = startPose
end

function WeldMainCondition:SetMidPose(midPose)
  self.PathMidPosition = midPose
end

function WeldMainCondition:SetEndPose(endPose)
  self.PathEndPosition = endPose
end

function WeldMainCondition:GetStartPose()
  return self.PathStartPosition
end

function WeldMainCondition:GetMidPose()
  return self.PathMidPosition
end

function WeldMainCondition:GetEndPose()
  return self.PathEndPosition
end

function WeldMainCondition:SetPath(pathType, startPose, midPose, endPose)
  self.PathType = pathType
  self.PathStartPosition = startPose
  self.PathMidPosition = midPose
  self.PathEndPosition = endPose
end

function WeldMainCondition:SetWeldCondition(pathType, vol, amp, speed)
  self.PathType = pathType
  self.WeldVol = vol
  self.WeldAmp = amp
  self.WeldSpd = speed
end

function WeldMainCondition:SetWeavingCondition(weaveType, hz, length, leftStopTime, rightStopTime)
  self.Weaving = weaveType
  self.WeavHz = hz
  self.WeavLength = length
  self.WeavLeftStopTime = leftStopTime
  self.WeavRightStopTime = rightStopTime
end

function WeldMainCondition:SetArcSendingSetting(arcSenType, timeShift, hFactor, vFactor, hMaxdL, vMaxdL, hOncedL, vOncedL, weightedFactorRight, weightedFactorLeft)
  self.ArcSen = arcSenType
  self.ArcSenTimeShift = timeShift
  self.ArcSenHFactor = hFactor
  self.ArcSenVFactor = vFactor
  self.ArcSenHMaxdL = hMaxdL
  self.ArcSenVMaxdL = vMaxdL
  self.ArcSenHOncedL = hOncedL
  self.ArcSenVOncedL = vOncedL
  self.ArcSenWeightedFactorRight = weightedFactorRight
  self.ArcSenWeightedFactorLeft = weightedFactorLeft
end
