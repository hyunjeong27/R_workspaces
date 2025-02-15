# emp 데이터프레임 생성
# empNO : 사원번호
# ENAME : 사원이름
# JOB : 직책
# MGR : 사수번호
# HIREDATE : 입사날짜
# SAL : 급여
# COMM : 보너스
# DEPTNO : 부서번호
emp = data.frame(
  empNO = c(7369, 7499, 7521, 7566, 7698, 7782, 7788, 7839, 7844, 7900),
  ENAME = c("SMITH", "ALLEN", "WARD", "JONES", "BLAKE", "CLARK", "SCOTT", "KING", "TURNER", "ADAMS"),
  JOB = c("CLERK", "SALESMAN", "SALESMAN", "MANAGER", "MANAGER", "MANAGER", "ANALYST", "PRESIDENT", "SALESMAN", "CLERK"),
  MGR = c(7902, 7698, 7698, 7839, 7839, 7839, 7566, NA, 7698, 7788),
  HIREDATE = as.Date(c("1980-12-17", "1981-02-20", "1981-02-22", 
                       "1981-04-02", "1981-05-01", "1981-06-09",
                       "1982-12-09", "1981-11-17", "1981-09-08",
                       "1983-01-12")),
  SAL = c(800, 1600, 1250, 2975, 2850, 2450, 3000, 5000, 1500, 1100),
  COMM = c(NA, 300, 500, NA, NA, NA, NA, NA, NA, NA),
  DEPTNO = c(20, 30, 30, 20, 30, 10, 20, 10, 30, 20)
)
# 데이터 확인
print(emp)

# 특정 열 출력
names = emp$ENAME # 사원이름 출력
names

# 1~6행 출력
head(emp)

# 행/열 개수 출력
dim(emp)

# sal(급여)이 월 2000 이상 받는 사원 필터링
high_salary = emp[emp$SAL >= 2000,]
high_salary

# sal(급여)이 월 2000 이상 받는 사원 이름, 직책 필터링
# [,] : , 왼쪽은 행 / 오른쪽은 열 필터링
high_salary_a = emp[emp$SAL >= 2000, c('ENAME', 'JOB')]
high_salary_a

# 부서 번호가 20번인 사원 이름, 입사 날짜, 직책 필터링
dept_20 = emp[emp$DEPTNO == 20, c('ENAME', 'HIREDATE', 'JOB')]
dept_20

## & 연산자 활용한 데이터프레임 필터링
# 직업이 SALESMAN, 급여 1500 이상인 사원의 이름, 월급 필터링
salesman_1500 = emp[emp$JOB == 'SALESMAN' & emp$SAL >= 1500,
                    c('ENAME', 'SAL')]
salesman_1500


### ***** 결측값 필터링 하기
# is.na : 결측값 여부 판단

# comm 열에 na 가 있으면, 0으로 대체하여 출력
#emp$COMM[is.na(emp$COMM)] = 0 # comm에 na가 있으면 0으로 대입

# 퀴즈 (조건 2개, 결측값 체크)
# 부서번호가 20번이고, 커민션(comm)이 na가 아닌 사원의 이름과 커미션, 입사 날짜를 조회하시오.
result = emp[emp$DEPTNO == 20 & !is.na(emp$COMM),
             c('ENAME', 'COMM', 'HIREDATE')]
result # 20번 부서 사원들은 보너스가 없음..

