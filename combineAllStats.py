import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import operator

#open 2gramCombinedScores, 3gramCombinedScores, 4gramCombinedScores, otherStats, allPlayers

#use other scores as full list of names
# dictionary divided with last name, nested dict on first name, then stats as a list


localpath = 'C:\Users\meri_\Documents\CU\Sabermetrics\\finalProject\\2gramCombinedScores.csv'
print "opening ", localpath

df2 = pd.read_csv(localpath, header=0)

localpath = 'C:\Users\meri_\Documents\CU\Sabermetrics\\finalProject\\3gramCombinedScores.csv'
print "opening ", localpath

df3 = pd.read_csv(localpath, header=0)

localpath = 'C:\Users\meri_\Documents\CU\Sabermetrics\\finalProject\\4gramCombinedScores.csv'
print "opening ", localpath

df4 = pd.read_csv(localpath, header=0)

localpath = 'C:\Users\meri_\Documents\CU\Sabermetrics\\finalProject\\otherStats.csv'
print "opening ", localpath

dfother = pd.read_csv(localpath, header=0)

allPlayers = {}

for i in range(0,len(dfother)):
    first = dfother['nameFirst'][i]
    last = dfother['nameLast'][i]
    if last not in allPlayers.keys():
        allPlayers[last] = {}

    allPlayers[last][first] = [dfother['RC'][i], dfother['OBP'][i], 0, 0, 0]

#iterate through df2, find last, first, add stat to list
for i in range(0,len(df2)):
    first = df2['first'][i]
    last = df2['last'][i]

    if last not in allPlayers.keys():
        allPlayers[last] = {}
        allPlayers[last][first] = [0, 0, df2['score'][i], 0, 0]
    elif first not in allPlayers[last].keys():
        allPlayers[last][first] = [0, 0, df2['score'][i], 0, 0]
    else:
        allPlayers[last][first][2] = df2['score'][i]

#iterate through df3, find last, first, add stat to list
for i in range(0,len(df3)):
    first = df3['first'][i]
    last = df3['last'][i]

    if last not in allPlayers.keys():
        allPlayers[last] = {}
        allPlayers[last][first] = [0, 0, 0, df3['score'][i], 0]
    elif first not in allPlayers[last].keys():
        allPlayers[last][first] = [0, 0, 0, df3['score'][i], 0]
    else:
        allPlayers[last][first][3] = df3['score'][i]

#iterate through df4, find last, first, add stat to list
for i in range(0,len(df4)):
    first = df4['first'][i]
    last = df4['last'][i]

    if last not in allPlayers.keys():
        allPlayers[last] = {}
        allPlayers[last][first] = [0, 0, 0, 0, df4['score'][i]]
    elif first not in allPlayers[last].keys():
        allPlayers[last][first] = [0, 0, 0, 0, df4['score'][i]]
    else:
        allPlayers[last][first][4] = df4['score'][i]

#print allPlayers


fobj = open("allStats.csv", "wb")

fobj.write("firstName,lastName,RC,OBP,2ROC,3ROC,4ROC\n")
for lastName in allPlayers.keys():
    for firstName in allPlayers[lastName].keys():
        if str(allPlayers[lastName][firstName][0]) == 'nan':
            RC = '0'
        else:
            RC = str(allPlayers[lastName][firstName][0])

        if str(allPlayers[lastName][firstName][1]) == 'nan':
            OBP = '0'
        else:
            OBP = str(allPlayers[lastName][firstName][1])

        fobj.write(str(firstName) + "," + str(lastName) + "," + RC + "," + OBP + "," + str(allPlayers[lastName][firstName][2]) + "," + str(allPlayers[lastName][firstName][3]) + "," + str(allPlayers[lastName][firstName][4]) + "\n")

fobj.close()
