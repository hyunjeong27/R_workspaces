# R 디렉토리 변경
setwd('D:/r-data')
print(list.files())

# CSV (엑셀) 파일 불러오기
data = read.csv('student_data.csv')
data

# 각 과목 (Math, Science, English)의 평균 점수 계산
# mean
mean(data$Math)
mean(data$Science)
mean(data$English)

# 컴퓨터 총합 출력 (결측값 제거o)
# na.rm = TRUE
sum(data$Computer, na.rm = TRUE)

# 영어 표준편차 구하기
sd(data$English) # 영어 값들이 평균으로부터 +- 4.9만큼 퍼져있다는 것을 의미

# 과학 중앙값 구하기
median(data$Science)

# 수학 사분위수 구하기
quantile(data$Math)

# 수학 과목의 최댓값, 최솟값 출력
max(data$Math)
min(data$Math)

# table
print(table(data$English)) # 점수별 인원 통계

# 데이터프레임 기초 통계랑 전체 확인
# summary : 각 컬럼(열)별 기본 통계 확인
summary(data)