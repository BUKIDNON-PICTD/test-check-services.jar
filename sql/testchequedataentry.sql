[getList]
select * 
from checkparent
where createdbyname like $P{searchtext}
or transmittalnum like $P{searchtext}

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