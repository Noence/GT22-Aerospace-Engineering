# -*- coding: utf-8 -*-
"""
Created on Wed Oct 14 15:40:30 2020

@author: Noe Lepez Da Silva Duarte

AE 3330 - MIDTERM PROJECT
"""
#Packages
import math
import getpass
import tkinter as tk
from datetime import date
user = getpass.getuser()   

#Set values
coriolis = 0.05883
mu = 3.986*10**5
Rearth = 6378.145

#GUI creation

fields = ('Range X,Y,Z', 'Range rate X,Y,Z', 'Initial Greenwich sidereal time (in degrees)', 'Day of Initial sidereal time DD,MM,YYYY', 'Day the object was seen in GMT DD,MM,YYYY,HH:mm', 'Longitude (west is negative)', 'Latitude', 'Time of Flight (in hours)')

def bigAngle(angle):
    if angle>360:
        angle = angle - 360* int(angle/360)
    return angle

def Orbital_elements(entries):
    f= open("C:\\Users\%s\Desktop\Outputs_NoeDSDL.txt" % (user),"w+")
    f.write("This is the output file for the AE 3330 Midterm project by Noe Lepez Da Silva Duarte \n \n")
    
    rhoi = str(entries['Range X,Y,Z'].get())
    drhoi = str(entries['Range rate X,Y,Z'].get())
    
    rhoi = rhoi.replace(" ","")
    rhoi = rhoi.split(",")
    rhox = float(rhoi[0])
    rhoy = float(rhoi[1])
    rhoz = float(rhoi[2])
    
    drhoi = str(entries['Range rate X,Y,Z'].get())
    drhoi = drhoi.replace(" ","")
    drhoi = drhoi.split(",")
    dRhox = float(drhoi[0])
    dRhoy = float(drhoi[1])
    dRhoz = float(drhoi[2])
    
    theta0 = float(entries['Initial Greenwich sidereal time (in degrees)'].get())
    #Days = float(entries['Days'].get())
    longitude = float(entries['Longitude (west is negative)'].get())
    latitude = float(entries['Latitude'].get())
    Lrad = math.radians(latitude)
    TOF = float(entries['Time of Flight (in hours)'].get())
    
    #Getting days
    iDay = str(entries['Day of Initial sidereal time DD,MM,YYYY'].get())
    iDay = iDay.replace(" ","")
    iDay = iDay.split(",")
    i_date = date(int(iDay[2]), int(iDay[1]), int(iDay[0]))
    
    fDay = str(entries['Day the object was seen in GMT DD,MM,YYYY,HH:mm'].get())
    fDay = fDay.replace(" ","")
    fDay = fDay.split(",")
    f_date = date(int(fDay[2]), int(fDay[1]), int(fDay[0]))
    delta = f_date - i_date
    fHours = float(fDay[3][0:2])/24 + float(fDay[3][3:5])/(60*24)
    print(fDay[3][0:2],fDay[3][3:5],  fHours)
    days = delta.days + fHours 
    print(days)
    
    #PART 1
    f.write("Part 1 \n")
    f.write("a) Determine the position and velocity vectors in the Earth-centered inertial, equatorial coordinate system. \n")

    #Step 1. Calculate Mean Sidereal time

    #CHANGE THEATA0 TO AN INPUT VARIABLE

    theta = theta0 + 1.00273779093*360*days
    theta = theta - 360* int(theta/360)
    theta = theta + longitude
    print(theta)    
    thetaRad = math.radians(theta)

    #Step 2. Calculate rh

    rhoz = 1 + rhoz

    #Step 3. Radius planet centered equatorial coordinate frame

    PCEx = math.sin(Lrad) * math.cos(thetaRad) * rhox - math.sin(thetaRad) * rhoy + math.cos(Lrad) * math.cos(thetaRad) * rhoz
    PCEy = math.sin(Lrad) * math.sin(thetaRad) * rhox + math.cos(thetaRad) * rhoy + math.cos(Lrad) * math.sin(thetaRad) * rhoz
    PCEz = -math.cos(Lrad) * rhox + math.sin(Lrad) *rhoz
    r = math.sqrt(PCEx**2 + PCEy**2 + PCEz**2)

    f.write("The position of the object in the planet centered equatorial coordinate frame is %0.5fx, %0.5fy, %0.5fz DU. \n" % (PCEx, PCEy, PCEz))

    #Step 4. Make range rate into PCE coordinate frame

    PCEdRhox = math.sin(Lrad) * math.cos(thetaRad) * dRhox - math.sin(thetaRad) * dRhoy + math.cos(Lrad) * math.cos(thetaRad) * dRhoz
    PCEdRhoy = math.sin(Lrad) * math.sin(thetaRad) * dRhox + math.cos(thetaRad) * dRhoy + math.cos(Lrad) * math.sin(thetaRad) * dRhoz
    PCEdRhoz = -math.cos(Lrad) * dRhox + math.sin(Lrad) * dRhoz
    f.write("The range rate of the object in the planet centered equatorial coordinate frame is  %0.5fx, %0.5fy, %0.5fz DU/TU. \n" % (PCEdRhox, PCEdRhoy, PCEdRhoz))

    
    #Step 5. Find velocity 
    
    Vx = PCEdRhox -PCEy * coriolis
    Vy = PCEdRhoy + PCEx * coriolis
    Vz = PCEdRhoz
    V = math.sqrt(Vx**2 + Vy**2 +Vz**2)
    f.write("The velocity of the object in the planet centered equatorial coordinate frame is  %0.5fx, %0.5fy, %0.5fz DU/TU. \n \n" % (Vx, Vy, Vz))
    
    #Finding orbital elements
    f.write("b) Determine the orbital elements of the of the ISS at the time of the observation. \n")
    #Eccentricity
    
    angMomX = PCEy*Vz - PCEz*Vy
    angMomY = PCEz*Vx - PCEx*Vz
    angMomZ = PCEx*Vy - PCEy*Vx
    angMom = math.sqrt(angMomX**2 + angMomY**2 + angMomZ**2)

    n = math.sqrt(angMomY**2 + angMomX**2)
    
    rV = PCEx * Vx + PCEy * Vy + PCEz * Vz
    T1 = (V**2) - (1/(r))
    eX = ((T1)*PCEx) - ((rV)*Vx) 
    eY = ((T1)*PCEy) - ((rV)*Vy)
    eZ = ((T1)*PCEz) - ((rV)*Vz)
    e = math.sqrt(eX**2 + eY**2 + eZ**2)
    f.write("The eccentricity of the orbit is %0.6f, or %0.6fx, %0.6fy, %0.6fz. \n" % (e, eX, eY, eZ))
    #Semi-major axis
    a = (angMom**2)/(1-e**2)
    f.write("The semi-major axis of the orbit is %0.6fDU. \n" % (a))
    
    
    #Inclination
    i = math.degrees(math.acos(angMomZ/angMom))
    if i>180:
        i=360-i
        
    f.write("The inclination of the orbit is %0.6f degrees. \n" % (i))
    
    #Longitude of ascending node
    LAN = math.degrees(math.acos(-angMomY/n))
    if angMomX > 0 and LAN >180:
        LAN = 360-LAN
    elif angMomX<0 and LAN<180:
        LAN = 360 -LAN
    
    f.write("The longitude of ascending node of the orbit is %0.6f degrees. \n" % (LAN))
    
    
    #Argument of periapsis
    NE = -angMomY * eX + angMomX * eY
    AP = math.degrees(math.acos(NE/(n*e)))
    if eZ >0 and AP >180:
        AP = 360-AP
    elif eZ <0:
        AP = 360-AP
    
    f.write("The argument of periapsis of the orbit is %0.6f degrees. \n" % (AP))
    
    
    #True anomaly
    ER = eX*PCEx + eY*PCEy + eZ*PCEz
    nu = math.degrees(math.acos(ER/(r*e)))
    
    if rV >0 and nu>180:
        nu = 360-nu
    elif rV<0 and nu<180:
        nu = 360-nu
    f.write("The true anomaly of the orbit is %0.6f degrees.  \n" % (nu))

    #Longitude of periapsis
    bPI = LAN + AP
    bPI = bigAngle(bPI)
    f.write("The longitude of periapsis of the orbit is %0.6f degrees. \n" % (bPI))

    #Argument of latitude
    AL = nu + AP
    AL = bigAngle(AL)
    f.write("The argument of latitude of the orbit is %0.6f degrees. \n" % (AL))

    #True longitude
    TL = bPI +nu
    bigAngle(TL)
    f.write("The true longitude of the orbit is %0.6f degrees. \n \n" % (TL))

    #PART 2
    f.write("Part 2 \n")
    f.write("a) Solve Kepler’s problem to determine the true anomaly of the ISS 45 minutes later.\n")
    # Step 1. Preliminary calculations
    
    aKM = a*Rearth
    period = 2 * math.pi * math.sqrt((aKM**3)/(mu))
    TOFs = TOF *3600 
    periapsisPass = int(TOFs/period)
    E0 = math.acos((e+math.cos(math.radians(nu))))
    M0 = E0 - e*math.sin(E0)
    M = math.sqrt((mu)/(aKM**3)) *TOFs - 2*periapsisPass*math.pi + M0
    dME = 1
    Ei = 0
    Ein = 0.5 
    counter = 0
    poggersList = []       
    while Ei != Ein:
        Ei = Ein
        mDiff = M- (Ei -e*math.sin(Ei))
        dME = 1- e*math.cos(Ei)
        Ein = Ei + (mDiff)/dME
        poggersList.append([counter, Ei, mDiff, dME, Ein])
        counter+=1 
          
    nuPass = math.degrees(math.acos((math.cos(Ein) - e)/(1 - e*math.cos(Ein))))
    
    f.write("The true anomaly after %0.2f hours is %0.3f (table with iteration history can be found later in this file). \n \n" % (TOF, nuPass))
    f.write("b) Determine the position and velocity vectors of the ISS at this new true anomaly in the Earth-centered inertial, equatorial coordinate system \n")
    
    rWx = r * math.cos(math.radians(nuPass))
    rWy = r * math.sin(math.radians(nuPass))
    
    P = (a * (1 - (e**2)))
    
    vWx = math.sqrt(1/P) * - math.sin(math.radians(nuPass))
    vWy = math.sqrt(1/P) * (e + math.cos(math.radians(nuPass)))
    
    cosO = math.cos(math.radians(LAN))
    sinO = math.sin(math.radians(LAN))
    cosW = math.cos(math.radians(AP))
    sinW = math.sin(math.radians(AP))
    cosI = math.cos(math.radians(i))
    sinI = math.sin(math.radians(i))                                                                         
    
    R11 = cosO * cosW - sinO * sinW * cosI
    R12 = - cosO * sinW - sinO * cosW * cosI
    R13 = sinO * sinI
    R21 = sinO * cosW + cosO * sinW * cosI
    R22 = - sinO * sinW + cosO * cosW * cosI
    R23 = - cosO * sinI
    R31 = sinW * sinI
    R32 = cosW * sinI
    R33 = cosI
    
    PrX = R11 * rWx + R12 * rWy
    PrY = R21 * rWx + R22 * rWy
    PrZ = R31 * rWx + R32 * rWy
    
    PvX = R11 * vWx + R12 * vWy
    PvY = R21 * vWx + R22 * vWy
    PvZ = R31 * vWx + R32 * vWy
    
    f.write("The position of the object in the Earth-centered inertial, equatorial coordinate system at the new true anomaly of %0.3f degrees is %0.5fx, %0.5fy, %0.5fz DU. \n" % (nuPass, PrX, PrY, PrZ))
    f.write("The velocity of the object in the Earth-centered inertial, equatorial coordinate system at the new true anomaly of %0.3f degrees is %0.5fx, %0.5fy, %0.5fz DU/TU. \n \n" % (nuPass, PvX, PvY, PvZ))
    f.write("Iteration history: \n")
    
    f.write(": Iteration (n) :      En       :          (M - Mn)          :     dM/dE     :     En+1     : \n")
    for item in poggersList:
        f.write(": " + str(item[0]) + " "*(13-len(str(item[0]))) + " : " +
                str(item[1])[0:12] + " "*(13-len(str(item[1])[0:12])) + " : " +
                str(item[2]) + " "*(26-len(str(item[2]))) + " : " +
                str(item[3])[0:12] + " "*(13-len(str(item[3])[0:12])) + " : " +
                str(item[4])[0:12] + " "*(13-len(str(item[4])[0:12])) + ": \n")
    f.close()

def makeform(root, fields):
    entries = {}
    for field in fields:
        print(field)
        row = tk.Frame(root)
        lab = tk.Label(row, width=45, text=field+": ", anchor='w')
        ent = tk.Entry(row)
        ent.insert(0, "0")
        row.pack(side=tk.TOP, 
                 fill=tk.X, 
                 padx=10, 
                 pady=10)
        lab.pack(side=tk.LEFT)
        ent.pack(side=tk.RIGHT, 
                 expand=tk.YES, 
                 fill=tk.X)
        entries[field] = ent
    return entries

if __name__ == '__main__':
    root = tk.Tk()
    root.title("GUI")
    ents = makeform(root, fields)
    b1 = tk.Button(root, text='Create solution document',
           command=(lambda e=ents: Orbital_elements(e)))
    b1.pack(side=tk.LEFT, padx=5, pady=15)
    root.mainloop()
