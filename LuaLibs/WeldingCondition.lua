WeldingCondition = {}
WeldingCondition.__index = WeldingCondition

function WeldingCondition:new()
  local output = {}
  output.Vol = 0
  output.Amp = 0
  output.Spd = 0
  output.Offset_WorkAngle = 0
  output.Offset_TravelAngle = 0
  output.Offset_X = 0
  output.Offset_Y = 0
  output.Offset_Z = 0 
  output.WeavingHz = 0
  output.WeavingWidth = 0
  output.WeavingFloorStop = 0
  output.WeavingWallStop = 0
  output.ArcSen = 0
  output.BeadBias = 0
  return output
end
