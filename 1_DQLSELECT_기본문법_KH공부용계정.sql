/*
    DML : 데이터 조작 언어, INSERT, UPDATE , DELETE , SELECT(DCL)
    DDL : 데이터 정의 언어, CREATE, ALTER, DROP ...
    DCL : 권한부여 , GRANT, REVOVE
    TCL : 트랜젝션 제어 , COMMIT, ROLLBACK, SAVEPOINT
    
    <SELECT>
     - 데이터를 조회하거나 검색할 때 사용하는 명령어
     
     * RESULTSET
      - SELECT 구문을 통해 조회된 데이터의 결과물(조회된 행들의 집합)
*/
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

--  EMPLOYEE테이블의 전체 사원들의 사번, 이름, 급여 컬럼을 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE; -- 대문자로 작성하는것이 권장된다.

-- EMPLOYEE 테이블의 모든 행의 모든 컬럼을 조회
SELECT *
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 전체 사원들의 이름, 이메일, 휴대폰 번호 조회
SELECT EMP_NAME, EMAIL, PHONE
FROM EMPLOYEE;

--실습문제--

-- 1. job테이블의 모든 컬럼 조회
SELECT *
FROM JOB;
-- 2. JOB테이블의 직급명조회
SELECT JOB_NAME
FROM JOB;
-- 3. DEPARTMENT 테이블의 모든 컬럼 조회
SELECT *
FROM DEPARTMENT; 
-- 4. EMPLOYEE 테이블의 직원명, 이메일,전화번호,입사일 컬럼 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;
-- 5. EMPLOYEE 테이블의 입사일, 직원명 , 급여칼럼 조회
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;  

/*
    <컬럼값을 통한 산술연산>
    - 조회하고자 하는 컬럼들을 나열하는 select절에 산술연산자를 기술한 결과를 조회
*/

-- EMPLOYEE 테이블에서 직원명, 월급, 연봉(월급*12)
SELECT EMP_NAME, SALARY, SALAR * 12
FROM EMPLOYEE;

-- EMPLOYEE 테이블로부터 직원명, 월급, 보너스 ,보너스 포함 연봉을 조회
SELECT EMP_NAME, SALARY, BONUS, ( SALARY * 12 ) * BONUS
FROM EMPLOYEE;
-- 산술연산과정에서 NULL 값이 존재하는 경우 산술연산의 결과마저도 NULL이 된다

-- EMPLOYEE 에서 직원명,입사일,근무일수(오늘날짜 - 입사일) 조회
-- ORACLE에서는 DATE타입간의 산술연산 가능
-- 오늘날짜 : SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;
--산술연산의 결과는 " 일"단위로 출력

/*
    <별칭부여>
    [표현법]
    1. 컬렴명 AS 별칭
    2. 컬럼명 AS "별칭"
    3. 컬럼명 별칭
    4. 컬럼명 "별칭"
    
    부여하고자 하는 별칭에 특수문자나 띄어쓰기가 들어간 경우 ""로 묶어서 표기해야한다.
*/

-- 연봉 별칭부여
SELECT EMP_NAME    AS 사원명, SALARY      AS "급여(월)", SALARY * 12 "연봉(보너스미포함)"
FROM EMPLOYEE;

/*
    <리터럴>
    ORACLE에서 문자열은 ''로 기술한다
    임의로 지정한 문자열 및 정수를 SELECT절에 기술하면 실제 그 테이블에 값이 존재하는것처럼 조회가능하다.
*/

-- EMPLOYEE에서 사번,사원명,급여,급여단위(원), 조회하기
SELECT EMP_ID, EMP_NAME, SALARY, '원' 급여단위
FROM EMPLOYEE;

/*
    <DISTINCT>
     - 조회하고자 하는 컬럼에ㅓ 중복된 값을 제거하고 한번만 조회하고자 할때 사용
     - SELECT절에는 1개의 EISTINCT구문만 사용할 수 있다.
*/
-- EMPLOYEE에서 부서코드들 조회
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

-- DEPT_CODE, JOB_CODE 조회하기
-- DEPT-CODE와 JOB_CODE값을 세트로 묶어서 중복값인지 판별한다.(행기준 중복여부)
SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;
--------------------------------------------------------------------------

/*
    <WHERE절>
     -조회하고자 하는 테이블에특정조건을 제시해서 그 조건에 맞는 데이터들만 조회할 수 있다.
     [표현법]
     SELECT 조회할 컬럼명 ...
     FROM 테이블명
     WHERE 조건식;
     
     실행순서
     FROM -> WHERE -> SELECT
     
     <비교연산자>
     > , < , >= , <=
     =, != , ^=, <>
*/
-- EMPLOYEE테이블로부터 급여가 400만원 이상인 사원만 조회(모든컬럼)
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000;
-- EMPLOYEE테이블로부터 부서코드가 D9 사원들의 사원명,부서코드 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D9';
--WHERE DEPT_CODE ^= 'D9';
WHERE DEPT_CODE <> 'D9';
-- NULL은 동등비교 결과 항상 FALSE

-- 실습문제

-- 1. EMPLOYEE 테이블에서 급여가 300 만원 이상인 사원들의 이름, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY >= 3000000;
-- 2. EMPLOYEE 테이블에서 직급코드가 J2 인 사원들의 이름, 급여, 보너스 조회
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J2';
-- 3. EMPLOYEE 테이블에서 현재 재직중인 사원들의 사번, 이름, 입사일 조회
SELECT DEPT_CODE, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE QUIT_YN = 'N';
-- 4. EMPLOYEE 테이블에서 연봉 (급여 * 12) 이 5000 만원 이상인 사원들의 이름, 급여, 연봉, 입사일 조회
SELECT EMP_NAME, SALARY, SALARY * 12 연봉, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY * 12 >= 50000000;
-- 연봉은 실행순서상 실행된 이후에 부여된 별칭이므로 사용불가

/*
    <논리연산자>
    여러개의 조건을 엮을 때 사용
    
    AND : 자바의 &&와 동일. -이면서, 그리고
    OR : 바바의 ||와 동일, -이거나 ,또는
*/

-- EMPLOYEE테이블에서 부서코드가 D9이면서 급여가 500만원 이상이 ㄴ사원들의 이름, 부서코드 급여를 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9'
      AND SALARY >= 5000000;
-- 급여가 350만원 이상이고, 600만원 히아인 사원들의 이름, 사번, 급여, 직급코드를 조회
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3500000
      AND SALARY <= 6000000;
/*
    <BETWEEN ~ AND>
    컬럼 값이 특정 범위 안에 있는지 확인
    [표현법]    
    비교대상컬럼 BETWEEN 하한값 AND 상한값; == 하한값 <= 컬럼 AND 컬럼 <= 상한값
*/
SELECT *
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- 급여가 350만원 미만이고, 600만원 초과인 사원들의 이름, 사번, 급여를 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
-- NOT은 자바의 논리부정연산자와 동일한 역할을 한다

-- ORACLE에서는 DATE형식간의 범위에서도 BETWEEN AND 연산자와 대소비교연산자를 사용할수있다
-- 입사일이 90/1/1 - 03/1/1 인 사원들의 모든 컬럼조회
SELECT *
FROM EMPLOYEE
--WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '03/01/01';
WHERE HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';

/*
    <LIKE '패턴'>
    - 비교하고자 하는 컬럼값이 내가 지정한 패턴에 만족하는 경우 조회하는 문법
    [표현법]
    비교대상컬럼 LIKE '패턴';
    
    - 옵션 : 특정패턴 부분에 와일드 카드 옵션을 제시하고 사용할 수 있다.
    '%' : 0글자 이상
        ex) 컬럼 like '문자%' => 문자로 시작하는 컬럼을 조회
                      '%문자' => 문자로 끝나는 칼럼을 조회
                      '%문자%' => 문자가 포함된 칼럼을 조회
    '_' : 1글자
          ex) 칼럼 like '_문자' => 3글자이면서 문자로 끝
                        '__문자' => 4글자이면서...
*/

-- 사원중 성이 "전"씨인 사원들의 이름, 급여,입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- 전화번호 4번째 자리가 9로 시작하는 사원들의 사번,사원명,전화번호를 출력
SELECT EMP_ID, EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- 이메일중 네번째 문자위치에 _가 있는 사원의 모든 정보
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '___\_%' ESCAPE '\';
-- 문자_를 검사에 사용하고 싶다면 이스케이핑 처리를 해야한다.
-- ESCAPE처리를 수행할 문자를 지정하고, _앞에 사용한다.

-- 실습
-- 1. 이름이 '연' 으로 끝나는 사원들의 이름, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';
-- 2. 전화번호 처음 3글자가 010 이 아닌 사원들의 이름, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';
-- 3. DEPARTMENT 테이블에서 해외영업과 관련된 부서들의 모든 컬럼 조회
SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '%해외영업%';

/*
    <IS NULL>
    - 해당 값이 NULL 인지 비교하는 NULL 전용 비교연산자
    
    [표현법]
    비교대상칼럼 IS NULL => 칼럼값이 NULL인 경우 참
    비교대상칼럼 IS NOT NULL => 칼럼값이 NULL이 아닌경우 참
*/

-- 보너스를 받지 않는 사원의 사번, 이름, 급여 , 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- 사수가 없고, 부서배치도 아직 받지 않은 사원들으 ㅣ모든 칼럼 조회
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL
      AND DEPT_CODE IS NULL;

/*
    <IN>
     - 비교대상 칼럼 값에 내가 제시한 목록들 중 일치하느 값이 있는지 판단하는 연산자.
     
     [표현법]
     비교대상칼럼 IN (값1,값2,값3 ...)
     == (칼럼 = 값1 or 칼럼 = 값2 or 칼럼 = 값3 ...)
*/

-- 부서코드가 d6이거나 d8이거나 d5인 사원들의 이름,부서코드를 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';
WHERE DEPT_CODE IN ( 'D6', 'D8', 'D5' );

/*
    <연결연산자 ||>
     - 여러 칼럼값들을 하나의 칼럼으로 연결시켜주는 연산자
     - 칼럼과 리터럴도 연결이 가능하다.
     - ex) System.out.print("num : " + num);
*/

SELECT EMP_ID
       || EMP_NAME
       || SALARY AS "연결완료"
FROM EMPLOYEE;

-- XXX번 XXX의 월급은 XXX원 입니다.
SELECT EMP_ID
       || '번'
       || EMP_NAME
       || '의 월급은 '
       || SALARY
       || '원 입니다.' AS "급여정보"
FROM EMPLOYEE;

/*
    <연산자 우선순위>
    0. ()
    1. 산술연산자( + , - , * , / ..)
    2. 연결연산자( || )
    3. 비교연산자( > , < , = , != ..)
    4. IS NULL, LIKE , IN
    5. BETWEEN A AND B
    6. NOT
    7. AND
    8. OR
*/

/*
    <ORDER BY 절>
     - SELECT문 가장 마지막에 기입하는 구문이며, 실제로 가장 마지막으로 실행되는 구문
     - 최종 조회된 RESULTSET에 대한 정렬기준을 세워주는 구문
     
     [표현법]
     SELECT 칼럼1, 칼럼2 ...
     FROM 테이블명
     WHERE 조건식
     ORDER BY [컬럼명/별칭/컬럼순번] [ASC/DESC] [NULLS FIRST/NULLS LAST];
*/

-- 월급이 높은사람부터 나열하고 싶다(월급기준 내림차순)
SELECT *
FROM EMPLOYEE
ORDER BY SALARY DESC; -- 생략이 ASC가 기본값

-- 보너스 기준 정렬
-- ORACLE 에서는 정렬시 NULL 값을 가장 큰 값으로 생각한다
SELECT *
FROM EMPLOYEE
--ORDER BY BONUS; -- ASC(오름차순) & NULLS LAST: 기본값)
--ORDER BY BONUS ASC NULLS FIRST;
ORDER BY BONUS DESC; -- DESC(내림차순) NULLS FIRST 기본값

-- 연봉 순서대로 정렬하기
SELECT EMP_NAME, SALARY, SALARY * 12 AS "연봉" 
FROM EMPLOYEE
--ORDER BY SALARY * 12 DESC;
--ORDER BY "연봉" DESC;
ORDER BY 3 DESC;