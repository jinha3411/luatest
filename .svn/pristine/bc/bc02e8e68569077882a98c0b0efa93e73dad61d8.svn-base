--local alg = require "stat"
--obj:Func1(500)
package.path = package.path .. ";C:/HHIAutomation/OpenBlockWeldingRobot_Server/LuaLibs/?.lua"
--library_file = require("library_a")
require("RobotWeldAngle")
require("library_a")

integer_test = 15
floating_test = 15.12
double_test = 16.12345678912345
string_test = "Automation Research Department"
array_list = {1.123, 2, 3, 4, 5, 6, 7}
matrix = {}
matrix[0] = {1, 2, 3}
matrix[1] = {4, 5, 6}
matrix[2] = {7, 8, 9}

--haha_output = file_file:haha()
--output_A = haha_output
--output_B = file_file.B
--output_C = file_file.inner_data.C
--output_D = file_file.inner_data.D

thread_test_val = 5
function function_test_integer (input_a, input_b)
  local sum = 0
  sum = input_a + input_b
  return sum
end


function function_test_array (input_a, input_b)
  local array_list = {input_a, input_b}
  return array_list  
end

function function_return_multiple (input_a, input_b)
  local array_list = {input_a, input_b, input_a + input_b}
  return input_a, input_b, array_list
end

function function_include_test()
  local output = library_file.get_sine(0.3)
  return output
end

co = coroutine.create(function()
    local new_value = thread_test_val
    while (true)
    do
      new_value = new_value - 1
      coroutine.yield(new_value)
    end
  
end
)

function function_coroutine_test(value)
    status, output_value = coroutine.resume(co)
    return output_value
end
      
--haha_output = file_file:haha()
--print("end of execution")

test = RobotPoseData:new()
