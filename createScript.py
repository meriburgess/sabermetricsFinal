
listOfEvents = ["Out", "K", "SB", "DI", "CS", "PK", "WP", "PB", "BK", "OA", "FE", "NIBB", "IBB", "HBP", "XI",
"ROE", "FC", "1B", "2B", "3B", "HR" ]
listOfEventsLong = ["Generic Out", "Strikeout", "Stolen Base", "Defensive Indifference", "Caught Stealing", "Pickoff", "Wild Pitch", "Passed Ball",
"Balk", "Other Advance", "Foul Error", "Nonintentional Walk", "Intentional Walk", "Hit By Pitch", "Interference", "Error", "Fielder Choice",
"Single", "Double", "Triple", "Homerun"]

#add columns
for n in listOfEvents:
    print "Alter table ThreeGramTrans ADD " + n + " double(4,3);"


#print "insert into ThreeGramTrans (value_cd, shortname_tx, longname_tx, Out, K, SB, DI, CS, PK, WP, PB, BK, OA, FE, NIBB, IBB, HBP, XI, ROE, FC, 1B, 2B, 3B, HR) VALUES"


#for i in range(2,24):
#    lookingAt = listOfEvents[i-2]
#    stringToAdd = "(" + i "," + lookingAt + "," + listOfEventsLong[i-2] + ","

#    for v1 in trans0to1Norm[i].keys():
#        stringToAdd = stringToAdd + trans0to1Norm[i][v1]
#        if v1 != 23:
#                stringToAdd = stringToAdd + ", "


#    stringToAdd = stringToAdd + "),"
