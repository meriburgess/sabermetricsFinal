import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import operator



listOfEvents = ["Out", "K", "SB", "DI", "CS", "PK", "WP", "PB", "BK", "OA", "FE", "NIBB", "IBB", "HBP", "XI",
"ROE", "FC", "1B", "2B", "3B", "HR" ]
listOfEventsLong = ["Generic Out", "Strikeout", "Stolen Base", "Defensive Indifference", "Caught Stealing", "Pickoff", "Wild Pitch", "Passed Ball",
"Balk", "Other Advance", "Foul Error", "Nonintentional Walk", "Intentional Walk", "Hit By Pitch", "Interference", "Error", "Fielder Choice",
"Single", "Double", "Triple", "Homerun"]

n = 3
localpath = 'C:\Users\meri_\Documents\CU\Sabermetrics\\finalProject\\' + str(n) + 'gramofevents.csv'
print n, "opening ", localpath

df = pd.read_csv(localpath, header=0)

print df[0:5]

sequences = []
hashableSeqs = {}
hashableSeqsNormed = {}


trans0to1 = {}
trans1to2 = {}
trans2to3 = {}
allTrans = {}

trans0to1Norm = {}
trans1to2Norm = {}
trans2to3Norm = {}


allTransNorm = {}

#create dictionary for each
for i in range(2, 24):
    trans0to1[i] = {}
    trans1to2[i] = {}
    trans2to3[i] = {}
    allTrans[i] = {}

    trans0to1Norm[i] = {}
    trans1to2Norm[i] = {}
    trans2to3Norm[i] = {}

    allTransNorm[i] = {}


for i in range(0,len(df)):
    #get n gram
    thisSeq = [df['event_cd'][i], df['eventCD2'][i]]
    s = str(df['event_cd'][i]) + "_" + str( df['eventCD2'][i])
    if n >= 3:
        thisSeq.append(df['eventCD3'][i])
        s += "_" + str(df['eventCD3'][i])
    if n >= 4:
        thisSeq.append(df['eventCD4'][i])
        s += "_" + str(df['eventCD4'][i])

    #build into string so that it is hashable

    hashableSeqs[s] = hashableSeqs.get(s, 0) + 1
    sequences.append(thisSeq)

    trans0to1[df['event_cd'][i]][df['eventCD2'][i]] = trans0to1[df['event_cd'][i]].get(df['eventCD2'][i], 0) + 1
    allTrans[df['event_cd'][i]][df['eventCD2'][i]] = allTrans[df['event_cd'][i]].get(df['eventCD2'][i], 0) + 1

    if n >= 3:
        trans1to2[df['eventCD2'][i]][df['eventCD3'][i]] = trans1to2[df['eventCD2'][i]].get(df['eventCD3'][i], 0) + 1
        allTrans[df['eventCD2'][i]][df['eventCD3'][i]] = allTrans[df['eventCD2'][i]].get(df['eventCD3'][i], 0) + 1

    if n >= 4:
        trans2to3[df['eventCD3'][i]][df['eventCD4'][i]] = trans2to3[df['eventCD3'][i]].get(df['eventCD4'][i], 0) + 1
        allTrans[df['eventCD3'][i]][df['eventCD4'][i]] = allTrans[df['eventCD3'][i]].get(df['eventCD4'][i], 0) + 1





print "Sequences"
print sequences[0:5]
print "\n"

unique = set(hashableSeqs.keys())

print "Top 15 sequences"
print dict(sorted(hashableSeqs.iteritems(), key=operator.itemgetter(1), reverse=True)[:15])
print "\n"

for k in hashableSeqs.keys():
    hashableSeqsNormed[k] = round(float(hashableSeqs[k])/float(len(sequences)), 5)

print "Top 15 sequences, percentage"
print dict(sorted(hashableSeqsNormed.iteritems(), key=operator.itemgetter(1), reverse=True)[:15])
print "\n"

for k in trans0to1.keys():
    total = 0
    #get total count of transitions from event
    for k2 in trans0to1[k].keys():
        total = total + trans0to1[k][k2]
        trans0to1Norm[k][k2] = trans0to1Norm[k].get(k2, 0)
    for k2 in trans0to1[k].keys():
        #normalized to total transitions from event
        trans0to1Norm[k][k2] = round(float(trans0to1[k][k2]) / float(total), 5)

        #normalized to total transitions overall
        #trans0to1Norm2[k][k2] = round(float(trans0to1[k][k2]) / float(len(sequences)),5)

if n >= 3:
    for k in trans1to2.keys():
        total = 0
        for k2 in trans1to2[k].keys():
            total = total + trans1to2[k][k2]
            trans1to2Norm[k][k2] = trans1to2Norm[k].get(k2, 0)

        for k2 in trans1to2[k].keys():
            trans1to2Norm[k][k2] = round(float(trans1to2[k][k2]) / float(total), 5)
            #trans1to2Norm2[k][k2] = round(float(trans1to2[k][k2]) / float(len(sequences)),5)

if n >=4:
    for k in trans2to3.keys():
        total = 0
        for k2 in trans2to3[k].keys():
            total = total + trans2to3[k][k2]
            trans2to3Norm[k][k2] = trans2to3Norm[k].get(k2, 0)

        for k2 in trans2to3[k].keys():
            trans2to3Norm[k][k2] = round(float(trans2to3[k][k2]) / float(total), 5)
            #trans2to3Norm2[k][k2] = round(float(tran2to3[k][k2]) / float(len(sequences)),5)

for k in allTrans.keys():
    total = 0
    for k2 in allTrans[k].keys():
        total = total + allTrans[k][k2]
        allTransNorm[k][k2] = allTransNorm[k].get(k2, 0)

    for k2 in allTrans[k].keys():
        allTransNorm[k][k2] = round(float(allTrans[k][k2])/ float(total), 5)


#print trans1to2[20]
#print trans1to2Norm[20]

#print trans0to1Norm
#print trans1to2Norm
#print trans2to3Norm

#open full file

localpath = 'C:\Users\meri_\Documents\CU\Sabermetrics\\finalProject\\' + str(n) + 'gramFull.csv'
print n, "opening ", localpath

dfFull = pd.read_csv(localpath, header=0)
print dfFull['batID1'][0]

playerScores = {}

for l in range(0,len(dfFull)):
    name1 = dfFull['batID1'][l]
    name2 = dfFull['batID2'][l]
    name = [name1, name2]
    if n >= 3:
        name3 = dfFull['batID3'][l]
        name.append(name3)

    for i in range(0,n-1):
        if name[i] not in playerScores.keys():
            playerScores[name[i]] = [dfFull['first'+str(i+1)][l], dfFull['last'+str(i+1)][l], dfFull['PA'+str(i+1)][l], 0]

        if i == 0:
            playerScores[name[i]][3] += trans0to1Norm[dfFull['eventCD1'][l]][dfFull['eventCD2'][l]]
        elif i == 1:
            playerScores[name[i]][3] += trans1to2Norm[dfFull['eventCD2'][l]][dfFull['eventCD3'][l]]
        elif i == 2:
            playerScores[name[i]][3] += trans2to3Norm[dfFull['eventCD3'][l]][dfFull['eventCD4'][l]]

#print playerScores

print "Writing to file "
fobj = open(str(n) + "gramCombinedScores.csv", "wb")

fobj.write("id, first, last, PA1, accScore, score \n")
for id in playerScores.keys():
    #print id, playerScores[id][0], playerScores[id][1], playerScores[id][2], playerScores[id][3], float(playerScores[id][3])/float(playerScores[id][2])
    fobj.write(id + "," + str(playerScores[id][0]) + "," + str(playerScores[id][1]) + "," + str(playerScores[id][2]) + "," + str(playerScores[id][3]) + "," + str(float(playerScores[id][3])/float(playerScores[id][2])) + "\n")

fobj.close()

print "Done"
#for i in range(2,23):
#    if i >= 7:
#        val = i + 1
#    else:
#        val = i
#    lookingAt = listOfEvents[i-2]
#    stringToAdd = "(" + str(val) + "," + lookingAt + "," + listOfEventsLong[i-2] + ","

    #print trans0to1Norm[]
    #for v1 in trans0to1Norm[val].keys():

#    for j in range(2, 23):
#        if j in trans1to2Norm[val].keys():
#            stringToAdd = stringToAdd + str(trans1to2Norm[val][j]) + ", "
#        else:
#            stringToAdd = stringToAdd + "0, "


#    stringToAdd = stringToAdd + "),"
#    print stringToAdd
