library(dplyr) # 로드

emp = read.csv('emp.csv') # 파일 불러오기
# group by + summarise
# group by
# 특정 열(컬럼)을 묶어 그룹화한다.
emp %>% group_by(job)

# R에 group by는 summarise, mutate, filter 등의 기능과 함께 사용하여 그룹별로 계산을 진행한다.

# 부서별 평균 급여 계산
# summarise : 요약하다.
emp %>% group_by(DEPTNO) %>% summarise(AVG_SAL = mean(SAL))

#  직업별 평균 급여 계산
emp %>% group_by(JOB) %>% summarise(AVG_SAL = mean(SAL))
# 내림차순 정렬 시 : %>% arrange(desc(AVG_SAL))

# 직업별 직원 수 계산
emp %>% group_by(JOB) %>% summarise(EMP_COUNT = n()) # n() : 행 개수
# 내림차순 정렬 시 : %>% arranage(desc(EMP_COUNT))


## csv 파일 2개 이용하기
emp = read.csv('emp.csv')
dept = read.csv('dept.csv')

# 두 데이터 프레임 병합하기
# 교집합 칼럼을 이용한 데이터 병합 (join)
emp_with_dept = emp %>% inner_join(dept, by = "DEPTNO")

# 40번 부서인 운영팀도 출력하기
# left_join *****
dept %>% left_join(emp, by = "DEPTNO") # dept %>% left_join : 왼쪽에 있는 데이터프레임 데이터를 모두 병합 (교집합 이외에도)

# full_join(합집합) 모두 병합
 full_join(emp, dept, by = "DEPTNO")
 
# 근무지가 "DALLAS"인 직원들의 '이름' 출력하기
result = emp %>% #DALLAS 라는 컬럼이 없기 때문에 조인부터 
  inner_join(dept, by = "DEPTNO") %>%
  filter(LOC == "DALLAS") %>%
  select(ENAME, LOC)

# Slice : 특정 위치 조회
emp %>% slice(2, 4)

# 부서별(group by) 최대 연봉 사원 조회
mp %>% group_by(DEPTNO) %>% slice_max(SAL, n = 1)
 
 
## 날짜/시간 데이터 처리
# 문자열 데이터 처리
# as.Date
# difftime
# format *****

dates = c('2025-03-08', '2025-03-01', '2025-01-01')
# 컴퓨터는 위에 벡터를 문자로 인식함
as.Date(dates)
dates = as.Date(dates)
str(dates)

# 오늘 날짜 조회
today = Sys.Date() # Sys : 시스템
today

# 오늘 날짜와 각 날짜의 차이를 계산
today - dates

# 각 날짜에 일수 더하기 
dates + 7

# 날짜 포맷 변경
format(dates, '%Y년 %m월 %d일')

# 두 날짜 간의 차이 계산
h = as.Date('2025-01-02') # 입사 날짜
c = as.Date('2025-02-13') # 특정 날짜

# 근속일 계산
# units = 'mins' : 두 날짜 간의 분
# units = 'hours' : 두 날짜 간의 시간
# units = 'weeks' : 두 날짜 간의 주
days = difftime(c, h, units = 'weeks')
days

# 특정 기간에 고용된 직원 조회
# 81년 01월 01일 ~ 81년 12월 31일 사이에 입사한 직원

emp %>% filter(HIREDATE >= as.Date('1981-01-01') & HIREDATE >= as.Date('1981-12-31'))

# 월별 고용된 사원 수 집계
# group by

# 월 추출
emp$HIRE_MONTH = format(as.Date(emp$HIREDATE), '%Y-%m')
month_hire = emp %>% group_by(HIRE_MONTH) %>% summarise(EMP_COUNT = n())
month_hire

# 문자열 데이터 처리 **********
# substr() : 특정 위치의 문자열 조회
# strsplit() : 특정 구분자를 기준으로 나눔
# gsub() : 다른 문자로 대체

text = "안녕하세요, 곧 점심 시간 입니다."
result = substr(text, 1, 5) # text를 1번째부터 5번째까지만 추출

text = "오늘 점심은 라볶이, 돈가스, 햄버거 입니다."
result = strsplit(text, split = ',')

# 실무에서 자주 사용됨 *****
phone = '010-5555-3333' # 문자에 기호 붙어 있으면 분석하기 까다로움
strsplit(phone, split = '-')

# 단어 대체
text = "고양이가 방에서 놀고 있어요."
gsub("고양이", "강아지", text) # 고양이 -> 강아지로 변환

# 실무 예제
text = "사과12312312"
# 숫자 제거
# [0-9]+ : 정규표현식 (암기 X)
gsub("[0-9]+", "", text)

# emp에서 사원이름 첫 두 글자만 추출
# mutate 새로운 컬럼 생성
emp %>% mutate(ENAME_SHORT = substr(ENAME, 1, 2))

# mutate 입사년도 컬럼 추가하기 (substr 이용)
emp = emp %>% mutate(HIRE_YEAR = substr(HIREDATE, 1, 4))
emp


## 데이터 스케일링, 데이터 이상치 제거 (5회차 때 진행)


# 커미션(COMM)이 결측치가 아닌 직원 중 부서 별 평균 커미션과 최대 커미션 알아내기
# filter() > !is.na > group by + summarise (set) > mean > max
result = emp %>%
  filter(!is.na(COMM)) %>%  # COMM이 결측치가 아닌 데이터만 필터링
  group_by(DEPTNO) %>%  # 부서별 그룹화
  summarise(
    avg_comm = mean(COMM),  # 부서별 평균 커미션
    max_comm = max(COMM)    # 부서별 최대 커미션
  )

# 직업(JOB)이 MANAGER인 사원 필터링 후, 부서번호 별 총 급여 합계 조회
# filter() > group by + summarise > sum
result = emp %>%
  filter(JOB == "MANAGER") %>%  # 직업이 MANAGER인 사원 필터링
  group_by(DEPTNO) %>%  # 부서번호별 그룹화
  summarise(total_salary = sum(SAL))  # 총 급여 합계 계산