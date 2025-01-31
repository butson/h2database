-- Copyright 2004-2025 H2 Group. Multiple-Licensed under the MPL 2.0,
-- and the EPL 1.0 (https://h2database.com/html/license.html).
-- Initial Developer: H2 Group
--

SELECT 1 "A""B""""C""";
> A"B""C"
> -------
> 1
> rows: 1

SELECT 1 ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345;
> ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345
> ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> 1
> rows: 1

SELECT 1 ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456;
> exception NAME_TOO_LONG_2

SELECT 1 "ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345";
> ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345
> ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> 1
> rows: 1

SELECT 1 "ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456";
> exception NAME_TOO_LONG_2

SELECT 1 "ABCDEFGHIJKLMNOPQRSTUVWXYZ01234""5ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345";
> exception NAME_TOO_LONG_2

SELECT 1 "ABCDEFGHIJKLMNOPQRSTUVWXYZ012345""ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345";
> exception NAME_TOO_LONG_2

SELECT 3 U&"\0031", 4 U&"/0032" UESCAPE '/';
> 1 2
> - -
> 3 4
> rows: 1

EXPLAIN SELECT 1 U&"!2030" UESCAPE '!';
>> SELECT 1 AS U&"\2030"

SELECT 1 U&"ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ01234\0035";
> ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345
> ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> 1
> rows: 1

SELECT 1 U&"ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ012345ABCDEFGHIJKLMNOPQRSTUVWXYZ01234\00356";
> exception NAME_TOO_LONG_2
