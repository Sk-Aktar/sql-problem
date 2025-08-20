

-- 1. Write a SQL statement to rename the table countries to country_new.

alter table coutries 
rename country_new; 

-- 2. Write a SQL statement to add a column region_id to the table locations.

alter table country_new
add region_id int;

-- 3. Write a SQL statement to add a columns ID as the first column of the table locations.

alter table country_new
add ids int first;

-- 4. Write a SQL statement to add a column region_id after state_province to the table locations.

alter table country_new
add state_province text after region;

-- 5. Write a SQL statement change the data type of the column country_id to integer in the table locations.

alter table country_new
modify region_id varchar(20);
describe country_new;

-- 6. Write a SQL statement to drop the column city from the table locations.

alter table country_new
drop region; 

-- 7. Write a SQL statement to change the name of the column state_province to state, keeping the data type and size same.

alter table country_new
rename column state_province to state;

-- 8. Write a SQL statement to add a primary key for the columns location_id in the locations table.

alter table country_new
add primary key(id);

-- 9. Write a SQL statement to add a primary key for a combination of columns location_id and country_id.

alter table country1
add primary key(country_id,region_id);

-- 10. Write a SQL statement to drop the existing primary from the table locations on a combination of columns location_id and country_id.

alter table country1
drop primary key;

-- 11. Write a SQL statement to add a foreign key on job_id column of job_history table referencing to the primary key job_id of jobs table.

alter table job_history
add foreign key(job_id) references job2(job_id);

-- 12. Write a SQL statement to add a foreign key constraint named fk_job_id on job_id column of job_history table referencing to the primary key job_id of jobs table.

alter table job_history
add column fk_job_id int,
add constraint fk_job_id 
foreign key(fk_job_id) references job2(job_id);

-- 13. Write a SQL statement to drop the existing foreign key fk_job_id from job_history table on job_id column 
-- which is referencing to the job_id of jobs table.

alter table job_history
drop foreign key fk_job_id;

-- 14. Write a SQL statement to add an index named indx_job_id on job_id column in the table job_history.

alter table job_history
add index indx_job_id(job_id);

-- 15. Write a SQL statement to drop the index indx_job_id from job_history table.

alter table job_history
drop index indx_job_id;