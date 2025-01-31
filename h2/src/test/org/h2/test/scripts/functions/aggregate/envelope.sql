-- Copyright 2004-2025 H2 Group. Multiple-Licensed under the MPL 2.0,
-- and the EPL 1.0 (https://h2database.com/html/license.html).
-- Initial Developer: H2 Group
--

CREATE TABLE TEST(V GEOMETRY);
> ok

SELECT ENVELOPE(V) FROM TEST;
>> null

INSERT INTO TEST VALUES ('POINT(1 1)');
> update count: 1

SELECT ENVELOPE(V) FROM TEST;
>> POINT (1 1)

INSERT INTO TEST VALUES ('POINT(1 2)'), (NULL), ('POINT(3 1)');
> update count: 3

SELECT ENVELOPE(V), ENVELOPE(V) FILTER (WHERE V <> 'POINT(3 1)') FILTERED1,
    ENVELOPE(V) FILTER (WHERE V <> 'POINT(1 2)') FILTERED2 FROM TEST;
> ENVELOPE(V)                         FILTERED1             FILTERED2
> ----------------------------------- --------------------- ---------------------
> POLYGON ((1 1, 1 2, 3 2, 3 1, 1 1)) LINESTRING (1 1, 1 2) LINESTRING (1 1, 3 1)
> rows: 1

CREATE SPATIAL INDEX IDX ON TEST(V);
> ok

-- Without index
SELECT ENVELOPE(N) FROM (SELECT V AS N FROM TEST);
>> POLYGON ((1 1, 1 2, 3 2, 3 1, 1 1))

-- With index
SELECT ENVELOPE(V) FROM TEST;
>> POLYGON ((1 1, 1 2, 3 2, 3 1, 1 1))

-- Without index
SELECT ENVELOPE(V) FILTER (WHERE V <> 'POINT(3 1)') FILTERED FROM TEST;
>> LINESTRING (1 1, 1 2)

-- Without index
SELECT ENVELOPE(V) FROM TEST WHERE V <> 'POINT(3 1)';
>> LINESTRING (1 1, 1 2)

INSERT INTO TEST VALUES ('POINT(-1.0000000001 1)');
> update count: 1

-- Without index
SELECT ENVELOPE(N) FROM (SELECT V AS N FROM TEST);
>> POLYGON ((-1.0000000001 1, -1.0000000001 2, 3 2, 3 1, -1.0000000001 1))

-- With index
SELECT ENVELOPE(V) FROM TEST;
>> POLYGON ((-1.0000000001 1, -1.0000000001 2, 3 2, 3 1, -1.0000000001 1))

TRUNCATE TABLE TEST;
> update count: 5

-- Without index
SELECT ENVELOPE(N) FROM (SELECT V AS N FROM TEST);
>> null

-- With index
SELECT ENVELOPE(V) FROM TEST;
>> null

SELECT ESTIMATED_ENVELOPE('TEST', 'V');
>> null

@reconnect off

SELECT RAND(1000) * 0;
>> 0.0

INSERT INTO TEST SELECT CAST('POINT(' || CAST(RAND() * 100000 AS INT) || ' ' || CAST(RAND() * 100000 AS INT) || ')' AS GEOMETRY) FROM SYSTEM_RANGE(1, 1000);
> update count: 1000

@reconnect on

-- Without index
SELECT ENVELOPE(N) FROM (SELECT V AS N FROM TEST);
>> POLYGON ((68 78, 68 99951, 99903 99951, 99903 78, 68 78))

-- With index
SELECT ENVELOPE(V) FROM TEST;
>> POLYGON ((68 78, 68 99951, 99903 99951, 99903 78, 68 78))

SELECT ESTIMATED_ENVELOPE('TEST', 'V');
>> POLYGON ((68 78, 68 99951, 99903 99951, 99903 78, 68 78))

TRUNCATE TABLE TEST;
> update count: 1000

@reconnect off

SELECT RAND(1000) * 0;
>> 0.0

INSERT INTO TEST SELECT CAST('POINT(' || (CAST(RAND() * 100000 AS INT) * 0.000000001 + 1) || ' '
    || (CAST(RAND() * 100000 AS INT) * 0.000000001 + 1) || ')' AS GEOMETRY) FROM SYSTEM_RANGE(1, 1000);
> update count: 1000

@reconnect on

-- Without index
SELECT ENVELOPE(N) FROM (SELECT V AS N FROM TEST);
>> POLYGON ((1.000000068 1.000000078, 1.000000068 1.000099951, 1.000099903 1.000099951, 1.000099903 1.000000078, 1.000000068 1.000000078))

-- With index
SELECT ENVELOPE(V) FROM TEST;
>> POLYGON ((1.000000068 1.000000078, 1.000000068 1.000099951, 1.000099903 1.000099951, 1.000099903 1.000000078, 1.000000068 1.000000078))

DROP TABLE TEST;
> ok

-- Test for index selection
CREATE TABLE TEST(G1 GEOMETRY, G2 GEOMETRY) AS (SELECT NULL, 'POINT (1 1)'::GEOMETRY);
> ok

CREATE SPATIAL INDEX G1IDX ON TEST(G1);
> ok

CREATE SPATIAL INDEX G2IDX ON TEST(G2);
> ok

SELECT ENVELOPE(G2) FROM TEST;
>> POINT (1 1)

DROP TABLE TEST;
> ok
