from controller import Robot

robot = Robot()

timestep = int(robot.getBasicTimeStep())

last_error = I = D = P = error = 0
kp=1.0
ki=0.005
kd=1.9


updateCalibration = 15
max_speed = 2.0

#motor
left_motor = robot.getDevice('m1')
right_motor = robot.getDevice('m2')
back_left_motor = robot.getDevice('m4')
back_right_motor = robot.getDevice('m3')

left_motor.setPosition(float('inf'))
right_motor.setPosition(float('inf'))
back_left_motor.setPosition(float('inf'))
back_right_motor.setPosition(float('inf'))

left_motor.setVelocity(0.0)
right_motor.setVelocity(0.0)
back_left_motor.setVelocity(0.0)
back_right_motor.setVelocity(0.0)

#IR sensors
rightIR = robot.getDevice('ds_right')
rightIR.enable(updateCalibration)
midIR = robot.getDevice('ds_mid')
midIR.enable(updateCalibration)
leftIR = robot.getDevice('ds_left')
leftIR.enable(updateCalibration)

#Mainloop
while robot.step(timestep) !=-1:

    rightIR_val = rightIR.getValue()
    midIR_val = midIR.getValue()
    leftIR_val = leftIR.getValue()

    print(f"left: {leftIR_val} mid: {midIR_val} right : {rightIR_val}")
    
    left_speed = max_speed
    right_speed = max_speed
    
    if leftIR_val<700 and rightIR_val<700 and midIR_val >=700:
        error=0
        
    elif leftIR_val<700 and rightIR_val>=700 and midIR_val >=700:
        error=-1
    
    elif leftIR_val>=700 and rightIR_val<700 and midIR_val >=700:
        error=1
    
    elif leftIR_val<700 and rightIR_val>=700 and midIR_val <700:
        error=-2
    
    elif leftIR_val>=700 and rightIR_val<700 and midIR_val <700:
        error=2
    
    
    P = error
    print(f"P: {P}")
    I = error + I
    print(f"I: {I}")
    D = error - last_error
    print(f"D: {D}")
    balance = int((kp*P)+(ki*I)+(kd*D))
    print(f"balance: {balance}")
    last_error = error
    print(f"last_error: {last_error}")
    
    left_speed = max_speed - balance
    print(f"left_speed: {left_speed}")
    right_speed = max_speed + balance
    print(f"right_speed: {right_speed}")
    
    #Sensor data processing
    if left_speed > max_speed or right_speed <0:
        left_motor.setVelocity(left_speed)
        right_motor.setVelocity(0)
        back_left_motor.setVelocity(left_speed)
        back_right_motor.setVelocity(0)
    if right_speed > max_speed or left_speed <0:
        left_motor.setVelocity(0)
        right_motor.setVelocity(right_speed)
        back_left_motor.setVelocity(0)
        back_right_motor.setVelocity(right_speed)
        
    if right_speed == max_speed:
        left_motor.setVelocity(left_speed)
        right_motor.setVelocity(right_speed)
        back_left_motor.setVelocity(left_speed)
        back_right_motor.setVelocity(right_speed)
        
    pass
    