insert into `issues`(`title`,`issue_status`,`repository_id`,`assignee_id`)
select
	concat("Critical problem with", f.name,"!") as 'title',
    'Open' as 'issues_status',
    ceil((f.id*2)/3) as'repository_id',
    (
    select `contributer_id`
    from `commits`
    where `commits`.`id`=`f`.`commit_id`
    ) as 'assignee_id'
    from `files` as `f`
    where `f`.`id` between 46 and 50;
    
    
    SET SQL_SAFE_UPDATES = 0;

UPDATE repositories_contributors as rc
SET rc.repository_id = 

(SELECT r.id FROM repositories as r
 WHERE r.id NOT IN (SELECT repository_id FROM (
 SELECT repository_id FROM repositories_contributors) as a)
 ORDER BY r.id LIMIT 1)
 
WHERE rc.repository_id = rc.contributor_id;


DELETE FROM repositories
WHERE id NOT IN(SELECT repository_id FROM issues);