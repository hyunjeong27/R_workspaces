# 기초문법 문제 - 자료형 확인하기
x = 42
y = "R 프로그래밍"
z = TRUE
typeof(x)
typeof(y)
typeof(z)

# 기초문법 문제 - 벡터의 요소 선택
numbers = c(10, 15, 20, 25, 30, 35)
than_20 <- numbers[numbers > 20]
than_20

# 데이터프레임 기초문제
people = data.frame(
  name = c("Alice", "Bob", "Charlie", "Diana"),
  age = c(25, 35, 30, 28),
  gender = c("여", "남", "남", "여")
)

head(people, 5) # 상위 5개 행 출력
dim(people) # 행과 열의 개수 출력
colnames(people) # 전체 컬럼 출력
people[3,3] # 3번째 컬럼의 3번째 값
tail(people, 3) # 마지막 3개 행 출력

people$weight = c(52, 77, 81, 46)
people # 새로운 컬럼 추가

age_30 <- people[people$age >= 30]
age_30 # 나이가 30 이상인 사람들만 출력

a <- people[,c('name','age')]
a # name , age 두개의 컬럼으로 구성된 새로운 데이터 프레임을 정의

# 데이터프레임 응용 문제
emp = data.frame(
  EMPNO = c(7369, 7499, 7521, 7566, 7698, 7782, 7788, 7839, 7844, 7900),
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