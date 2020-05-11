[getList]
SELECT * 
FROM ada
WHERE
txndate LIKE $P{searchtext}
OR controlno LIKE $P{searchtext}
OR adaamt LIKE $P{searchtext}
OR people LIKE $P{searchtext}
OR particulars LIKE $P{searchtext}
OR cashbookno LIKE $P{searchtext}
OR state LIKE $P{searchtext}
ORDER BY txndate DESC
