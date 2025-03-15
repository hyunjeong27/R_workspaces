# 데이터스케일링 *****
# `데이터 분석` 및 `머신러닝`에서 중요한 전처리 과정
# 변수의 크기를 조정하여 성능을 향상 시키거나, 결과를 해석하기 쉽게 만든다.

# Min-Max 정규화
# 데이터 스케일링 방법 중 하나 (대표적인) 이다.
# Min-Max : 데이터를 0에서 1 사이로 변환하는 데이터 전처리 기법

# 예제 데이터 프레임
data = data.frame(
  height = c(150, 160, 170, 180, 190),
  weight = c(50, 60, 70, 80, 90)
)
data

# 키와 몸무게는 단위와 범위가 다르기 때문에 두 데이터를 그대로 비교/분석하기 어렵다.
# 이를 해결하기 위해 키와 몸무게를 0~1 사이로 스케일링하면 두 변수는 동일한 기준에서 비교할 수 있다.

# 암기 ***
# 스케일링 값 = (기존 값 - 최솟값) / (최댓값 - 최솟값)

heigh_min = min(data$height)
heigh_max = max(data$height)

data$scaled_height = (data$height - heigh_min) / (heigh_max - heigh_min)

weigh_min = min(data$weight)
weigh_max = max(data$weight)
data$scaled_weight = (data$weight - weigh_min) / (weigh_max - weigh_min)

# emp 데이터에서 급여(SAL) 열에 대해 Min-Max 정규화를 수행하시오.
# 이후 디플리알로 0.5보다 큰 값을 가지는 데이터를 추출하시오.
emp <- read.csv("emp.csv")

emp <- emp %>%
  mutate(SAL_normalized = (SAL - min(SAL)) / (max(SAL) - min(SAL)))

filtered_emp <- emp %>%
  filter(SAL_normalized > 0.5)

filtered_emp
