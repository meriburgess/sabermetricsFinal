import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import operator



listOfEvents = ["Out", "K", "SB", "DI", "CS", "PK", "WP", "PB", "BK", "OA", "FE", "NIBB", "IBB", "HBP", "XI",
"ROE", "FC", "1B", "2B", "3B", "HR" ]
listOfEventsLong = ["Generic Out", "Strikeout", "Stolen Base", "Defensive Indifference", "Caught Stealing", "Pickoff", "Wild Pitch", "Passed Ball",
"Balk", "Other Advance", "Foul Error", "Nonintentional Walk", "Intentional Walk", "Hit By Pitch", "Interference", "Error", "Fielder Choice",
"Single", "Double", "Triple", "Homerun"]
localpath = 'C:\Users\meri_\Documents\CU\Sabermetrics\\finalProject\\3gramofevents.csv'

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

trans0to1Norm2 = {}
trans1to2Norm2 = {}

allTransNorm = {}

#create dictionary for each
for i in range(2, 24):
    trans0to1[i] = {}
    trans1to2[i] = {}
    trans2to3[i] = {}
    allTrans[i] = {}

    trans0to1Norm[i] = {}
    trans1to2Norm[i] = {}
    trans0to1Norm2[i] = {}
    trans1to2Norm2[i] = {}
    allTransNorm[i] = {}


for i in range(0,len(df)):
    #get n gram
    thisSeq = [df['event_cd'][i], df['eventCD2'][i], df['eventCD3'][i]]

    #build into string so that it is hashable
    s = str(df['event_cd'][i]) + "_" +  str(df['eventCD2'][i]) + "_" + str(df['eventCD3'][i])
    hashableSeqs[s] = hashableSeqs.get(s, 0) + 1
    sequences.append(thisSeq)

    trans0to1[df['event_cd'][i]][df['eventCD2'][i]] = trans0to1[df['event_cd'][i]].get(df['eventCD2'][i], 0) + 1
    trans1to2[df['eventCD2'][i]][df['eventCD3'][i]] = trans1to2[df['eventCD2'][i]].get(df['eventCD3'][i], 0) + 1

    allTrans[df['event_cd'][i]][df['eventCD2'][i]] = allTrans[df['event_cd'][i]].get(df['eventCD2'][i], 0) + 1
    allTrans[df['eventCD2'][i]][df['eventCD3'][i]] = allTrans[df['eventCD2'][i]].get(df['eventCD3'][i], 0) + 1


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
        trans0to1Norm2[k][k2] = round(float(trans0to1[k][k2]) / float(len(sequences)),5)


for k in trans1to2.keys():
    total = 0
    for k2 in trans1to2[k].keys():
        total = total + trans1to2[k][k2]
        trans1to2Norm[k][k2] = trans1to2Norm[k].get(k2, 0)

    for k2 in trans1to2[k].keys():
        trans1to2Norm[k][k2] = round(float(trans1to2[k][k2]) / float(total), 5)
        trans1to2Norm2[k][k2] = round(float(trans1to2[k][k2]) / float(len(sequences)),5)

for k in allTrans.keys():
    total = 0
    for k2 in allTrans[k].keys():
        total = total + allTrans[k][k2]
        allTransNorm[k][k2] = allTransNorm[k].get(k2, 0)

    for k2 in allTrans[k].keys():
        allTransNorm[k][k2] = round(float(allTrans[k][k2])/ float(total), 5)
#print trans0to1[20]
#print trans0to1Norm[20]
#print trans0to1Norm2[20]

#print trans1to2[20]
#print trans1to2Norm[20]

#print trans1to2Norm[20]
print trans1to2Norm

#for v1 in trans0to1Norm[20].keys():
#    print "20", v1, trans0to1Norm[20][v1]



for i in range(2,23):
    if i >= 7:
        val = i + 1
    else:
        val = i
    lookingAt = listOfEvents[i-2]
    stringToAdd = "(" + str(val) + "," + lookingAt + "," + listOfEventsLong[i-2] + ","

    #print trans0to1Norm[]
    #for v1 in trans0to1Norm[val].keys():

    for j in range(2, 23):
        if j in trans1to2Norm[val].keys():
            stringToAdd = stringToAdd + str(trans1to2Norm[val][j]) + ", "
        else:
            stringToAdd = stringToAdd + "0, "


    stringToAdd = stringToAdd + "),"
    print stringToAdd
