TouchSensingData = {}
TouchSensingData.__index = TouchSensingData

function TouchSensingData:new()
  output = {}
  output.In_Length = 0
  output.In_Speed = 0
  output.In_coord =0
  output.In_X = 0
  output.In_Y = 0
  output.In_Z = 0

  output.Out_Length = 0
  output.Out_Speed = 0
  output.Out_coord =0
  output.Out_X = 0
  output.Out_Y = 0
  output.Out_Z = 0
  setmetatable(output, TouchSensingData)
  return output
end

function TouchSensingData:createData(iLength, iSpeed, iCoord, iX, iY, iZ, oLength, oSpeed, oCoord, oX, oY, oZ)
  output = {}
  output.In_Length = iLength;
  output.In_Speed = iSpeed;
  output.In_coord = iCoord;
  output.In_X = iX;
  output.In_Y = iY;
  output.In_Z = iZ;

  output.Out_Length = oLength;
  output.Out_Speed =oSpeed;
  output.Out_coord = oCoord;
  output.Out_X =oX;
  output.Out_Y = oY;
  output.Out_Z = oZ;
  setmetatable(output, TouchSensingData)
  return output
end

function TouchSensingData:createFromTable(table_)
  output = {}
  output.In_Length = table_.iLength;
  output.In_Speed = table_.iSpeed;
  output.In_coord = table_.iCoord;
  output.In_X = table_.iX;
  output.In_Y = table_.iY;
  output.In_Z = table_.iZ;

  output.Out_Length = table_.oLength;
  output.Out_Speed =table_.oSpeed;
  output.Out_coord = table_.oCoord;
  output.Out_X =table_.oX;
  output.Out_Y = table_.oY;
  output.Out_Z = table_.oZ;
  setmetatable(output, TouchSensingData)
  return output
end

