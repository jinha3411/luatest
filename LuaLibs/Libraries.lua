require "RobotPoseData"
require "HCRRobotSetting"
require "RobotPoseData_Archieve"
require "TouchSensingData"


--From RobotWeldAngle Class
function RobotWeldAngleLeft(x1, y1, z1, x2, y2, z2)
  local output = {}
  x3 = x1 - x2
  y3 = y1 - y2
  z3 = z1 - z2
  if (x3 > 0) then
    output.Ry = (math.pi / 2) + math.acos(z3 / (math.sqrt(x3^2 + z3^2)))
  elseif x3 < 0 then
    output.Ry = (math.pi / 2) - math.acos(z3 / (math.sqrt(x3^2 + z3^2)))
  else
    output.Ry = (math.pi / 2)
  end
  
  if (y3 > 0) then
    output.Rx = (math.pi / 2) + math.acos(z3 / (math.sqrt(y3^2 + z3^2)))
  elseif y3 < 0 then
    output.Rx = (math.pi / 2) - math.acos(z3 / (math.sqrt(y3^2 + z3^2)))
  else
    output.Rx = (math.pi / 2)
  end
  return output
end
--From RobotWeldAngle Class
function RobotWeldAngleRight(x1, y1, z1, x2, y2, z2)
  local output = {}
  x3 = x1 - x2
  y3 = y1 - y2
  z3 = z1 - z2
  if (x3 > 0) then
    output.Ry = (math.pi / 2) + math.acos(z3 / (math.sqrt(x3^2 + z3^2)))
  elseif (x3 < 0) then
    output.Ry = (math.pi / 2) - math.acos(z3 / (math.sqrt(x3^2 + z3^2)))
  else
    output.Ry = (math.pi / 2)
  end
  
  if (y3 > 0) then
    output.Rx = (math.pi / 2) - math.acos(z3 / (math.sqrt(y3^2 + z3^2)))
  elseif (y3 < 0) then
    output.Rx = (math.pi / 2) + math.acos(z3 / (math.sqrt(y3^2 + z3^2)))
  else
    output.Rx = (math.pi / 2)
  end
  return output
end

--From RobotWeldAngle Class
function xmove(Ry)
  local output = 0
  output = -1 / (math.tan(math.pi - Ry))
  return output
end

--From HCRRobotCommunication Class
function RobotToolRotation(inRx, inRy, inRz, Axis, Angle)
  outRx = 0
  outRy = 0
  outRz = 0
  
  initMatrix = MakeXYZAngleToRMatrix(inRx, inRy, inRz)
  RMatrix = {}
  if Axis == 1 then
    RMatrix = MakeAxisAndAngleToRMatrix(initMatrix[1], initMatrix[4], initMatrix[7], Angle)
  elseif Axis == 2 then
    RMatrix = MakeAxisAndAngleToRMatrix(initMatrix[2], initMatrix[5], initMatrix[8], Angle)
  else
    RMatrix = MakeAxisAndAngleToRMatrix(initMatrix[3], initMatrix[6], initMatrix[9], Angle)
  end
  
  outMatrix = MakeMatrixMul(RMatrix, initMatrix)
            
  tempb = math.atan(-outMatrix[7], math.sqrt(outMatrix[1] * outMatrix[1] + outMatrix[4] * outMatrix[4]))
  tempa = math.atan(outMatrix[4]/ math.cos(tempb), outMatrix[1] / math.cos(tempb))
  tempr = math.atan(outMatrix[8] / math.cos(tempb), outMatrix[9] / math.cos(tempb))

  outRz = (tempa * (180 / math.pi));
  outRy = (tempb * (180 / math.pi));
  outRx = (tempr * (180 / math.pi));
  
  return outRx, outRy, outRz
end  


--From HCRRobotCommunication Class
function RobotBaseRotation(inRx, inRy, inRz, AxisX, AxisY, AxisZ, Angle)
  outRx = 0
  outRy = 0
  outRz = 0
  M = math.sqrt(AxisX^2 + AxisY^2 + AxisZ^2)
  X = AxisX / M
  Y = AxisY / M
  Z = AxisZ / M

  initMatrix = MakeXYZAngleToRMatrix(inRx, inRy, inRz)
  RMatrix = MakeAxisAndAngleToRMatrix(X, Y, Z, Angle)
  outMatrix = MakeMatrixMul(RMatrix, initMatrix)
  
  tempb = math.atan(-1 * outMatrix[7], math.sqrt(outMatrix[1]^2+ outMatrix[4]^2))
  tempa = math.atan(outMatrix[4] / math.cos(tempb), outMatrix[1] / math.cos(tempb))
  tempr = math.atan(outMatrix[8] / math.cos(tempb), outMatrix[9] / math.cos(tempb))

  outRz = (tempa * (180 / math.pi));
  outRy = (tempb * (180 / math.pi));
  outRx = (tempr * (180 / math.pi));
  
  return outRx, outRy, outRz
  end
  
--From HCRRobotCommunication Class
function MakeXYZAngleToRMatrix(inRx, inRy, inRz)
  matrix = {0, 0, 0, 0, 0, 0, 0, 0, 0}
  r = math.pi * (inRx / 180)
  b = math.pi * (inRy / 180)
  a = math.pi * (inRz / 180)
  matrix[1] = math.cos(a) * math.cos(b)
  matrix[2] = math.cos(a) * math.sin(b) * math.sin(r) - math.sin(a) * math.cos(r)
  matrix[3] = math.cos(a) * math.sin(b) * math.cos(r) + math.sin(a) * math.sin(r)
  matrix[4] = math.sin(a) * math.cos(b)
  matrix[5] = math.sin(a) * math.sin(b) * math.sin(r) + math.cos(a) * math.cos(r)
  matrix[6] = math.sin(a) * math.sin(b) * math.cos(r) - math.cos(a) * math.sin(r)
  matrix[7] = -math.sin(b)
  matrix[8] = math.cos(b) * math.sin(r)
  matrix[9] = math.cos(b) * math.cos(r)
  return matrix
end
--From HCRRobotCommunication Class
function MakeAxisAndAngleToRMatrix(Vx, Vy, Vz, Angle)
  M = math.sqrt(Vx^2 + Vy^2 + Vz^2)
  Vx = Vx / M
  Vy = Vy / M
  Vz = Vz / M
  
  matrix = {0, 0, 0, 0, 0, 0, 0, 0, 0}
  a = math.pi * (Angle / 180)
  w = math.cos(a / 2)
  x = math.sin(a / 2) * Vx
  y = math.sin(a / 2) * Vy
  z = math.sin(a / 2) * Vz
  
  matrix[1] = 1-2*y*y-2*z*z
  matrix[2] = 2*x*y-2*w*z
  matrix[3] = 2*x*z+2*w*y
  matrix[4] = 2*x * y +2 * w * z
  matrix[5] = 1-2 * x * x - 2 * z * z
  matrix[6] = 2 * y * z-2 * w * x
  matrix[7] = 2 * x * z -2 * w * y
  matrix[8] = 2 * y * z+2 * w * x
  matrix[9] = 1-2 * x * x-2 * y * y
  
  return matrix
end

function MakeMatrixMul(Matrix1, Matrix2)
  matrix3 = {0, 0, 0, 0, 0, 0, 0, 0, 0}
  
  matrix3[1] = Matrix1[1] * Matrix2[1] + Matrix1[2] * Matrix2[4] + Matrix1[3] * Matrix2[7]
  matrix3[2] = Matrix1[1] * Matrix2[2] + Matrix1[2] * Matrix2[5] + Matrix1[3] * Matrix2[8]
  matrix3[3] = Matrix1[1] * Matrix2[3] + Matrix1[2] * Matrix2[6] + Matrix1[3] * Matrix2[9]
  matrix3[4] = Matrix1[4] * Matrix2[1] + Matrix1[5] * Matrix2[4] + Matrix1[6] * Matrix2[7]
  matrix3[5] = Matrix1[4] * Matrix2[2] + Matrix1[5] * Matrix2[5] + Matrix1[6] * Matrix2[8]
  matrix3[6] = Matrix1[4] * Matrix2[3] + Matrix1[5] * Matrix2[6] + Matrix1[6] * Matrix2[9]
  matrix3[7] = Matrix1[7] * Matrix2[1] + Matrix1[8] * Matrix2[4] + Matrix1[9] * Matrix2[7]
  matrix3[8] = Matrix1[7] * Matrix2[2] + Matrix1[8] * Matrix2[5] + Matrix1[9] * Matrix2[8]
  matrix3[9] = Matrix1[7] * Matrix2[3] + Matrix1[8] * Matrix2[6] + Matrix1[9] * Matrix2[9]
  
  return matrix3
end
  

function CalcMiddleposeStartOffset(SPose, EPose, Offset, Angle)
  temppose = RobotPoseData:new()
  tempd1 = EPose.f1 - SPose.f1
  tempd2 = EPose.f2 - SPose.f2
  tempd3 = EPose.f3 - SPose.f3
  weldLength = math.sqrt(tempd1^2 + tempd2^2 + tempd3^2)
  temppose.f1 = (SPose.f1 + tempd1 / weldLength * Offset)
  temppose.f2 = (SPose.f2 + tempd2 / weldLength * Offset)
  temppose.f3 = (SPose.f3 + tempd3 / weldLength * Offset)
  temppose.f4 = Angle.f4
  temppose.f5 = Angle.f5
  temppose.f6 = Angle.f6
  return temppose
end

function RobotStartEndToDirCal(StartPose, EndPose)
  dirX = EndPose.f1 - StartPose.f1
  dirY = EndPose.f2 - StartPose.f2
  dirZ = EndPose.f3 - StartPose.f3
  Length = math.sqrt(dirX^2 + dirY^2 + dirZ^2)
  dirX = dirX / Length
  dirY = dirY / Length
  dirZ = dirZ / Length
  return dirX, dirY, dirZ, Length
end

function RobotPoseToTooldirCal(RobotPose)
  initMatrix = MakeXYZAngleToRMatrix(RobotPose.f4, RobotPose.f5, RobotPose.f6)
  dirX = initMatrix[3]
  dirY = initMatrix[6]
  dirZ = initMatrix[9]
  return dirX, dirY, dirZ
end

function VectorCrossProduct(FirstX, FirstY, FirstZ, SecondX, SecondY, SecondZ)
  resultX = FirstY * SecondZ - FirstZ * SecondY
  resultY = FirstZ * SecondX - FirstX * SecondZ
  resultZ = FirstX * SecondY - FirstY * SecondX
  return resultX, resultY, resultZ
end

function print_r(arr, indentLevel)
    local str = ""
    local indentStr = "#"

    if(indentLevel == nil) then
        print(print_r(arr, 0))
        return
    end

    for i = 0, indentLevel do
        indentStr = indentStr.."\t"
    end

    for index,value in pairs(arr) do
        if type(value) == "table" then
            str = str..indentStr..index..": \n"..print_r(value, (indentLevel + 1))
        else 
            str = str..indentStr..index..": "..value.."\n"
        end
    end
    return str
end