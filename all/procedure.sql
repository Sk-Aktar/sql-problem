select * from credit_card_transactions;


create procedure additon(in n1 int,in n2 int,out result int)
set result=n1+n2;
call additon(3,5,@a);
select @a;
create procedure details()
select * from credit_card_transactions;
call details();
create procedure emp_detail(in trans_id int)
select * from credit_card_transactions where transaction_id=trans_id;
call emp_detail(7);
delimiter //
create procedure history()
begin
select * from credit_card_transactions where card_type="Gold" ;
select * from credit_card_transactions where card_type="Silver";
end
//
delimiter ;
call history();

create procedure addi(in n int,in n2 int ,out result int)
set result=n+n2;
call addi(5,6,@res);
select @res;