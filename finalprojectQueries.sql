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


select e.game_id, e.bat_team_id,
e.event_id as eventID1, eCode1.longname_tx as event1, e.event_cd as eventCD1, e.bat_id as batID1, id1.first as first1, id1.last as last1, app1.pa as PA1, 
e2.event_id as eventID2, eCode2.longname_tx as event2, e2.event_cd as eventCD2, e2.bat_id as batID2, id2.first as first2, id2.last as last2, app2.pa as PA2, 
e3.event_id as eventID3, eCode3.longname_tx as event3, e3.event_cd as eventCD3, e3.bat_id as batID3, id3.first as first3, id3.last as last3, app3.pa as PA3,
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



select e.bat_id, count(*)
from events e
group by e.bat_id;

select * from id;
select * from games;

select count(*) from events
group by bat_id;
