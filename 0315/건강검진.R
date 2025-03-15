# 라이브러리 로드와 csv파일 불러오기
# 문제 1: dplyr 패키지를 로드해주세요.
library(dplyr)

# 문제 2: csv 파일을 불러오세요.
health = read.csv('health.csv', fileEncoding = "CP949")
health

# 데이터프레임 출력하기
# 문제 1: 데이터프레임의 앞부분 출력 단, 2행만
head(health, 2)

# 문제 2: 데이터프레임의 뒷부분 출력 단, 5행만
tail(health, 5)

# 문제 3: 데이터프레임의 구조 확인
str(health)

# Select
# 문제 1: 데이터셋에서 성별, 연령대, 그리고 지역 열만 선택하세요.
health %>%
  select(성별, 연령대코드.5세단위., 시도코드)

# Filter
# 문제 2: 2022년에 건강검진을 받은 사람들만 필터링하세요.
filtered_data <- health %>%
  filter(기준년도 == 2022)
filtered_data

# Mutate
# 문제 3: 키(height)와 몸무게(weight) 열을 사용하여 새로운 열 BMI를 추가하세요.
health <- health %>%
  mutate(BMI = 체중.5kg단위. / ((신장.5cm단위. / 100) ^ 2))
health

# Arrange
# 문제 4: 건강검진 결과를 기준으로 혈압 값을 내림차순으로 정렬하세요.
sorted_health <- health %>%
  arrange(desc(blood_pressure))

# Group_by& Summarise
# 문제 5: 성별(성별)로 데이터를 그룹화하고, 각 그룹별 평균 BMI를 계산하세요. 결과는 성별과 평균_BMI 열로 구성되어야 합니다.
average_bmi_by_gender <- health %>%
  group_by(성별) %>%
  summarise(average_BMI = mean(BMI, na.rm = TRUE))
average_bmi_by_gender

# 문제: 연령대별 평균 체중 계산
health %>%
  group_by(연령대코드.5세단위.) %>%
  summarise(평균체중 = mean(체중.5kg단위., na.rm = TRUE))

# 문제: 시도 코드별로 평균 신장(5cm 단위)을 계산 후, 가장 높은 신장을 가진 시도 코드를 추출하시오.
avg_by_region = health %>%
  group_by(시도코드) %>%
  summarise(평균신장 = mean(신장.5cm단위., na.rm = TRUE)) %>%
  arrange(desc(평균신장)) %>%
  slice_head(n = 1)
avg_by_region

# 음주 여부에 따른 체중과 허리둘레의 상관관계를 추출하시오.
# cor : correlation (상관관계)
# use = "complete.obs" : 상관계수 계산 시, 결측값이 포함된 데이터는 제외한다.
drinking = health %>% 
  group_by(음주여부) %>%
  summarise(상관계수 = cor(체중.5kg단위., 허리둘레, use = "complete.obs"))
drinking
# 1은 true : 술 0 / 0은 false : 술 x
# 상관계수는 보통 -1에서 1까지의 값을 가지고, 1에 가까울수록 완벽한 선형관계를 가짐, 즉 한 변수가 증가하면 다른 변수도 증가함
# 반대로 -1에 가까우면 한 변수가 증가할 때, 다른 변수는 감소함
# 0 : 관계 없음

# 문제: 연령대 코드가 10 이하, 행 개수를 추출하시오.
health %>%
  filter(연령대코드.5세단위. <= 10) %>%
  nrow()