[getList]
SELECT * 
FROM checkmain
WHERE
payee LIKE $P{searchtext}
OR checknumber LIKE $P{searchtext}
OR checkdate LIKE $P{searchtext}
OR checkamt LIKE $P{searchtext}
OR officeorigin LIKE $P{searchtext}
OR checktype LIKE $P{searchtext}
OR state LIKE $P{searchtext}
ORDER BY checkdate DESC

[getItems]
select *
from checkchild
where parentid = $P{objid}
order by checkno ASC

[getCheckReport]
select * from checkparent cp 
inner join checkchild cc on cc.parentid = cp.objid
where cp.objid = $P{objid}
order by checkno ASC

[getPayeeLookup]
SELECT *
FROM checkpayee 
WHERE payeename LIKE $P{searchtext}

[getPayeeeLookup]
SELECT r.* FROM checkpayee r 
WHERE  (r.payeename LIKE $P{payeename})
${filter}
ORDER BY r.payeename

[getCheckTransmittals]
SELECT c.objid, c.transmittalnum, ci.checknumber, ci.payee, ci.checkamt FROM checktransmittal c
INNER JOIN checktransmittalitems ci ON ci.transmittalid = c.objid 
WHERE c.objid = $P{objid}

[findByRBAcct]
SELECT * FROM checkrunningbalance WHERE accountid=$P{accountid}

[findByEstRBAcct]
SELECT * FROM estrunningbalance WHERE accountid=$P{accountid}

[findCompareBankAccounts]
SELECT DISTINCT(ca.accountno), ca.objid, ca.accountname FROM testchequedataentry.checkaccount ca
INNER JOIN etracs254_bukidnon.creditmemo cm ON ca.accountno = cm.bankaccount_code
WHERE cm.bankaccount_code = $P{bankaccount}

[getConsoReport]
SELECT * FROM
(
select checkdate as txndate, '' as adacontrolno, checkaccount as accountno, checknumber, checkdate, payee as payeename, particulars, checkamt as amount, respcentercode, expenseclass, provfund
from checkmain
where state = 'CLOSED'
and checkdate BETWEEN $P{datefrom} AND $P{dateto}

union ALL

select a.`txndate`,ai.`adacontrolno`,ai.`accountno`, 'ada' as checknumber, null as checkdate, ai.`payeename`, ai.`particulars`, ai.`amount`, ai.`respcentercode`, ai.`expenseclass`, ai.`fundcode` as provfund 
from ada a
inner join adaitems ai on ai.`parentid` = a.`objid` 
where txndate BETWEEN $P{datefrom} AND $P{dateto} ) xx
ORDER BY xx.txndate DESC