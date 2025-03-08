# CSV (Comma-Separated Values)
# CSV -> 콤마로 구성된 데이터 (매우 많이 사용됨)
# CSV 파일 장점: 광범위한 호환성 (R, Python, C, C++)
# CSV <-- 데이터 프레임 <-- 분석 후 시각화

# R 저장, 불러오는 파일 경로 수정
setwd('D:/r-data'); # D 드라이브 > r-data 폴더로 경로 수정
list.files() # 현재 경로에 있는 파일 목록 출력

# 엑셀(csv)파일 불러오기
emp = read.csv('emp.csv') # 엑셀 불러오기
emp

# 퀴즈 > 1~5행 출력, 아래 3행 출력, 행렬 수 확인
head(emp, 5)
tail(emp, 3)
dim(emp)
str(emp)

# 데이터 형 변환
# 문자 -> 숫자 변환
num = c('100', '200', '300')
num = as.numeric(num)
num = num * 2
num

# 숫자 -> 문자 변환
num2 = c(100, 200, 300)
num2 = as.character(num2)
num2

# 날짜형으로 변환 (날짜 관련 계산에 사용)
str(emp)
# 문자형 -> 날짜형 변환
emp$HIREDATE = as.Date(emp$HIREDATE)
str(emp)

# 형변환 연습
data = data.frame(
  product_number = c('A001', 'A002', 'A003'),
  product_name = c('Skin', 'Suncreen', 'Lipstick'),
  price = c('15000$', '22000$', '18000$')
)

# 데이터 프레임 엑셀로 저장
write.csv(data, file="화장품.csv", row.names = FALSE)
str(data)
# 1. '$' 기호 없애기
data$price = gsub('\\$', "", data$price) # $ -> "" 변경
data
# 2. 문자 -> 숫자로 변환
# price를 문자에서 숫자로 변환 후 str로 최종 확인
data$price = as.numeric(data$price)
str(data)
# 3. 계산(총합)
print('제품 총합 : ')
sum(data$price) # sum : 총합 구하기

# 총합, 평균, 최솟/최댓값 구하기
# emp 데이터 > 전체 사원 총 급여
sum(emp$SAL)
# 사원 급여 평균
result = mean(emp$SAL)
result
# 사원 중 가장 많은 급여를 반는 사람의 급여 조회 (최댓값)
max(emp$SAL)
cat("최댓값 : ", result, "\n")
# 사원 중 가장 적은 급여를 반는 사람의 급여 조회 (최솟값)
result2 = min(emp$SAL)
cat("최솟값 : ", result2, "\n")

# 다중 컬럼의 합, 평균 구하기
# 급여(SAL)와 커미션(COMM) 합, 평균 구하기
total_sum = colSums(emp[,c("SAL","COMM")]) # col(컬럼)Sums(여러 컬럼 더하기)
total_sum # 보너스 출력X
# 결측값: 관측/측정에 실패한 값
# 즉, NA를 제거 후 총합을 구해야 보너스까지 계산 됨
total_sum = colSums(emp[,c("SAL","COMM")], na.rm = TRUE) # na.rm = TRUE: 결측값 제거
total_sum

# 퀴즈 > 사원의 급여, 커미션 평균 계산, 단 NA는 제외
total_mean = colMeans(emp[,c("SAL","COMM")], na.rm = TRUE)
total_mean

# 단일 컬럼 COMM, 총합 구하기. 단, 결측값 제거
# 결측값 제거: na.omit()
comm = sum(na.omit(emp$COMM))
cat("COMM  총합 : ", comm, "\n")

# 중앙값, 표준편차 구하기
# 표준편차: 데이터가 평균으로부터 얼마나 퍼져 있는지를 나타내는 통계적 지표
# ex) 한 반 수학 점수가 78~82점인 경우, 평균 점수가 80이면 표준 편차는 작은 편, 60~100점인 경우 표준 편차는 큰 편

# 급여 표준 편차 구하기
# R은 sd() => Standard Deviation
sal_sd = sd(emp$SAL) # 급여 표준편차
cat('급여 표준편차 : ', sal_sd, '\n')
# 즉, 급여 값들이 평균으로부터 약 +- 1267.568만큼 퍼져 있는 것을 의미함

# 중앙값
sal_median= median(emp$SAL)
sal_median
cat('급여 중앙값 : ', sal_median, '\n')

# 최빈값, 분위수
# 최빈값: 데이터가 가장 많이 몰려있는 위치 값
# 분위수: 데이터를 크기 순으로 정렬 후 특정 비율에 해당하는 값을 보여줌

# JOB 최빈값 구하기
# table
print(table(emp$JOB)) # job별 몇명인지 출력
# which.max
x = c(10,23,100,1,5) # 숫자형 벡터 생성
which.max(x) # 벡터에서 최댓값의 위치 출력
job = names(which.max(table(emp$JOB)))
cat('job 최빈값은 : ', job)

# 퀴즈: 부서 번호의 최빈값 구하기
print(table(emp$DEPTNO))
deptno = names(which.max(table(emp$DEPTNO)))
cat('deptno 최빈값은 : ', deptno)
# 값이 동일하면 which.max 때문에 30은 조회 불가능

# 분위수
# 급여 분위수 알아내기
sal = quantile(emp$SAL)
sal

# 특정 분위수 구하기 (하위 10%, 상위 90%)
sal = quantile(emp$SAL, probs = c(0.1, 0.9))
sal
# 0% 최솟값, 50% 중앙값, 100% 최댓값

# 결측치를 제거한 급여 평균 구하기
comm = sd(emp$SAL, na.rm = TRUE)
cat('결측치를 제거한 COMM 표준편차 : ', comm, '\n')
# 결측치를 제거한 급여 총합 구하기

# 결측치를 제거한 COMM 표준 편차 구하기