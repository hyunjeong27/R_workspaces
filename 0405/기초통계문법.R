# R에서 자주 사용하는 통계

# 벡터 생성
data = c(10, 20, 30, 40, 50)

# 평균 계산
avg = mean(dataa)
cat('평균 : ', avg, '\n')

# 중앙값 계산
middle = median(data)
cat('중앙값 : ', middle, '\n')

# 최빈값 계산
# 데이터가 가장 많이 분포 되어 있는 값
data = c(10, 20, 20, 20, 20, 30, 40, 50)
install.packages('DescTools') # 최빈값 구해주는 기능
library(DescTools)

# 최빈값
value = Mode(data)
cat('최빈값 : ', value, '\n')

# 표준편차
# 데이터가 평균에서 얼마나 흩어져 있는지를 나타내는 통계적 척도
# 표준편차는 데이터의 흩어짐을 원래 데이터 단위로 표현
standard_de - sdd(data)
cat('표준편차 : ', standard_de, '\n')

# 분산
# 평균에서 얼마나 흩어져 있는지를 나타내는 통계적 척도
# 분산은 제곱된 단위
# 왜 제곱된 단위? : 모든 값을 양수로 만들어 합산하기 위해 (음수 상쇄)
# 절대값은 미분 불가능, 제곱은 미분과 같은 수학적 조작이 가능해 통계 이론 전개에 유리함
variance = var(data)
cat('분산 : ', variance, '\n')

# 표준오차
# 모집단에서 전체를 조사하지 않고, 표본으로 선택해 조사했을 때 발생하는 오차
# ex. 전교생 1000명(모집단), 이 학교에 평균 키를 알고 싶음
# 시간이 부족해서 일부 50명만 랜덤하게 키를 조사했다고 가정
# 이 50명 평균 키가 모집단 평균 키와 다를 가능성이 있음

# 임시 데이터 만들기
# rnorm : 임시 데이터 만들기
people = rnorm(1000, mean = 170, sd = 10) # 1000명 평균 키 170, 표준편차 10

# 모집단 평균과 표준편차를 계산
people_mean = mean(people) # 평균
people_sd = sd(people) # 표준편차

# 표본 추출 (50명)
sample_size = 50

# 표본오차 계산
# sqrt : square root : 제곱근
sem = people_sd / sqrt(sample_size)
cat('표준 오차 : ', sem, '\n')
