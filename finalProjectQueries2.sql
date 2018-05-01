use lahman2016;

select playerID, yearID, H, AB, BB, IBB, 2B, 3B, HR, 
(((H + BB) * (2B + 3B + HR))/(AB+BB)) as RC, 
((H + BB + HBP)/(AB + BB + HBP + SF)) as OBP
from batting
where yearID >= 2010 and yearID <= 2013;

select playerID, yearID, H, AB, BB, IBB, 2B, 3B, HR, 
(((H + BB) * (2B + 3B + HR))/(AB+BB)) as RC, 
((H + BB + HBP)/(AB + BB + HBP + SF)) as OBP
from batting
where yearID >= 2010 and yearID <= 2013;

select b.playerID, master.nameFirst, master.nameLast, b.yearID, 
SUM(b.H) as H, SUM(b.AB) as AB, SUM(b.BB) as BB, SUM(b.2B), SUM(b.3B), SUM(b.HR), 
(((SUM(b.H) + SUM(b.BB)) * (SUM(b.2B) + SUM(b.3B) + SUM(b.HR)))/(SUM(b.AB)+SUM(b.BB))) as RC, 
((SUM(b.H) + SUM(b.BB) + SUM(b.HBP))/(SUM(b.AB) + SUM(b.BB) + SUM(b.HBP) + SUM(b.SF))) as OBP
from batting b
left join master on master.playerID = b.playerID 
where yearID >= 2010 and yearID <= 2013
group by playerID;

select b.playerID, master.nameFirst, master.nameLast,
SUM(b.H) as H, SUM(b.AB) as AB, SUM(b.BB) as BB, SUM(b.2B), SUM(b.3B), SUM(b.HR), 
(((SUM(b.H) + SUM(b.BB) + SUM(b.IBB)) * (SUM(b.2B) + SUM(b.3B) + SUM(b.HR)))/(SUM(b.AB)+SUM(b.BB) + SUM(b.IBB))) as RC, 
((SUM(b.H) + SUM(b.BB) + SUM(b.IBB) + SUM(b.HBP))/(SUM(b.AB) + SUM(b.BB) + SUM(b.IBB) + SUM(b.HBP) + SUM(b.SF))) as OBP
from batting b
left join master on master.playerID = b.playerID 
where yearID >= 2010 and yearID <= 2013
group by playerID;