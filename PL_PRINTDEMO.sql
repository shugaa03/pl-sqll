SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE GETEMPLOYEE(
	ENO EMP.EMPNO%TYPE
)
AS
	VENAME EMP.ENAME%TYPE;
	VEJOB EMP.JOB%TYPE;
	VESAL EMP.SAL%TYPE;
	VDNAME DEPT.DNAME%TYPE;
	VDLOC DEPT.LOC%TYPE;
	CURSOR C1 IS SELECT ENAME, JOB, SAL, DNAME, LOC, EMPNO
				 FROM EMP E JOIN DEPT D ON(E.DEPTNO = D.DEPTNO);
BEGIN
	IF ENO IS NOT NULL THEN
		SELECT ENAME, JOB, SAL, DNAME, LOC INTO VENAME, VEJOB, VESAL, VDNAME, VDLOC
		FROM EMP E JOIN DEPT D ON (D.DEPTNO = E.DEPTNO)
		WHERE EMPNO = ENO;

		DBMS_OUTPUT.PUT_LINE(LPAD('-',30,'-'));
		DBMS_OUTPUT.PUT_LINE('EMPLOYEE INFORMATION');
		DBMS_OUTPUT.PUT_LINE(LPAD('-',30,'-'));
		DBMS_OUTPUT.PUT_LINE(RPAD('NAME', 15)|| ': ' || VENAME);
		DBMS_OUTPUT.PUT_LINE(RPAD('DESIGNATION', 15)|| ': ' || VEJOB);
		DBMS_OUTPUT.PUT_LINE(RPAD('SALARY', 15)|| ': '|| VESAL);
		DBMS_OUTPUT.PUT_LINE(RPAD('DEPARTMENT ', 15)|| ': ' || VDNAME);
		DBMS_OUTPUT.PUT_LINE(RPAD('LOCATION', 15)|| ': ' || VDLOC);
		DBMS_OUTPUT.PUT_LINE(LPAD('-', 30, '-'));
	ELSIF ENO IS NULL THEN
		FOR I IN C1
		LOOP
			DBMS_OUTPUT.PUT_LINE(LPAD('-',30, '-'));
			DBMS_OUTPUT.PUT_LINE(RPAD('EMPLOYEE NO', 15)||': '||I.EMPNO);
			DBMS_OUTPUT.PUT_LINE(LPAD('-',30, '-'));
			DBMS_OUTPUT.PUT_LINE(RPAD('NAME', 15)|| ': ' || I.ENAME);
			DBMS_OUTPUT.PUT_LINE(RPAD('DESIGNATION', 15)|| ': ' || I.JOB);
			DBMS_OUTPUT.PUT_LINE(RPAD('SALARY', 15)|| ': '|| I.SAL);
			DBMS_OUTPUT.PUT_LINE(RPAD('DEPARTMENT ', 15)|| ': ' || I.DNAME);
			DBMS_OUTPUT.PUT_LINE(RPAD('LOCATION', 15)|| ': ' || I.LOC);
			DBMS_OUTPUT.PUT_LINE(LPAD('-', 30, '-'));
		END LOOP;
	END IF;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE(LPAD('-',30,'-')); 
		DBMS_OUTPUT.PUT_LINE('RECORD NOT FOUND');
		DBMS_OUTPUT.PUT_LINE(LPAD('-',30,'-'));
END;
/