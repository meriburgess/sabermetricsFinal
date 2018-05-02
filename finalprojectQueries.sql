use retrosheet;

select * from events limit 10;
select ass1_fld_cd from events where ass1_fld_cd > 0;
select * from lkup_cd_event;

select event_tx, COUNT(*) from events 
group by event_tx 
order by COUNT(*) DESC;

select COUNT(DISTINCT event_tx) from events;


select e.game_id, e.event_id, e.bat_id, e.event_cd, e.event_runs_ct,
 e.inn_ct, e.home_team_id, e.away_team_id, e.bat_team_id
from events e;

select e.game_id, e.bat_team_id,
e.event_id, e.event_cd, e.bat_id,  e.event_runs_ct,
e2.event_id as eventID2, e2.event_cd as eventCD2, e2.bat_id as batID2, e2.event_runs_ct as runsCt2,
e3.event_id as eventID3, e3.event_cd as eventCD3, e3.bat_id as batID3, e3.event_runs_ct as runsCt3 ,
e4.event_id as eventID4, e4.event_cd as eventCD4, e4.bat_id as batID4, e4.event_runs_ct as runsCt4 
from events e 
left join events e2 on e2.event_id = e.event_id + 1 and e.game_id = e2.game_id and e.bat_team_id = e2.bat_team_id
left join events e3 on e3.event_id = e.event_id + 2 and e.game_id = e3.game_id and e.bat_team_id = e3.bat_team_id
left join events e4 on e4.event_id = e.event_id + 3 and e.game_id = e4.game_id and e.bat_team_id = e4.bat_team_id;




select  e.event_cd,
e2.event_cd as eventCD2,
e3.event_cd as eventCD3, 
e4.event_cd as eventCD4, e4.event_runs_ct as runsCt4 
from events e 
left join events e2 on e2.event_id = e.event_id + 1 and e.game_id = e2.game_id and e.bat_team_id = e2.bat_team_id
left join events e3 on e3.event_id = e.event_id + 2 and e.game_id = e3.game_id and e.bat_team_id = e3.bat_team_id
left join events e4 on e4.event_id = e.event_id + 3 and e.game_id = e4.game_id and e.bat_team_id = e4.bat_team_id;


select  e.event_cd,
e2.event_cd as eventCD2,
e3.event_cd as eventCD3, 
e4.event_cd as eventCD4, e4.event_runs_ct as runsCt4 
from events e 
left join events e2 on e2.event_id = e.event_id + 1 and e.game_id = e2.game_id and e.bat_team_id = e2.bat_team_id
left join events e3 on e3.event_id = e.event_id + 2 and e.game_id = e3.game_id and e.bat_team_id = e3.bat_team_id
left join events e4 on e4.event_id = e.event_id + 3 and e.game_id = e4.game_id and e.bat_team_id = e4.bat_team_id
where e4.event_runs_ct >= 1;


select  e.event_cd,
e2.event_cd as eventCD2,
e3.event_cd as eventCD3, e3.event_runs_ct as runsCt3 
from events e 
left join events e2 on e2.event_id = e.event_id + 1 and e.game_id = e2.game_id and e.bat_team_id = e2.bat_team_id
left join events e3 on e3.event_id = e.event_id + 2 and e.game_id = e3.game_id and e.bat_team_id = e3.bat_team_id
where e3.event_runs_ct >= 1;


select  e.event_cd,
e2.event_cd as eventCD2, e2.event_runs_ct as runsCt2
from events e 
left join events e2 on e2.event_id = e.event_id + 1 and e.game_id = e2.game_id and e.bat_team_id = e2.bat_team_id
where e2.event_runs_ct >= 1;

select e.game_id, e.bat_team_id,
e.event_id, e.event_cd, e.bat_id,  e.event_runs_ct,
e2.event_id as eventID2, e2.event_cd as eventCD2, e2.bat_id as batID2, e2.event_runs_ct as runsCt2,
e3.event_id as eventID3, e3.event_cd as eventCD3, e3.bat_id as batID3, e3.event_runs_ct as runsCt3
from events e 
left join events e2 on e2.event_id = e.event_id + 1 and e.game_id = e2.game_id and e.bat_team_id = e2.bat_team_id
left join events e3 on e3.event_id = e.event_id + 2 and e.game_id = e3.game_id and e.bat_team_id = e3.bat_team_id
where e3.event_runs_ct >= 1;

select bat_id, count(*)
from events 
group by bat_id;


Drop table if exists TwoGramFull; 
Create table TwoGramFull as 
select e.game_id, e.bat_team_id,
e.event_id as eventID1, eCode1.shortname_tx as event1, e.event_cd as eventCD1, e.bat_id as batID1, id1.first as first1, id1.last as last1, app1.pa as PA1, 
e2.event_id as eventID2, eCode2.shortname_tx as event2, e2.event_cd as eventCD2, e2.bat_id as batID2, id2.first as first2, id2.last as last2, app2.pa as PA2, 
 e2.event_runs_ct as runsCt
from events e 
left join events e2 on e2.event_id = e.event_id + 1 and e.game_id = e2.game_id and e.bat_team_id = e2.bat_team_id
left join id id1 on e.bat_id = id1.id 
left join id id2 on e2.bat_id = id2.id
left join lkup_cd_event eCode1 on e.event_cd = eCode1.value_cd 
left join lkup_cd_event eCode2 on e2.event_cd = eCode2.value_cd
left join (select e.bat_id, count(*) as pa from events e group by e.bat_id) app1 on e.bat_id = app1.bat_id
left join (select e.bat_id, count(*) as pa from events e group by e.bat_id) app2 on e2.bat_id = app2.bat_id
where e2.event_runs_ct >= 1
order by e.game_id, e.event_id;


Drop table if exists ThreeGramFull; 
Create table ThreeGramFull as 
select e.game_id, e.bat_team_id,
e.event_id as eventID1, eCode1.shortname_tx as event1, e.event_cd as eventCD1, e.bat_id as batID1, id1.first as first1, id1.last as last1, app1.pa as PA1, 
e2.event_id as eventID2, eCode2.shortname_tx as event2, e2.event_cd as eventCD2, e2.bat_id as batID2, id2.first as first2, id2.last as last2, app2.pa as PA2, 
e3.event_id as eventID3, eCode3.shortname_tx as event3, e3.event_cd as eventCD3, e3.bat_id as batID3, id3.first as first3, id3.last as last3, app3.pa as PA3,
 e3.event_runs_ct as runsCt
from events e 
left join events e2 on e2.event_id = e.event_id + 1 and e.game_id = e2.game_id and e.bat_team_id = e2.bat_team_id
left join events e3 on e3.event_id = e.event_id + 2 and e.game_id = e3.game_id and e.bat_team_id = e3.bat_team_id
left join id id1 on e.bat_id = id1.id 
left join id id2 on e2.bat_id = id2.id
left join id id3 on e3.bat_id = id3.id 
left join lkup_cd_event eCode1 on e.event_cd = eCode1.value_cd 
left join lkup_cd_event eCode2 on e2.event_cd = eCode2.value_cd
left join lkup_cd_event eCode3 on e3.event_cd = eCode3.value_cd
left join (select e.bat_id, count(*) as pa from events e group by e.bat_id) app1 on e.bat_id = app1.bat_id
left join (select e.bat_id, count(*) as pa from events e group by e.bat_id) app2 on e2.bat_id = app2.bat_id
left join (select e.bat_id, count(*) as pa from events e group by e.bat_id) app3 on e3.bat_id = app3.bat_id
where e3.event_runs_ct >= 1
order by e.game_id, e.event_id;


Drop table if exists FourGramFull; 
Create table FourGramFull as 
select e.game_id, e.bat_team_id,
e.event_id as eventID1, eCode1.shortname_tx as event1, e.event_cd as eventCD1, e.bat_id as batID1, id1.first as first1, id1.last as last1, app1.pa as PA1, 
e2.event_id as eventID2, eCode2.shortname_tx as event2, e2.event_cd as eventCD2, e2.bat_id as batID2, id2.first as first2, id2.last as last2, app2.pa as PA2, 
e3.event_id as eventID3, eCode3.shortname_tx as event3, e3.event_cd as eventCD3, e3.bat_id as batID3, id3.first as first3, id3.last as last3, app3.pa as PA3,
e4.event_id as eventID4, eCode4.shortname_tx as event4, e4.event_cd as eventCD4, e4.bat_id as batID4, id4.first as first4, id4.last as last4, app4.pa as PA4,
 e4.event_runs_ct as runsCt
from events e 
left join events e2 on e2.event_id = e.event_id + 1 and e.game_id = e2.game_id and e.bat_team_id = e2.bat_team_id
left join events e3 on e3.event_id = e.event_id + 2 and e.game_id = e3.game_id and e.bat_team_id = e3.bat_team_id
left join events e4 on e4.event_id = e.event_id + 3 and e.game_id = e4.game_id and e.bat_team_id = e4.bat_team_id
left join id id1 on e.bat_id = id1.id 
left join id id2 on e2.bat_id = id2.id
left join id id3 on e3.bat_id = id3.id 
left join id id4 on e4.bat_id = id4.id 
left join lkup_cd_event eCode1 on e.event_cd = eCode1.value_cd 
left join lkup_cd_event eCode2 on e2.event_cd = eCode2.value_cd
left join lkup_cd_event eCode3 on e3.event_cd = eCode3.value_cd
left join lkup_cd_event eCode4 on e4.event_cd = eCode4.value_cd
left join (select e.bat_id, count(*) as pa from events e group by e.bat_id) app1 on e.bat_id = app1.bat_id
left join (select e.bat_id, count(*) as pa from events e group by e.bat_id) app2 on e2.bat_id = app2.bat_id
left join (select e.bat_id, count(*) as pa from events e group by e.bat_id) app3 on e3.bat_id = app3.bat_id
left join (select e.bat_id, count(*) as pa from events e group by e.bat_id) app4 on e4.bat_id = app4.bat_id
where e4.event_runs_ct >= 1
order by e.game_id, e.event_id;



select e.bat_id, count(*)
from events e
group by e.bat_id;

select * from id;
select * from games;

select count(*) from events
group by bat_id;

select * from lkup_cd_event;

#set this back to "Out" later 
update lkup_cd_event set shortname_tx = "OT" where value_cd = 2;

#DROP TABLE IF EXISTS avgRPGByFieldAndTeam;
#CREATE TABLE avgRPGByFieldAndTeam AS

Create table ThreeGramTrans as 
select value_cd, shortname_tx, longname_tx from lkup_cd_event;

select * from ThreeGramTrans0to1;
select * from ThreeGramFull;

select batID1, eventCD1
from ThreeGramFull;

select * from ThreeGramTrans0to1;
select * from ThreeGramTrans1to2;

select n.id, f.PA1, f.event1, f.eventCD1, f.event2, f.eventCD2,
CASE  
	when f.event2 = "OT" THEN t1.OT
	when f.event2 = "K" THEN t1.K
    when f.event2 = "SB" THEN t1.SB
    when f.event2 = "DI" THEN t1.DI
    when f.event2 = "CS" THEN t1.CS
    when f.event2 = "PK" THEN t1.PK
    when f.event2 = "WP" THEN t1.WP
    when f.event2 = "PB" THEN t1.PB
    when f.event2 = "BK" THEN t1.BK
    when f.event2 = "OA" THEN t1.OA
    when f.event2 = "FE" THEN t1.FE
    when f.event2 = "NIBB" THEN t1.NIBB
    when f.event2 = "IBB" THEN t1.IBB
    when f.event2 = "HBP" THEN t1.HBP
    when f.event2 = "XI" THEN t1.XI
    when f.event2 = "ROE" THEN t1.ROE
    when f.event2 = "FC" THEN t1.FC
    when f.event2 = "1B" THEN t1.1B
    when f.event2 = "2B" THEN t1.2B
    when f.event2 = "3B" THEN t1.3B
    when f.event2 = "HR" THEN t1.HR
END  as val
from id n
join ThreeGramFull f on f.batID1 = n.id 
join ThreeGramTrans0to1 t1 on f.eventCD1 = t1.value_cd ;


#0 to 1 scores 
select n.id, f.PA1, 
SUM(CASE  
	when f.event2 = "OT" THEN t1.OT
	when f.event2 = "K" THEN t1.K
    when f.event2 = "SB" THEN t1.SB
    when f.event2 = "DI" THEN t1.DI
    when f.event2 = "CS" THEN t1.CS
    when f.event2 = "PK" THEN t1.PK
    when f.event2 = "WP" THEN t1.WP
    when f.event2 = "PB" THEN t1.PB
    when f.event2 = "BK" THEN t1.BK
    when f.event2 = "OA" THEN t1.OA
    when f.event2 = "FE" THEN t1.FE
    when f.event2 = "NIBB" THEN t1.NIBB
    when f.event2 = "IBB" THEN t1.IBB
    when f.event2 = "HBP" THEN t1.HBP
    when f.event2 = "XI" THEN t1.XI
    when f.event2 = "ROE" THEN t1.ROE
    when f.event2 = "FC" THEN t1.FC
    when f.event2 = "1B" THEN t1.1B
    when f.event2 = "2B" THEN t1.2B
    when f.event2 = "3B" THEN t1.3B
    when f.event2 = "HR" THEN t1.HR
END)   as AccVal,
SUM(CASE  
	when f.event2 = "OT" THEN t1.OT
	when f.event2 = "K" THEN t1.K
    when f.event2 = "SB" THEN t1.SB
    when f.event2 = "DI" THEN t1.DI
    when f.event2 = "CS" THEN t1.CS
    when f.event2 = "PK" THEN t1.PK
    when f.event2 = "WP" THEN t1.WP
    when f.event2 = "PB" THEN t1.PB
    when f.event2 = "BK" THEN t1.BK
    when f.event2 = "OA" THEN t1.OA
    when f.event2 = "FE" THEN t1.FE
    when f.event2 = "NIBB" THEN t1.NIBB
    when f.event2 = "IBB" THEN t1.IBB
    when f.event2 = "HBP" THEN t1.HBP
    when f.event2 = "XI" THEN t1.XI
    when f.event2 = "ROE" THEN t1.ROE
    when f.event2 = "FC" THEN t1.FC
    when f.event2 = "1B" THEN t1.1B
    when f.event2 = "2B" THEN t1.2B
    when f.event2 = "3B" THEN t1.3B
    when f.event2 = "HR" THEN t1.HR
END) /f.PA1   as val  
from id n
join ThreeGramFull f on f.batID1 = n.id 
join ThreeGramTrans0to1 t1 on f.eventCD1 = t1.value_cd 
group by n.id
order by SUM(CASE  
	when f.event2 = "OT" THEN t1.OT
	when f.event2 = "K" THEN t1.K
    when f.event2 = "SB" THEN t1.SB
    when f.event2 = "DI" THEN t1.DI
    when f.event2 = "CS" THEN t1.CS
    when f.event2 = "PK" THEN t1.PK
    when f.event2 = "WP" THEN t1.WP
    when f.event2 = "PB" THEN t1.PB
    when f.event2 = "BK" THEN t1.BK
    when f.event2 = "OA" THEN t1.OA
    when f.event2 = "FE" THEN t1.FE
    when f.event2 = "NIBB" THEN t1.NIBB
    when f.event2 = "IBB" THEN t1.IBB
    when f.event2 = "HBP" THEN t1.HBP
    when f.event2 = "XI" THEN t1.XI
    when f.event2 = "ROE" THEN t1.ROE
    when f.event2 = "FC" THEN t1.FC
    when f.event2 = "1B" THEN t1.1B
    when f.event2 = "2B" THEN t1.2B
    when f.event2 = "3B" THEN t1.3B
    when f.event2 = "HR" THEN t1.HR
END) /f.PA1 DESC;


select n.id, f.PA2, f.event2, f.eventCD2, f.event3, f.eventCD3,
CASE  
	when f.event3 = "OT" THEN t2.OT
	when f.event3 = "K" THEN t2.K
    when f.event3 = "SB" THEN t2.SB
    when f.event3 = "DI" THEN t2.DI
    when f.event3 = "CS" THEN t2.CS
    when f.event3 = "PK" THEN t2.PK
    when f.event3 = "WP" THEN t2.WP
    when f.event3 = "PB" THEN t2.PB
    when f.event3 = "BK" THEN t2.BK
    when f.event3 = "OA" THEN t2.OA
    when f.event3 = "FE" THEN t2.FE
    when f.event3 = "NIBB" THEN t2.NIBB
    when f.event3 = "IBB" THEN t2.IBB
    when f.event3 = "HBP" THEN t2.HBP
    when f.event3 = "XI" THEN t2.XI
    when f.event3 = "ROE" THEN t2.ROE
    when f.event3 = "FC" THEN t2.FC
    when f.event3 = "1B" THEN t2.1B
    when f.event3 = "2B" THEN t2.2B
    when f.event3 = "3B" THEN t2.3B
    when f.event3 = "HR" THEN t2.HR
END  as val
from id n
join ThreeGramFull f on f.batID2 = n.id 
join ThreeGramTrans1to2 t2 on f.eventCD2 = t2.value_cd 
group by n.id;


select n.id, f.PA2, 
SUM(CASE  
	when f.event3 = "OT" THEN t2.OT
	when f.event3 = "K" THEN t2.K
    when f.event3 = "SB" THEN t2.SB
    when f.event3 = "DI" THEN t2.DI
    when f.event3 = "CS" THEN t2.CS
    when f.event3 = "PK" THEN t2.PK
    when f.event3 = "WP" THEN t2.WP
    when f.event3 = "PB" THEN t2.PB
    when f.event3 = "BK" THEN t2.BK
    when f.event3 = "OA" THEN t2.OA
    when f.event3 = "FE" THEN t2.FE
    when f.event3 = "NIBB" THEN t2.NIBB
    when f.event3 = "IBB" THEN t2.IBB
    when f.event3 = "HBP" THEN t2.HBP
    when f.event3 = "XI" THEN t2.XI
    when f.event3 = "ROE" THEN t2.ROE
    when f.event3 = "FC" THEN t2.FC
    when f.event3 = "1B" THEN t2.1B
    when f.event3 = "2B" THEN t2.2B
    when f.event3 = "3B" THEN t2.3B
    when f.event3 = "HR" THEN t2.HR
END)  as AccVal,
SUM(CASE  
	when f.event3 = "OT" THEN t2.OT
	when f.event3 = "K" THEN t2.K
    when f.event3 = "SB" THEN t2.SB
    when f.event3 = "DI" THEN t2.DI
    when f.event3 = "CS" THEN t2.CS
    when f.event3 = "PK" THEN t2.PK
    when f.event3 = "WP" THEN t2.WP
    when f.event3 = "PB" THEN t2.PB
    when f.event3 = "BK" THEN t2.BK
    when f.event3 = "OA" THEN t2.OA
    when f.event3 = "FE" THEN t2.FE
    when f.event3 = "NIBB" THEN t2.NIBB
    when f.event3 = "IBB" THEN t2.IBB
    when f.event3 = "HBP" THEN t2.HBP
    when f.event3 = "XI" THEN t2.XI
    when f.event3 = "ROE" THEN t2.ROE
    when f.event3 = "FC" THEN t2.FC
    when f.event3 = "1B" THEN t2.1B
    when f.event3 = "2B" THEN t2.2B
    when f.event3 = "3B" THEN t2.3B
    when f.event3 = "HR" THEN t2.HR
END)/f.PA2  as val
from id n
join ThreeGramFull f on f.batID2 = n.id 
join ThreeGramTrans1to2 t2 on f.eventCD2 = t2.value_cd 
group by n.id
order by SUM(CASE  
	when f.event3 = "OT" THEN t2.OT
	when f.event3 = "K" THEN t2.K
    when f.event3 = "SB" THEN t2.SB
    when f.event3 = "DI" THEN t2.DI
    when f.event3 = "CS" THEN t2.CS
    when f.event3 = "PK" THEN t2.PK
    when f.event3 = "WP" THEN t2.WP
    when f.event3 = "PB" THEN t2.PB
    when f.event3 = "BK" THEN t2.BK
    when f.event3 = "OA" THEN t2.OA
    when f.event3 = "FE" THEN t2.FE
    when f.event3 = "NIBB" THEN t2.NIBB
    when f.event3 = "IBB" THEN t2.IBB
    when f.event3 = "HBP" THEN t2.HBP
    when f.event3 = "XI" THEN t2.XI
    when f.event3 = "ROE" THEN t2.ROE
    when f.event3 = "FC" THEN t2.FC
    when f.event3 = "1B" THEN t2.1B
    when f.event3 = "2B" THEN t2.2B
    when f.event3 = "3B" THEN t2.3B
    when f.event3 = "HR" THEN t2.HR
END)/f.PA2 DESC;

Create Table three0to1Scores as
select n.id, f.PA1,
SUM(CASE  
	when f.event2 = "OT" THEN t1.OT
	when f.event2 = "K" THEN t1.K
    when f.event2 = "SB" THEN t1.SB
    when f.event2 = "DI" THEN t1.DI
    when f.event2 = "CS" THEN t1.CS
    when f.event2 = "PK" THEN t1.PK
    when f.event2 = "WP" THEN t1.WP
    when f.event2 = "PB" THEN t1.PB
    when f.event2 = "BK" THEN t1.BK
    when f.event2 = "OA" THEN t1.OA
    when f.event2 = "FE" THEN t1.FE
    when f.event2 = "NIBB" THEN t1.NIBB
    when f.event2 = "IBB" THEN t1.IBB
    when f.event2 = "HBP" THEN t1.HBP
    when f.event2 = "XI" THEN t1.XI
    when f.event2 = "ROE" THEN t1.ROE
    when f.event2 = "FC" THEN t1.FC
    when f.event2 = "1B" THEN t1.1B
    when f.event2 = "2B" THEN t1.2B
    when f.event2 = "3B" THEN t1.3B
    when f.event2 = "HR" THEN t1.HR
END)  as val
from id n
join ThreeGramFull f on f.batID1 = n.id 
join ThreeGramTrans0to1 t1 on f.eventCD1 = t1.value_cd 
group by n.id;

create table three1to2Scores as 
select n.id, f.PA2,
SUM(CASE  
	when f.event3 = "OT" THEN t2.OT
	when f.event3 = "K" THEN t2.K
    when f.event3 = "SB" THEN t2.SB
    when f.event3 = "DI" THEN t2.DI
    when f.event3 = "CS" THEN t2.CS
    when f.event3 = "PK" THEN t2.PK
    when f.event3 = "WP" THEN t2.WP
    when f.event3 = "PB" THEN t2.PB
    when f.event3 = "BK" THEN t2.BK
    when f.event3 = "OA" THEN t2.OA
    when f.event3 = "FE" THEN t2.FE
    when f.event3 = "NIBB" THEN t2.NIBB
    when f.event3 = "IBB" THEN t2.IBB
    when f.event3 = "HBP" THEN t2.HBP
    when f.event3 = "XI" THEN t2.XI
    when f.event3 = "ROE" THEN t2.ROE
    when f.event3 = "FC" THEN t2.FC
    when f.event3 = "1B" THEN t2.1B
    when f.event3 = "2B" THEN t2.2B
    when f.event3 = "3B" THEN t2.3B
    when f.event3 = "HR" THEN t2.HR
END)  as val
from id n
join ThreeGramFull f on f.batID2 = n.id 
join ThreeGramTrans1to2 t2 on f.eventCD2 = t2.value_cd 
group by n.id;

select * from three0to1Scores;
select * from three1to2Scores;

#all scores 
create table ROC_3gram as 
select t1.id, n.first, n.last, t1.PA1, (t1.val + t2.val) as accScore, (t1.val + t2.val)/t1.PA1 as score
from three0to1Scores t1
left join id n on t1.id = n.id 
join three1to2Scores t2 on t1.id = t2.id
order by (t1.val + t2.val)/t1.PA1 DESC;

select * from ROC_3gram;

#filter for >= 100 plate appearances
select t1.id, n.first, n.last, t1.PA1, (t1.val + t2.val) as accScore, (t1.val + t2.val)/t1.PA1 as score
from three0to1Scores t1
join id n on t1.id = n.id 
join three1to2Scores t2 on t1.id = t2.id
where t1.PA1 >= 100
order by (t1.val + t2.val)/t1.PA1 DESC;

