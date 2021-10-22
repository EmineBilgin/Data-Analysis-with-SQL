

--A.create a table and insert values.
USE SampleSales

CREATE TABLE	Transactions (
    Sender_ID int ,
    Receiver_ID int   ,
    Amount int ,
    Transaction_Date DATE NOT NULL ,
    );

INSERT INTO Transactions(Sender_ID ,Receiver_ID ,Amount,Transaction_Date)
VALUES
(55,22,500,'20120518'),
(11,33,350,'20210519'),
(22,11,650,'20210519'),
(22,33,900,'20210520'),
(33,11,500,'20210521'),
(33,22,750,'20210521'),
(11,44,300,'20210522')

SELECT *
FROM Transactions

--- B.	Sum amounts for each sender (debits) and receiver (credits),

select Sender_ID, SUM (Amount) As Sender
from Transactions
group by Sender_ID;

select Receiver_ID, SUM (Amount) As Receiver
from Transactions
group by Receiver_ID;

-- C.	Full (outer) join debits and credits tables on account id, taking net change as difference
-------     between credits and debits, coercing nulls to zeros with coalesce()

SELECT coalesce(A.Sender_ID, B.Receiver_ID) as Account_ID, (coalesce(B.Receiver, 0) -coalesce( A.Sender,0)) as Net_Change 
from (select Sender_ID, SUM (Amount) As Sender
from Transactions
group by Sender_ID) as A
full outer JOIN (select Receiver_ID, SUM (Amount) As Receiver
from Transactions
group by Receiver_ID) AS B 
ON A.Sender_ID = B.Receiver_ID 
order by Net_Change desc;

-------------///////////////----------






