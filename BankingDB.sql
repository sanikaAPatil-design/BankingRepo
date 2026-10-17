create database BankingDB;
use BankingDB;

create Table Customers(
CustomerID INT PRIMARY KEY,
Firstname VARCHAR(50),
Lastname VARCHAR(50),
Email VARCHAR(100),
Phone VARCHAR(15),
AccountCreations date
);

describe Customers;


-- -------------------
-- LAB 2
-- -------------------

CREATE TABLE Accounts (
    AccountID INT,
    AccountType VARCHAR(20),
    Balance DECIMAL(10,2)
);

CREATE TABLE Transactions (
    TransactionID INT,
    TransactionDate DATE,
    Amount DECIMAL(10,2),
    TransactionType VARCHAR(20)
);

CREATE TABLE Branches (
    BranchID INT,
    BranchName VARCHAR(100),
    BranchAddress VARCHAR(200),
    BranchPhone VARCHAR(15)
);

create table AccountBranches(
AssignmentDate Date
);

create table Loans(
LoanID int,
LoanAmount Decimal(10,2),
InterestRate Decimal(5,2),
StartDate Date,
EndDate Date
);

-- added dateofbirth to customers table
alter table Customers add column DateOfBirth Date;

-- modify the datatype number for phone
alter table Customers modify Phone varchar(20);

-- added constraint to check the minbalance
alter table Accounts add constraint chk_MinBalance check (Balance >= 1000);
show create table Accounts;

-- delete table using drop
drop table AccountBranches;

-- add customerid column in accounts table
alter table Accounts add CustomerID int;

-- connect customers and accounts table using FK
alter table Accounts
add constraint FK_Accounts_Customers
foreign key (CustomerID)
references Customers(CustomerID);

-- modify the firstname datatype not null to the customers table
alter table Customers modify Firstname varchar(50) not null;

-- email should be unique
alter table Customers add constraint uq_Email unique (Email);

-- 1 add primary key
alter table Branches add primary key (BranchID);

-- add column in Account table
alter table Accounts add BranchID int;

-- connect branches and accounts table using fk
alter table Accounts
add constraint FK_Accounts_Branches
foreign key (BranchID)
references Branches(BranchID);

-- 2 add primary key
alter table Accounts add primary key (AccountID);

-- add column in transaction table 
alter table transactions add AccountID int;

-- connect accounts to transaction table
alter table transactions
add constraint FK_transaction_Accounts
foreign key(AccountID)
references Accounts(AccountID);

-- 3 add primary key 
alter table Customers add primary key (CustomerID);

-- add column in loans table
alter table Loans add CustomerID int;

-- connect customer to loans table
alter table Loans
add constraint Fk_Loans_Customers
foreign key(CustomerID)
references Customers(CustomerID);


-- -------------
-- LAB 3
-- -------------

insert into customers(CustomerID,FirstName,LastName,Email,Phone,DateOfBirth)
values
(101,'Rahul','Sharma','rahul@gmail.com','9876543210','1998-04-15');

insert into Accounts(AccountID,CustomerID,AccountType,Balance)
values
(201,101,"Savings",25000);

INSERT INTO Customers
(CustomerID, FirstName, LastName, Email, Phone, DateOfBirth)
VALUES
(102, 'Priya', 'Patil', 'priya@gmail.com', '9988776655', '2000-09-20'),
(103, 'Amit', 'Patel', 'amit.patel@gmail.com', '9876500001', '1995-06-18'),
(104, 'Sneha', 'Joshi', 'sneha.joshi@gmail.com', '9876500002', '1997-09-12'),
(105, 'Rohan', 'Kulkarni', 'rohan.k@gmail.com', '9876500003', '1993-11-25');

INSERT INTO Accounts
(AccountID, CustomerID, AccountType, Balance)
VALUES
(202, 102, 'Current', 40000),
(203, 103, 'Savings', 35000),
(204, 104, 'Current', 60000),
(205, 105, 'Savings', 45000);

INSERT INTO Transactions
(TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES
(301, 201, '2025-05-10', 5000, 'Deposit'),
(302, 202, '2025-05-11', 2500, 'Withdraw'),
(303, 203, '2025-05-12', 10000, 'Deposit'),
(304, 204, '2025-05-13', 3000, 'Withdraw'),
(305, 205, '2025-05-14', 7000, 'Deposit');

INSERT INTO Branches
(BranchID, BranchName, BranchAddress, BranchPhone)
VALUES
(1, 'Mumbai Branch', 'Andheri, Mumbai', '0221111111'),
(2, 'Pune Branch', 'Shivaji Nagar, Pune', '0202222222'),
(3, 'Nashik Branch', 'College Road, Nashik', '0253222222'),
(4, 'Nagpur Branch', 'Sitabuldi, Nagpur', '0712333333'),
(5, 'Navi Mumbai Branch', 'Vashi, Navi Mumbai', '0224444444');

INSERT INTO Loans
(LoanID, LoanAmount, InterestRate, StartDate, EndDate, CustomerID)
VALUES
(301, 500000, 8.50, '2025-01-15', '2030-01-15', 101),
(302, 300000, 9.25, '2025-02-10', '2028-02-10', 102),
(303, 750000, 8.75, '2025-03-20', '2032-03-20', 103),
(304, 250000, 10.00, '2025-04-05', '2029-04-05', 104),
(305, 1000000, 7.95, '2025-05-12', '2035-05-12', 105);


-- Task 2: Update Existing Banking Records
update Customers set Phone='9999999999' where CustomerID=101;

select * from Customers where CustomerID=101;

update Customers set Email="rahul.sharma@gmail.com" where CustomerID=101;

update Accounts set Balance='30000' where AccountID=201;

select * from Accounts where AccountID=201;

-- Task 3: Delete Banking Records and Verify Data
delete from Transactions where TransactionID=302;

select * from Transactions;

delete from Accounts where AccountID =202;

select * from Accounts;


-- -------------
-- LAB 4
 -- ------------
 
 -- Task 1: Review Customer Banking Information
 select * from Customers;
 
 select FirstName,LastName,Email,Phone from Customers;
 
 select AccountID,AccountType,Balance from Accounts;
 
 
 -- Task 2: Investigate Specific Customer Transactions
select * from Accounts where AccountType="Savings";

select * from Accounts where Balance > 25000;

select * from Transactions where Amount between 5000 and 20000;

select * from Customers where customerID in (101,102,103);

select * from Customers where FirstName like 'R%';


-- ACTIVITY

select * from Accounts where AccountType="Current";

select * from Accounts where Balance < 15000;

select * from Transactions where Amount between 1000 and 10000;

select * from Customers where customerID in (104,105);

select * from Customers where LastName like 'S%';


-- Task 3: Generate Banking Reports for Management

select * from Customers order by FirstName asc;

select * from Accounts order by Balance desc;

select distinct AccountType from Accounts;

select * from Accounts order by Balance desc limit 3;

select * from Transactions limit 5 offset 2;

-- ACTIVITY

select * from Customers order by LastName asc;

select * from Transactions order by Amount desc;

select distinct TransactionType from Transactions;

select * from Transactions limit 4 offset 3;

-- Task 4: Identify Missing Banking Information

select * from Customers where Phone is null;

select * from Customers where Email is not null;

-- ACTIVITY

select * from Customers where Email is null;

select * from Accounts where Balance is not null;

-- Task 5: Categorize Customer Accounts Based on Balance

select AccountID,Balance,
case
     when Balance >=50000 then "premimum Account"
	 when Balance >=25000 then "standard Account"
else "Basic Account"
end as "Accountcategory" from Accounts;

-- ACTIVITY

 select Amount,
 case 
     when Amount >=8000 then "High Transaction"
     when Amount >=5000 then "Medium Transaction"
else "Low Transaction"
end as "Amountcategory" from Transactions;

-- Task 6: Analyze Customer Transactions Using Window Functions

select AccountID,Balance,
rank() over(order by Balance desc) as Balancerank from Accounts;

select TransactionID,Amount,
sum(Amount) over(order by TransactionDate)as RunningTotal from Transactions;

select TransactionID,Amount,
avg(Amount) over()as AverageTransaction from Transactions;


-- ------------
-- LAB 5
-- ------------

 -- Task 1: Search Customers Based on Name
 select * from Customers where FirstName like 'A%';
 
select * from Customers where Email like '%gmail%';
 
select * from Customers where LastName like '%kar';
 
 -- ACTIVITY
select * from Customers where FirstName like 'R%';
  
select * from Customers where Email like '%yahoo%';
   
select * from Customers where LastName like '%P';
   
select * from Customers where Phone like '%99';
   
-- Task 2: Filter Records for Selected Banking Categories
   
select * from Accounts where AccountType in ('Savings', 'Current');
   
select * from Transactions where TransactionType in ('Deposit', 'Withdrawal');
   
select * from Customers where CustomerID in (101,102,105);
   
-- ACTIVITY
select * from Accounts where AccountType in ('Savings', 'salary');

select * from Transactions where TransactionType in ('Deposit', 'Payment');

select * from Customers where CustomerID in (103,104);

select * from Accounts where AccountID in ('selected');

-- Task 3: Generate Sorted Banking Reports

select * from Customers order by LastName ASC;

select * from Accounts order by Balance DESC;

select * from Transactions order by TransactionDate DESC;


-- ACTIVITY
select * from Customers order by LastName asc;

select * from Accounts order by AccountType DESC;

select * from Transactions order by Amount DESC;

select * from Customers order by DateOfBirth asc;

-- Task 4: Control Result Size for Faster Review

select * from Accounts order by Balance desc limit 5;

select * from Customers limit 3;

select * from Transactions limit 5 offset 3;



-- -----------
-- LAB 6
-- -----------

-- Task 1: Apply string, math, and date functions

select * from Customers;

select FirstName,upper(FirstName) as uppercaseName from Customers;

select FirstName,lower(FirstName) as lowercaseName from Customers;

select Firstname,length(FirstName)as lengname from Customers;

select FirstName,left(FirstName,3) as Initials from Customers;

select concat(FirstName,' - ',LastName) as FullName from customers;

select round(1256.75) as Rounded_Value;

select ceil(1256.25) as Ceiling_Value;

select floor(1256.75) as Floor_Value;

select abs(-2500) as Absolute_Value;

select mod(25,4) as Remainder;

select * from Customers;

select curdate();

select now();

select CustomerID ,year(DateOfBirth) as Birthyear from Customers;

select CustomerID ,Month(DateOfBirth) as BirthMonth from Customers;

SELECT CustomerID, DATEDIFF(CURDATE(),DateOfBirth) AS Days FROM customers;

select FirstName,DateOfBirth,if (year(DateOfBirth) <=1995,'adult','young') as category from Customers;

select FirstName,ifnull(Phone, 'Not Available')as PhoneNumber from Customers;

select greatest(
'2000-09-20',
'1995-06-18',
'1997-09-12',
'1993-11-25'
) as LatestBirthDate;

select least(
'2000-09-20',
'1995-06-18',
'1997-09-12',
'1993-11-25'
) as LeastBirthDate;

select FirstName,nullif(FirstName ,'Priya')as result from Customers;

-- Task 2: Analyze Overall Banking Performance

select avg(Balance)as avg_balance from Accounts;

select sum(Balance)as total_balance from Accounts;

select max(Balance) as highest_balance from Accounts;

select min(Balance) as lowest_balance from Accounts;

select count(*)as total_accounts from Accounts;

-- Task 3: Analyze Account-wise Performance

select AccountType,sum(Balance)as Totalbalance from Accounts group by AccountType;

-- Task 4: Identify High-Performing Categories

select AccountType,sum(Balance) as Total_balance from Accounts group by AccountType having sum(Balance) > 25000;

-- --------
-- 7 LAB
-- -------- 
-- Task 2: Rank Customer Loans Using RANK()
select loanID,loanamount,customerid,rank() over( order by loanamount desc) as loanRank from loans;

-- Task 3: Rank Customer Loans Using DENSE_RANK()
select loanID,customerid,loanamount,dense_rank() over( order by loanamount desc) as denseRank from loans;

-- Task 4: Assign Row Numbers Using ROW_NUMBER()
select loanID,customerid,loanamount,row_number() over( order by loanamount desc) as rowNumber from loans;

-- Task 5: Understanding PARTITION BY
select loanID,customerid,loanamount,row_number() over( partition by customerid order by loanamount desc)as rowNum from loans;

-- Task 6: Calculate Running Total Using SUM() OVER()
select loanID,customerid,loanamount,
sum(loanamount) over( order by loanamount desc )as runningTotal from loans;

-- Task 7: Compare Previous Loan Records Using LAG()
select loanID,customerid,loanamount, lag(loanamount) over (order by loanamount desc) as previousLoanamount from loans;

-- Task 8: Compare Next Loan Records Using LEAD()
select loanID,customerid,loanamount,lead(loanamount) over( order by loanamount desc) as nextloanamount from loans;

-- -----------
-- 8 LAB
-- -----------

-- Task 1: Generate Accounts Transaction Reports
select
 a.accountid,a.accounttype,a.balance,
t.TransactionID,
t.Transactiondate,
t.Transactiontype,
t.amount
from accounts a
inner join Transactions t
on a.accountid = t.accountid;

-- Task 2: Display All Accounts Including Those Without Transactions
select 
a.accountid,a.accounttype,a.balance,
t.TransactionID,
t.Transactiondate,
t.Transactiontype,
t.amount
from accounts a
left join Transactions t
on a.accountid =t.accountid;

-- Task 3: Generate Deposit Transaction Reports
select 
a.accountid,a.accounttype,a.balance,
t.TransactionID,
t.Transactiondate,
t.Transactiontype,
t.amount
from accounts a
inner join Transactions t
on a.accountid = t.accountid
where t.Transactiontype ="deposit";

-- Task 4: Generate High Balance Account Transaction Reports
select 
a.accountid,a.accounttype,a.balance,
t.TransactionID,
t.Transactiondate,
t.Transactiontype,
t.amount
from accounts a
inner join Transactions t
on a.accountid = t.accountid
where a.balance > 3000
order by a.balance desc;

-- --------
-- 9 LAB
-- --------

-- Task 1: Identify Transactions Above the Average Transaction Amount
select avg(amount)from Transactions;

select * from Transactions
where amount >
(
select avg(amount)
from Transactions
);

-- Task 2: Identify Accounts with Above-Average Balance
select accountid,accounttype,balance,customerid
from accounts where balance > 
(
select avg(balance)
from accounts
)
order by balance desc;

-- Task 3: Identify Deposit Accounts Using a Multi-Row Subquery
select accountid,accounttype,balance,customerid
from accounts
where accountid in
(
select accountid
from Transactions
where Transactiontype ="deposit"
);

-- Task 4: Identify the Account with the Highest Balance
select accountid,accounttype,balance,customerid
from accounts
where balance=
(
select max(balance)
from accounts
);

-- ---------
-- 10 LAB
-- ---------

-- Task 1: Create a View for High-Balance Accounts
create view High_balance_accounts as
select
accountid,
accounttype,
balance,
customerid
from accounts
where balance > 30000;

-- Task 2: Retrieve Data Using the View
select * from High_balance_accounts;

-- Task 3: Modify the View to Include Transaction Details
create or replace view High_balance_accounts as
select 
a.accountid,
a.accounttype,
a.balance,
a.customerid,
t.TransactionID,
t.Transactiondate,
t.Transactiontype,
t.amount
from accounts a 
inner join Transactions t
on a.accountid = t.accountid
where a.balance > 30000;

-- Task 4: Generate Banking Reports Using the View
select
accountid,
accounttype,
balance,
customerid,
TransactionID,
Transactiontype,
Transactiondate,
amount
from High_balance_accounts
order by balance desc;









































   
   
   
   
   
   
  
 
 









 















 
 
 






























