# 가장 중요한 부분
# 데이터 분석 80~90 필터링 (전처리)
# 필터링 : 쓸모없는 데이터 거르기
# 1. subset
# 2. dplyr ***

## subset (부분 집합)
# 특정 조건에 맞는 데이터를 추출하여 새로운 부분 집합을 만드는 기능, 기본 제공
# dplyr 설치 필요 o

emp = read.csv('emp.csv')
emp

# 급여 3000 이상 받는 사원만 조회
high_sal = subset(emp, SAL >= 3000)
high_sal

# and / or 연산자를 이용한 여러 조건 결합
# 급여 3000 이상, 부서 번호 20번인 직원만 출력
emp_deptno20 = subset(emp, SAL >= 3000 & DEPTNO == 20)
emp_deptno20

# 급여 2000 이상인 직원의 이름, 입사 날짜, 직책 출력
emp_sal2000 = subset(emp, SAL >= 2000, select = c(ENAME, JOB, SAL))
emp_sal2000

# dplyr 설치
install.packages("dplyr")

# dplyr > 스크립트 창으로 가져오기
# 로드(임포트)
library(dplyr)

# dplyr ***** 중요
# 1. filter : 조건에 맞는 행 조회
# 2. select : 특정 컬럼(열) 선택
# 3. mutate : 새로운 컬럼 추가
# 4. arrange : 행 정렬
# 5. group by : 데이터 그룹화
# 6. summarise : 통계 계산
# 7. join : 여러 데이터 프레임 병합
# 8. slice : 특정 행 선택

# dplyr : data frame plier (공구) > 데이터 프레임을 다루는 공구

# filter
# 행을 조건에 따라 필터링
# 급여 3000 이상인 직원 조회
high_salary = emp %>% filter(SAL >= 3000)
high_salary

# 급여 3000 이상, 부서 번호 20번인 사원 조회
high_salary_20 = emp %>% filter(SAL >= 3000 & DEPTNO == 20)
high_salary_20

# 부서번호 20번, 직책 manager인 사원 조회
deptno20_manager = emp %>% filter(JOB == "MANAGER" & DEPTNO == 20)
deptno20_manager

# 급여 2000 미만, 부서 번호 20번인 사원 조회
row_sal_20 = emp %>% filter(SAL < 2000 & DEPTNO == 20)
row_sal_20
# 이때, 사원 이름과 부서 번호만 조회
row_sal_20 = emp %>% filter(SAL < 2000 & DEPTNO == 20) %>% select(ENAME, DEPTNO)

# 직책이 SALESMAN인 사원의 이름, 직책, 입사 날짜 조회
emp %>% filter(JOB == "SALESMAN") %>% select(ENAME, DEPTNO, HIREDATE)

# mutate()
# 새로운 컬럼(열) 추가
# 급여와 커미션의 합계를 새로운 열 생성 (#TOTAL_COM) 후 추가
emp_comm = emp %>% mutate(TOTAL_COM = SAL + 
                            ifelse(is.na(COMM), 0, COMM)) # is.na : na 값인지?
# ifelse(is.na(COMM), 0, COMM)) :
# comm이 na면 0, 아니면 comm
emp_comm

# arrange()
# 정렬
# 급여 기준 오름차순
sorted_by_sal = emp %>% arrange(SAL)
sorted_by_sal

# 급여 기준 내림차순
# desc(Descending) : 내림차순
sorted_by_sal = emp %>% arrange(desc(SAL))
sorted_by_sal

# 문제1. 직원 이름(ENAME), 직업(JOB), 그리고 부서 번호(DEPTNO) 열만 선택하세요.

# 문제2. 급여(SAL)가 2000 이상인 직원만 필터링하세요.
emp %>% filter(SAL >= 2000)

# 문제3. 급여(SAL)를 기준으로 내림차순으로 정렬하세요.
emp %>% arrange(desc(SAL))

# 문제4. 부서 번호(DEPTNO)가 30인 직원 중, 이름(ENAME)과 급여(SAL)만 선택하고 급여 순으로 내림차순 정렬하세요.
# 문제5. 직업(JOB)이 "MANAGER"인 직원 중, 부서 번호(DEPTNO)와 급여(SAL)를 선택하고 급여 순으로 오름차순 정렬하세요.
# 문제6. 급여(SAL)가 1500 이상이고 부서 번호(DEPTNO)가 20인 직원의 이름(ENAME), 직업(JOB), 그리고 급여(SAL)를 선택한 뒤 이름 순으로 정렬(오름차순)하세요.
# 문제7.  직업(JOB)이 "SALESMAN"인 직원 중, 급여(SAL)가 1500 이상인 직원의 이름(ENAME), 급여(SAL), 부서 번호(DEPTNO)를 선택하고 급여 순으로 내림차순 정렬하세요.
# 문제 8. 부서 번호(DEPTNO)가 10 또는 30인 직원 중, 이름(ENAME), 직업(JOB), 급여(SAL)을 선택하고 이름 순으로 정렬하세요.
# 문제 9. mutate()를 사용하여 급여(SAL)에 보너스(COMM, NA는 0으로 간주)를 더한 총 급여(Total_Salary) 열을 추가하세요.
