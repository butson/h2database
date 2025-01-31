-- Copyright 2004-2025 H2 Group. Multiple-Licensed under the MPL 2.0,
-- and the EPL 1.0 (https://h2database.com/html/license.html).
-- Initial Developer: H2 Group
--

SET MODE STRICT;
> ok

VALUES 1 IN ();
> exception SYNTAX_ERROR_2

SELECT TOP 1 * FROM (VALUES 1, 2);
> exception SYNTAX_ERROR_1

SELECT * FROM (VALUES 1, 2) LIMIT 1;
> exception SYNTAX_ERROR_1

CREATE TABLE TEST(ID IDENTITY);
> exception UNKNOWN_DATA_TYPE_1

CREATE TABLE TEST(ID BIGINT AUTO_INCREMENT);
> exception SYNTAX_ERROR_2

SET MODE LEGACY;
> ok

CREATE TABLE TEST(ID BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY, V INTEGER NOT NULL);
> ok

INSERT INTO TEST(ID, V) VALUES (10, 15);
> update count: 1

INSERT INTO TEST(V) VALUES 20;
> update count: 1

TABLE TEST;
> ID V
> -- --
> 10 15
> 11 20
> rows: 2

UPDATE TOP(1) TEST SET V = V + 1;
> update count: 1

TABLE TEST;
> ID V
> -- --
> 10 16
> 11 20
> rows: 2

MERGE INTO TEST T USING (VALUES (10, 17), (11, 30)) I(ID, V) ON T.ID = I.ID
WHEN MATCHED THEN UPDATE SET V = I.V WHERE T.ID > 10;
> update count: 1

TABLE TEST;
> ID V
> -- --
> 10 16
> 11 30
> rows: 2

CREATE TABLE T2(ID BIGINT PRIMARY KEY, V INT REFERENCES TEST(V));
> ok

DROP TABLE T2, TEST;
> ok

CREATE TABLE TEST(ID BIGINT IDENTITY(1, 10));
> ok

DROP TABLE TEST;
> ok

CREATE SEQUENCE SEQ;
> ok

SELECT SEQ.NEXTVAL;
>> 1

SELECT SEQ.CURRVAL;
>> 1

DROP SEQUENCE SEQ;
> ok

SELECT 1 = TRUE;
>> TRUE

SET MODE STRICT;
> ok

CREATE TABLE TEST(LIMIT INTEGER, MINUS INTEGER);
> ok

DROP TABLE TEST;
> ok

SET MODE REGULAR;
> ok
