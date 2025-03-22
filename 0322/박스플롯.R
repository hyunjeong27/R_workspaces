### 박스플롯 (Box-plot)
# 데이터 분포를 시각적으로 나타내는 그래프
# 데이터의 '최솟값, 최댓값, 1사분위수, 중앙값 등 요약 통계치를 나타냄
# 예) 학생들의 시험 성적을 분석할 때 -> 각 반 / 학년별 성적 분포 비교, 제조업에서 생산 공정 데이터 분석할 때 -> 각 기계의 출력 값이 정상 범위를 벗어나는지 확인

# 나이 별 소득 박스플롯으로 표현하기
library(ggplot2)
library(dplyr)

people = read.csv("age_income.csv")
people

people = people %>%
  mutate(ageg = ifelse(age < 30, 'young',
                       ifelse(age <= 59, "middle", "old")))
people

# 연령대 별 income 평균
avg_income = people %>%
  filter(!is.na(income)) %>% # 결측값이 아니라면!
  group_by(ageg) %>%
  summarise(mean_income = mean(income))

# 박스플롯 생성
p = ggplot(data = people, aes(x = ageg,
                                  y = income,
                                  fill = ageg)) +
  geom_boxplot() + # 박스플롯 생성
  labs(title = "연령대 별 수입 분포",
       x = "연령대",
       y = "수입") +
    scale_x_discrete(
      limits = c("young", "middle", "old")
    ) + # discrete : x 축 분리
    theme_minimal() # 뒤 회색 배경 제거
p 
