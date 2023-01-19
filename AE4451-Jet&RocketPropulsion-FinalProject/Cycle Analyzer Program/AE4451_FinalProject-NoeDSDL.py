"""
Ae 4451 Final Project
Cycle Analysis of a Turbine Based Combined Cycle Mach 4 Engine

By Noe Lepez Da Silva Duarte
"""
# Packages
import numpy as np
import matplotlib.pyplot as plt
import tkinter as tk
import getpass
user = getpass.getuser()

# Variables
Gamma = 1.4
Pr = 10
Cp = 1.004  # kJ/kg
Qr = 44.240 * 1000  # kJ/kg
ma = 80  # kg/s
R = 287  # J/kg.K
Aa = 0.8  # m
Ae = 0.6  # m
engineW = 3000  # kg

fields = ('Takeoff Temperature (K)', 'Takeoff Pressure (kPa)',
          'Cruise Temperature (K)', 'Cruise Pressure (kPa)',
          'Cycle plots (ON or OFF)', 'Flight Time (minutes)', 'Fuel (kg)',
          'Range (km)')

f= open("C:\\Users\%s\Desktop\Outputs_NoeDSDL.txt" % (user),"w+")
f.write("This is the output file for the AE 4451 Final project by Noe "
        "Lepez Da Silva Duarte \n\n\n0. General Engine Characteristics:\n"
        "The engine consists of a Turbojet (TJ) and a Ramjet (RJ). The TJ "
        "can use the ramjet burner as an afterburner.\n     TJ Comperssor "
        "pressure ratio: %d\n     Fuel used and heating value: Decane "
        "(C10H22), Qr = %d kJ/kg\n     Inflow mass flow rate: %dkg/s\n    "
        " Engine Dry Mass: %dkg\n     Inlet Diameter: %0.1fm\n\n\n"
        % (Pr, Qr, ma, engineW, Aa))

##############################################################################
# Isentropic relations and conversions


def StgFinder(M, T, P):
    T0 = T * (1 + ((Gamma - 1) / 2) * M ** 2)
    P0 = P * (1 + ((Gamma - 1) / 2) * M ** 2) ** ((Gamma - 1) / Gamma)
    return T0, P0


def TempFinder(T2, P1, P2):
    T1 = T2 * (P1 / P2) ** ((Gamma - 1) / Gamma)
    return T1


def PresFinder(P2, T1, T2):
    P1 = P2 * (T1 / T2) ** (Gamma / (Gamma - 1))
    return P1


def machFinder(T0, T):
    ratio = (T0 / T) - 1
    constants = 2 / (Gamma - 1)
    M = np.sqrt(ratio * constants)
    return M


def machConverter(M, T):
    u = M * np.sqrt(Gamma * R * T)
    return u


def thrustFinder(me, ue, ma, ua, Pe, Pa, Ae):
    Thrust = me * ue - ma * ua - (Pe - Pa) * Ae  # N
    TSFC = (me - ma) * 1000 / (Thrust / 1000)  # g/kN.s
    return Thrust, TSFC


def entropyFinder(T1, T2, P1, P2):
    ds = Cp * np.log(T2 / T1) - (R / 1000) * np.log(P2 / P1)
    return ds


def velocityConverter(u, T):
    M = u / np.sqrt(Gamma * R * T)
    return M


def postShock(Ma, Ta, Pa):
    M2 = Ma ** 2
    T = Ta * ((2 * Gamma * M2 - (Gamma - 1))) * ((Gamma - 1) * M2 + 2) / (
                ((Gamma + 1) ** 2) * M2)
    P = Pa * (2 * Gamma * M2 - (Gamma - 1)) / (Gamma + 1)
    M = np.sqrt(((Gamma - 1) * M2 + 2) / (2 * Gamma * M2 - (Gamma - 1)))
    P0 = ((1 + ((Gamma - 1) / 2) * M ** 2) ** (Gamma / (Gamma - 1))) * P
    return T, P, P0


def graphMaker(dss, T, name, title):
    # Plotting the cycle
    plot1 = plt.figure()
    ax = plot1.add_subplot(111)

    ax.plot(dss, T)

    # create axes and labels
    plt.title(title)
    ax.set_xlabel('Entropy (kJ/K)')
    ax.set_ylabel('Temperature (K)')
    plt.grid()
    plt.savefig(name, dpi=300)
    return plot1


def graphMakerMult(dssTJ, dssRJ, TTJ, TRJ, name, title):
    # Plotting the cycle
    plot1 = plt.figure()
    ax = plot1.add_subplot(111)

    ax.plot(dssTJ, TTJ)
    ax.plot(dssRJ, TRJ)


    # create axes and labels
    ax.set_xlabel('Entropy (kJ/K)')
    ax.set_ylabel('Temperature (K)')
    plt.title(title)
    plt.grid()
    plt.savefig(name, dpi=300)
    return plot1



##############################################################################
# Turbojet Cycle (for takeoff and subsonic cruise)


def TJCycle(Ta, Pa, M, T04, time):
    ua = machConverter(M, Ta)

    # Nozzle Properties
    [T02, P02] = StgFinder(M, Ta, Pa)

    # Compressor exit properties
    P03 = P02 * Pr
    T03 = TempFinder(T02, P03, P02)

    # Combustor properties
    # Assume P03=P04 and M~0 in combustor
    P04 = P03
    mfc = ma * Cp * (T04 - T03) / Qr

    # Turbine exit properties
    # f=m1/mf<<1 therefore Cpt = Cpc can be assumed and all energy is used to
    # run the compressor
    T05 = -((ma * (T03 - T02) / (mfc + ma)) - T04)
    P05 = PresFinder(P03, T05, T04)
    P5 = Pa
    T5 = TempFinder(T05, Pa, P05)
    M5 = machFinder(T05, T5)
    ue = machConverter(M5, T5)
    Mo = velocityConverter(ue, Ta)

    # Finding the change in entropy between each stage
    temperatures = [T02, T03, T04, T05]
    pressures = [P02, P03, P04, P05]
    i = 0
    dss = [0]
    while i < len(temperatures) - 1:
        dss.append(
            entropyFinder(temperatures[i], temperatures[i + 1], pressures[i],
                          pressures[i + 1]) + dss[i])
        i += 1



    # Fuel - TSFC - Power calculation
    me = ma + mfc
    [thrust, TSFC] = thrustFinder(me, ue, ma, ua, P5, Pa, Ae)
    fuelExpanded = mfc * time * 60
    power = ma*(T03-T02)*Cp

    # Efficiency calculations
    ET = 1 - (T02 / T03)
    EP = (2*(ua/ue))/(1+(ua/ue))

    # Distance travelled
    dist = ((ua+ue)/2)*time*60

    return temperatures, pressures, dss, Mo, thrust, TSFC, fuelExpanded, ET, EP, ue, mfc, power, dist


##############################################################################
# Turbojet+Afterburner Cycle (for acceleration to M = 3)


def ABCruise(Ta, Pa, M):
    time = 1
    T04 = 680  # K
    T06 = 1750  # K
    ua = machConverter(M, Ta)

    # Nozzle Properties
    [T02, P02] = StgFinder(M, Ta, Pa)

    # Compressor exit properties
    P03 = P02 * Pr
    T03 = TempFinder(T02, P03, P02)

    # Combustor properties
    # Assume P03=P04 and M~0 in combustor
    P04 = P03
    mfc = ma * Cp * (T04 - T03) / Qr

    # Turbine exit properties
    # Assume f=m1/mf<<1 therefore Cpt = Cpc and all energy is used to
    # run the compressor
    T05 = -((ma * (T03 - T02) / (mfc + ma)) - T04)
    P05 = PresFinder(P03, T05, T04)

    # Fuel flow rate in afterburner
    P06 = P05
    mfa = (mfc + ma) * Cp * (T06 - T05) / Qr

    # Exit Properties
    # Assume exit pressure is equal to surrounding pressure and P07=P06=P05
    P7 = Pa
    P07 = P06
    T07 = T06
    T7 = TempFinder(T07, P7, P07)
    M7 = machFinder(T07, T7)
    ue = machConverter(M7, T7)
    Mo = velocityConverter(ue, Ta)
    #print(M7, Mo, ue)

    # Finding the change in entropy between each stage
    temperatures = [T02, T03, T04, T05, T06, T7]
    pressures = [P02, P03, P04, P05, P06, P7]
    i = 0
    dss = [0]
    while i < len(temperatures) - 1:
        dss.append(
            entropyFinder(temperatures[i], temperatures[i + 1], pressures[i],
                          pressures[i + 1]) + dss[i])
        i += 1


    # Fuel and TSFC calculation
    me = ma + mfc
    [thrust, TSFC] = thrustFinder(me, ue, ma, ua, P7, Pa, Ae)
    fuelExpanded = (mfc + mfa) * time * 60
    power = ma*(T03-T02)*Cp

    # Efficiency calculations
    ET = 1 - (T02 / T03)
    EP = (thrust * ua) / (((me * ue ** 2) / 2) - ((ma * ua ** 2) / 2))

    #Distance travelled constant acceleration during 1 minute
    dist = ((ua+ue)/2)*time*60

    return temperatures, pressures, dss, Mo, thrust, TSFC, fuelExpanded, ET, EP, ue, mfc, mfa, power, dist


##############################################################################
# Start of Ramjet + Turbojet as RJ starts up (M = 3)


def TJRJ(Ta, Pa, M):
    time = 1
    T08 = 1700  # K
    ua = machConverter(M, Ta)

    # 25% of air goes through the TJ, 75% goes to RJ to start RJ
    maTJ = ma / 4
    maRJ = ma * 3 / 4
    ##########################################################################
    # TJ Cycle

    pressures = []
    temperatures = []
    # Nozzle Properties
    [T02, P02] = StgFinder(M, Ta, Pa)

    # Compressor exit properties
    P03 = P02 * 10
    T03 = TempFinder(T02, P03, P02)
    T3 = TempFinder(Ta, P03, P02)

    # Combustor properties
    # Assume P03=P04 and M~0 in combustor
    P04 = P03
    T04 = T03
    mfc = maTJ * Cp * (T04 - T03) / Qr

    # Turbine exit properties
    # Assume f=m1/mf<<1 therefore Cpt = Cpc and all energy is used to
    # run the compressor
    T05 = -((ma * (T03 - T02) / (mfc + ma)) - T04)
    P05 = PresFinder(P03, T05, T04)

    ##########################################################################
    # RJ cycle

    # Post normal shock properties
    [T6, P6, P06] = postShock(M, Ta, Pa)
    T06 = TempFinder(T6, P06, P6)

    # Combustor properties
    # Assume complete mixing before reaching combustor and M~0
    P07 = (P06*3/4) + (P05*1/4)
    T07 = (T06*3/4) + (T05*1/4)
    mfRJ = ma * Cp * (T08 - T07) / Qr
    P08 = PresFinder(P07, T08, T08)

    # Exit properties
    # Assume exit pressure is equal to surrounding pressure and P08=P09 and
    # T04=T05
    P9 = Pa
    P09 = P08
    T09 = T08
    T9 = TempFinder(T08, P9, P09)
    M9 = machFinder(T09, T9)
    ue = machConverter(M9, T9)
    Mo = velocityConverter(ue, Ta)
    #print(M9, Mo, ue)

    pressuresTJ = [P02, P03, P04, P05]
    temperaturesTJ = [T02, T03, T04, T05]
    pressuresRJ = [Pa, P06, P08, P9]
    temperaturesRJ = [Ta, T06, T08, T9]
    i = 1
    dssTJ = [0, 0]
    dssRJ = [0, 0]
    while i < len(temperaturesTJ) - 1:
        dssTJ.append(entropyFinder(temperaturesTJ[i], temperaturesTJ[i + 1],
                                   pressuresTJ[i], pressuresTJ[i + 1]) + dssTJ[
                         i])
        i += 1

    j = 1
    while j < len(temperaturesRJ) - 1:
        if j == 1:
            dssRJ.append(
                entropyFinder(temperaturesRJ[j], temperaturesRJ[j + 1],
                              pressuresRJ[j], pressuresRJ[j + 1]) + dssRJ[j] +
                dssTJ[i])
        else:
            dssRJ.append(
                entropyFinder(temperaturesRJ[j], temperaturesRJ[j + 1],
                              pressuresRJ[j], pressuresRJ[j + 1]) + dssRJ[j])
        j += 1


    # Fuel and TSFC calculation
    me = ma + mfc + mfRJ
    [thrust, TSFC] = thrustFinder(me, ue, ma, ua, P9, Pa, Ae)
    fuelExpanded = (mfc + mfRJ) * time * 60
    power = ma * (T03 - T02) * Cp

    # Efficiency calculations
    ETTJ = 1 - (Ta / T3)
    ETRJ = 1 - (Ta / T6)
    EP = (thrust * ua) / (((me * ue ** 2) / 2) - ((ma * ua ** 2) / 2))

    #Distance travelled
    dist = ((ua+ue)/2)*time*60

    return temperaturesTJ, temperaturesRJ, pressuresTJ, pressuresRJ, dssTJ, dssRJ, Mo, ue, thrust, TSFC, mfc, mfRJ, fuelExpanded, power, ETTJ, EP, ETRJ, dist


##############################################################################
# Ramjet (M > 3)


def RJCycle(Ta, Pa, M, time):
    T04 = 1600  # K
    ua = machConverter(M, Ta)

    # Nozzle Properties
    [T02, P02] = StgFinder(M, Ta, Pa)

    # Post normal shock properties

    [T3, P3, P03] = postShock(M, Ta, Pa)
    T03 = TempFinder(T3, P03, P3)

    # Combustor properties
    # Assume P03=P04 and M~0 in combustor
    P04 = P03
    mfc = ma * Cp * (T04 - T03) / Qr

    # Exit properties
    # Assume exit pressure is equal to surrounding pressure and P04=P05 and
    # T04=T05
    P5 = Pa
    P05 = P04
    T05 = T04
    T5 = TempFinder(T04, P5, P05)
    M5 = machFinder(T05, T5)
    ue = machConverter(M5, T5)
    Mo = velocityConverter(ue, Ta)
    #print(M5, Mo, ue)

    # Plotting the cycle
    temperatures = [Ta, T03, T04, T5]
    pressures = [Pa, P03, P04, P5]
    i = 1
    dss = [0, 0]
    while i < len(temperatures) - 1:
        dss.append(
            entropyFinder(temperatures[i], temperatures[i + 1], pressures[i],
                          pressures[i + 1]) + dss[i])
        i += 1


    # Fuel and TSFC calculation
    me = ma + mfc
    [thrust, TSFC] = thrustFinder(ma + mfc, ue, ma, ua, P5, Pa, Ae)
    fuelExpanded = mfc * time * 60

    # Efficiency calculations
    ET = 1 - (Ta / T3)
    EP = (2*(ua/ue))/(1+(ua/ue))

    #Distance travelled
    dist = ue*time*60

    return temperatures, pressures, dss, Mo, thrust, TSFC, fuelExpanded, ET, EP, ue, mfc, dist


##############################################################################
# Property finder


def fullFlight(entries):
    Ti = float(entries['Takeoff Temperature (K)'].get())
    Pi = float(entries['Takeoff Pressure (kPa)'].get())
    Tc = float(entries['Cruise Temperature (K)'].get())
    Pc = float(entries['Cruise Pressure (kPa)'].get())
    showPlots = str(entries['Cycle plots (ON or OFF)'].get())
    flightTime = float(entries['Flight Time (minutes)'].get())

    if flightTime == 0:
        ramTime = 11
        flightTime = 20
    elif flightTime > 9:
        ramTime = flightTime - 9
    else:
        raise SystemExit('Flight time must be more than 9 minutes for ramjet '
                         'to start')

    if Ti == 0:
        Ti = 288.15
    if Pi == 0:
        Pi = 101.3
    if Tc == 0:
        Tc = 238.67778
    if Pc == 0:
        Pc = 37.65227
    if showPlots != 'ON':
        showPlots = 'OFF'


    takeOff = TJCycle(Ti, Pi, 0, 645, 5)
    subCruise = TJCycle(Tc, Pc, takeOff[3], 600, 1)
    ABaccn = ABCruise(Tc, Pc, subCruise[3])
    TJ_RJ = TJRJ(Tc, Pc, ABaccn[3])
    RJaccn = RJCycle(Tc, Pc, TJ_RJ[6], 1)
    RJcruise = RJCycle(Tc, Pc, RJaccn[3], ramTime)

    if showPlots == 'ON':
        cTO = graphMaker(takeOff[2], takeOff[0], 'cTO', 'Takeoff')
        cSC = graphMaker(subCruise[2], subCruise[0], 'cSC', 'Subsonic Cruise')
        cAB = graphMaker(ABaccn[2], ABaccn[0], 'cAB', 'Afterburner acceleration')
        cTJRJ = graphMakerMult(TJ_RJ[4], TJ_RJ[5], TJ_RJ[0], TJ_RJ[1], 'cTJRJ', 'TJ to RJ')
        cRJa = graphMaker(RJaccn[2], RJaccn[0], 'cRJa', 'Ramjet acceleration')
        cRJ = graphMaker(RJcruise[2], RJcruise[0], 'cRJ', 'Ramjet cruise')
        plt.show()

    f.write("1. Takeoff cycle analysis:\nDuring Takeoff only the Turbojet (TJ)"
            " will be ON.\nTemperatures, Pressures and change in Entropy "
            "throughout the TJ:\n")

    i = 0
    j = 2
    while i < len(takeOff[0]):
        T = takeOff[0][i]
        P = takeOff[1][i]
        s = takeOff[2][i]
        f.write("   T0%d = %0.2fK, P0%d = %0.2fkPa, ds%d = %0.2fkJ/K\n"
                % (j, T, j, P, j, s))
        i+=1
        j+=1

    f.write("\nExit mach number and velocity: %0.2f, %0.2fm/s\nThrust: %0.2fN"
            "\nTSFC: %0.2fg/kN.s\nFuel flow rate and amount of fuel needed for"
            " a 5 minute climb to FL250: %0.2fkg/s, %0.2fkg\nEngine and "
            "turbine power are assumed to be equal: %0.2fW\nThermal, "
            "Propulsive and Total efficiency: %0.2f, %0.2f, %0.2f\n\n\n" %
            (takeOff[3], takeOff[9], takeOff[4], takeOff[5], takeOff[10],
             takeOff[6], takeOff[11], takeOff[7], takeOff[8],
             takeOff[7]*takeOff[8]))


    f.write("2. Subsonic cruise cycle analysis:\nDuring subsonic cruise, only "
            "the Turbojet (TJ) will be ON.\nTemperatures, Pressures and change"
            " in Entropy throughout the TJ:\n")

    i = 0
    j = 2
    while i < len(subCruise[0]):
        T = subCruise[0][i]
        P = subCruise[1][i]
        s = subCruise[2][i]
        f.write("   T0%d = %0.2fK, P0%d = %0.2fkPa, ds%d = %0.2fkJ/K\n"
                % (j, T, j, P, j, s))
        i += 1
        j += 1

    f.write("\nExit mach number and velocity: %0.2f, %0.2fm/s\nThrust: %0.2fN"
            "\nTSFC: %0.2fg/kN.s\nFuel flow rate and amount of fuel needed for"
            " a 1 minute cruise at FL250: %0.2fkg/s, %0.2fkg\nEngine and "
            "turbine power are assumed to be equal: %0.2fW\nThermal, "
            "Propulsive and Total efficiency: %0.2f, %0.2f, %0.2f\n\n\n" %
            (subCruise[3], subCruise[9], subCruise[4], subCruise[5],
             subCruise[10], subCruise[6], subCruise[11], subCruise[7],
             subCruise[8], subCruise[7] * subCruise[8]))


    f.write("3. Acceleration to supersonic using afterburner cycle analysis:\n"
            "Both TJ and AB will be ON.\nTemperatures, Pressures and change"
            " in Entropy throughout the and AB:\n")

    i = 0
    j = 2
    while i < len(ABaccn[0]):
        T = ABaccn[0][i]
        P = ABaccn[1][i]
        s = ABaccn[2][i]
        f.write("   T0%d = %0.2fK, P0%d = %0.2fkPa, ds%d = %0.2fkJ/K\n"
                % (j, T, j, P, j, s))
        i += 1
        j += 1

    f.write("\nExit mach number and velocity: %0.2f, %0.2fm/s\nThrust: %0.2fN"
            "\nTSFC: %0.2fg/kN.s\nFuel flow rate for TJ, AB, total and amount "
            "of fuel needed for a 1 minute acceleration at FL250: %0.2fkg/s, "
            "%0.2fkg/s, %0.2fkg/s, %0.2fkg\nEngine and turbine power are "
            "assumed to be equal: %0.2fW\nThermal, Propulsive and Total effici"
            "ency: %0.2f, %0.2f, %0.2f\n\n\n" %
            (ABaccn[3], ABaccn[9], ABaccn[4], ABaccn[5], ABaccn[10], ABaccn[11],
             ABaccn[10]+ABaccn[11], ABaccn[6], ABaccn[12], ABaccn[7],
             ABaccn[8], ABaccn[7] * ABaccn[8]))



    f.write("4. Ramjet start cycle analysis:\nWhile both TJ and RJ will be ON,"
            " 3/4 of the air will be redirected to the RJ.\nTemperatures, Pres"
            "sures and change in Entropy throughout the and AB:\n")

    TJ_RJ[0].extend(TJ_RJ[1])
    TJ_RJ[2].extend(TJ_RJ[3])
    TJ_RJ[4].extend(TJ_RJ[5])
    i = 0
    j = 2
    while i < len(TJ_RJ[0]):
        T = TJ_RJ[0][i]
        P = TJ_RJ[2][i]
        s = TJ_RJ[4][i]
        f.write("   T0%d = %0.2fK, P0%d = %0.2fkPa, ds%d = %0.2fkJ/K\n"
                % (j, T, j, P, j, s))
        i += 1
        j += 1

    f.write("\nExit mach number and velocity: %0.2f, %0.2fm/s\nThrust: %0.2fN"
            "\nTSFC: %0.2fg/kN.s\nFuel flow rate for TJ, RJ, total and amount "
            "of fuel needed for a 1 minute startup at FL250: %0.2fkg/s, "
            "%0.2fkg/s, %0.2fkg/s, %0.2fkg\nEngine and turbine power are "
            "assumed to be equal: %0.2fW\nThermal(TJ, RJ), Propulsive and "
            "Total efficiency:  %0.2f, %0.2f, %0.2f, %0.2f\n\n\n" %
            (
            TJ_RJ[6], TJ_RJ[7], TJ_RJ[8], TJ_RJ[9], TJ_RJ[10], TJ_RJ[11],
            TJ_RJ[10] + TJ_RJ[11], TJ_RJ[12], TJ_RJ[13], TJ_RJ[14], TJ_RJ[16],
            TJ_RJ[15], TJ_RJ[14]*TJ_RJ[15]*TJ_RJ[16]))


    f.write("5. Ramjet acceleration to M = 4:\nOnly RJ is ON.\nTemperatures, "
            "Pressures and change in Entropy throughout the and AB:\n")

    i = 0
    j = 2
    while i < len(RJaccn[0]):
        T = RJaccn[0][i]
        P = RJaccn[1][i]
        s = RJaccn[2][i]
        f.write("   T0%d = %0.2fK, P0%d = %0.2fkPa, ds%d = %0.2fkJ/K\n"
                % (j, T, j, P, j, s))
        i += 1
        j += 1

    f.write("\nExit mach number and velocity: %0.2f, %0.2fm/s\nThrust: %0.2fN"
            "\nTSFC: %0.2fg/kN.s\nFuel flow rate and amount of fuel needed for"
            " a 1 minute acceleration at FL250: %0.2fkg/s, %0.2fkg\nThermal, "
            "Propulsive and Total efficiency: %0.2f, %0.2f, %0.2f\n\n\n" %
            (RJaccn[3], RJaccn[9], RJaccn[4], RJaccn[5], RJaccn[10], RJaccn[6],
             RJaccn[7], RJaccn[8], RJaccn[7] * RJaccn[8]))

    f.write("6. Ramjet cruise at M = 4:\nOnly RJ is ON.\nTemperatures, "
            "Pressures and change in Entropy throughout the and AB:\n")


    i = 0
    j = 2
    while i < len(RJcruise[0]):
        T = RJcruise[0][i]
        P = RJcruise[1][i]
        s = RJcruise[2][i]
        f.write("   T0%d = %0.2fK, P0%d = %0.2fkPa, ds%d = %0.2fkJ/K\n"
                % (j, T, j, P, j, s))
        i += 1
        j += 1

    f.write("\nExit mach number and velocity: %0.2f, %0.2fm/s\nThrust: %0.2fN"
            "\nTSFC: %0.2fg/kN.s\nFuel flow rate and amount of fuel needed for"
            " a 10 minute cruise at FL250: %0.2fkg/s, %0.2fkg\nThermal, "
            "Propulsive and Total efficiency: %0.2f, %0.2f, %0.2f\n\n\n" %
            (RJcruise[3], RJcruise[9], RJcruise[4], RJcruise[5], RJcruise[10],
             RJcruise[6], RJcruise[7], RJcruise[8], RJcruise[7] * RJcruise[8]))

    totalFuelCons = RJcruise[6] + RJaccn[6] + TJ_RJ[12] + ABaccn[6] + subCruise[6] + takeOff[6]
    totalRange = takeOff[12] + subCruise[12] + ABaccn[12] + TJ_RJ[17] + RJaccn[11] + RJcruise[11]

    f.write("The total amount of fuel needed is %0.2fkg for a range of %0.2fm "
            "or %0.2fkm in %0.1f minutes\n\n"
            % (totalFuelCons, totalRange, totalRange/1000, flightTime))

    print("Cycle analysis complete")


def range2fuel(entries):
    Ti = float(entries['Takeoff Temperature (K)'].get())
    Pi = float(entries['Takeoff Pressure (kPa)'].get())
    Tc = float(entries['Cruise Temperature (K)'].get())
    Pc = float(entries['Cruise Pressure (kPa)'].get())
    flightTime = float(entries['Flight Time (minutes)'].get())
    rangekm = float(entries['Range (km)'].get())

    if flightTime == 0:
        ramTime = 11
    elif flightTime > 9:
        ramTime = flightTime - 9
    else:
        raise SystemExit('Flight time must be more than 9 minutes for ramjet '
                         'to start')

    if Ti == 0:
        Ti = 288.15

    if Pi == 0:
        Pi = 101.3

    if Tc == 0:
        Tc = 238.67778

    if Pc == 0:
        Pc = 37.65227

    takeOff = TJCycle(Ti, Pi, 0, 645, 5)
    subCruise = TJCycle(Tc, Pc, takeOff[3], 600, 1)
    ABaccn = ABCruise(Tc, Pc, subCruise[3])
    TJ_RJ = TJRJ(Tc, Pc, ABaccn[3])
    RJaccn = RJCycle(Tc, Pc, TJ_RJ[6], 1)
    RJcruise = RJCycle(Tc, Pc, RJaccn[3], ramTime)

    if rangekm == 0:
        fullRange = takeOff[12] + subCruise[12] + ABaccn[12] + TJ_RJ[17] + RJaccn[11] + RJcruise[11]
    else:
        fullRange = rangekm * 1000

    if fullRange <= takeOff[12]:
        fuel = takeOff[6] * fullRange/takeOff[12]
    elif fullRange <= takeOff[12] + subCruise[12]:
        fuel = takeOff[6] + subCruise[6] * (fullRange-takeOff[12])/(subCruise[12])
    elif fullRange <= takeOff[12] + subCruise[12] + ABaccn[13]:
        fuel = takeOff[6] + subCruise[6] + ABaccn[6] * (fullRange - takeOff[12] - subCruise[12]) / (ABaccn[13])
    elif fullRange <= takeOff[12] + subCruise[12] + ABaccn[13] + TJ_RJ[17]:
        fuel = takeOff[6] + subCruise[6] + ABaccn[6] + TJ_RJ[12] * (fullRange - takeOff[12] - subCruise[12] - ABaccn[13]) / (TJ_RJ[17])
    elif fullRange <= takeOff[12] + subCruise[12] + ABaccn[13] + TJ_RJ[17] + RJaccn[11]:
        fuel = takeOff[6] + subCruise[6] + ABaccn[6] + TJ_RJ[12] + RJaccn[6] * (fullRange - takeOff[12] - subCruise[12] - ABaccn[13] - TJ_RJ[17]) / (RJaccn[11])
    else:
        fuel = takeOff[6] + subCruise[6] + ABaccn[6] + TJ_RJ[12] + RJaccn[6] + RJcruise[6] * (fullRange - takeOff[12] - subCruise[12] - ABaccn[13] - TJ_RJ[17] - RJaccn[11]) / (RJcruise[11])

    f.write("The amount of fuel needed to achieve the given range of %0.2fkm "
            "is %0.2fkg\n\n" % (fullRange/1000, fuel))

    print("Fuel analysis complete")


def fuel2range(entries):
    Ti = float(entries['Takeoff Temperature (K)'].get())
    Pi = float(entries['Takeoff Pressure (kPa)'].get())
    Tc = float(entries['Cruise Temperature (K)'].get())
    Pc = float(entries['Cruise Pressure (kPa)'].get())
    flightTime = float(entries['Flight Time (minutes)'].get())
    fuel = float(entries['Fuel (kg)'].get())

    if flightTime == 0:
        ramTime = 11
    elif flightTime > 9:
        ramTime = flightTime - 9
    else:
        raise SystemExit('Flight time must be more than 9 minutes for ramjet '
                         'to start')

    if Ti == 0:
        Ti = 288.15

    if Pi == 0:
        Pi = 101.3

    if Tc == 0:
        Tc = 238.67778

    if Pc == 0:
        Pc = 37.65227


    takeOff = TJCycle(Ti, Pi, 0, 645, 5)
    subCruise = TJCycle(Tc, Pc, takeOff[3], 600, 1)
    ABaccn = ABCruise(Tc, Pc, subCruise[3])
    TJ_RJ = TJRJ(Tc, Pc, ABaccn[3])
    RJaccn = RJCycle(Tc, Pc, TJ_RJ[6], 1)
    RJcruise = RJCycle(Tc, Pc, RJaccn[3], ramTime)

    if fuel == 0:
        fuel = RJcruise[6] + RJaccn[6] + TJ_RJ[12] + ABaccn[6] + subCruise[6] + takeOff[6]

    if fuel <= takeOff[6]:
        fullRange = takeOff[12] * fuel/takeOff[6]
    elif fuel <= takeOff[6] + subCruise[6]:
        fullRange = takeOff[12] + subCruise[12] * (fuel-takeOff[6])/(subCruise[6])
    elif fuel <= takeOff[6] + subCruise[6] + ABaccn[6]:
        fullRange = takeOff[12] + subCruise[12] + ABaccn[13] * (fuel - takeOff[6] - subCruise[6]) / (ABaccn[6])
    elif fuel <= takeOff[6] + subCruise[6] + ABaccn[6] + TJ_RJ[12]:
        fullRange = takeOff[12] + subCruise[12] + ABaccn[13] + TJ_RJ[17] * (fuel - takeOff[6] - subCruise[6] - ABaccn[6]) / (TJ_RJ[12])
    elif fuel <= takeOff[6] + subCruise[6] + ABaccn[6] + TJ_RJ[12] + RJaccn[6]:
        fullRange = takeOff[12] + subCruise[12] + ABaccn[13] + TJ_RJ[17] + RJaccn[11] * (fuel - takeOff[6] - subCruise[6] - ABaccn[6] - TJ_RJ[12]) / (RJaccn[6])
    else:
        fullRange = takeOff[12] + subCruise[12] + ABaccn[13] + TJ_RJ[17] + RJaccn[11] + RJcruise[11] * (fuel - takeOff[6] - subCruise[6] - ABaccn[6] - TJ_RJ[12] - RJaccn[6]) / (RJcruise[6])

    f.write("The maximum range of the engine with %0.2fkg of fuel is "
            "%0.2fkm\n\n" % (fuel, fullRange/1000))
    print("Range analysis complete")


##############################################################################
# GUI creation


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
    b1 = tk.Button(root, text='Full cycle analysis',
           command=(lambda e=ents: fullFlight(e)))
    b1.pack(side=tk.LEFT, padx=5, pady=15)
    b2 = tk.Button(root, text='Fuel to Range',
           command=(lambda e=ents: fuel2range(e)))
    b2.pack(side=tk.LEFT, padx=15, pady=15)
    b3 = tk.Button(root, text='Range to Fuel',
                   command=(lambda e=ents: range2fuel(e)))
    b3.pack(side=tk.LEFT, padx=20, pady=15)
    def Close():
        root.destroy()

    b4 = tk.Button(root, text='Exit Program',
                   command=Close)
    b4.pack(side=tk.LEFT, padx=30, pady=15)

    root.mainloop()