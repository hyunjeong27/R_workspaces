library(dplyr)
library(ggplot2)

setwd('D:/r-data')
bicycle_data = read.csv('seoul_public_bicycle_data.csv', fileEncoding = 'CP949')
bicycle_data

# 문제
# 1. 대여소 번호별 이용건수 막대그래프 표현 (x축: 대여소번호, y축: 이용건수)
# 2. 정기권을 구매한 이용자 중 연령대 별 평균 운동량 막대 그래프로 표현 # 단, 이용시간(분) 5분 이하는 평균에서 제외 (x축: 연령대, y축: 평균 운동량)
# 3. 연령대코드 별 이용시간과 운동량을 비교하는 산점도 그래프 표현 (x축: 이용시간, y축: 운동량)
# 조건 1. 연령대 별 색깔 (10대 : 노랑(yellow), 20대 : 블루(blue), 30대 : 퍼플(purple), 40대: 초록(green), 50대 : 블랙(black))
# 조건 2. 연령대 별 중 운동량을 스케일링(min-max) 후 0.5 이상인 회원은 세모 표시 (17)

# 1번
bicycle_counts = bicycle_data %>%
  group_by(대여소번호) %>%
  summarise(이용건수 = n())

ggplot(bicycle_counts, aes(x = 대여소번호, y = 이용건수)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "대여소 번호별 이용건수", x = "대여소 번호", y = "이용건수")

# 2번
# 이용시간 5분 이상, 정기권 구매o 만 필터링
bicycle_data_filter = bicycle_data %>%
  filter(이용시간.분. > 5, 대여구분코드 == "정기권")

average_exercise = bicycle_data_filter %>%
  group_by(연령대코드) %>%
  summarise(평균운동량 = mean(운동량, na.rm = TRUE))

ggplot(average_exercise, aes(x = 연령대코드, y = 평균운동량, fill = 연령대코드)) +
  geom_bar(stat = "identity", fill = "pink") +
  labs(title = "연령대 별 평균 운동량", x = "연령대", y = "평균 운동량")

# 3번
colors = c("10대" = "yellow", "20대" = "blue", "30대" = "purple", "40대" = "green", "50대" = "black")

# 운동량 스케일링 (min-max)
bicycle_data = bicycle_data %>%
  mutate(운동량_scaled = (운동량 - min(운동량, na.rm = TRUE)) / (max(운동량, na.rm = TRUE) - min(운동량, na.rm = TRUE)))

# 산점도 그리기
ggplot(bicycle_data, aes(x = 이용시간.분., y = 운동량, color = 연령대코드)) +
  geom_point(aes(shape = ifelse(운동량_scaled > 0.5, 17, 19)), size = 3) +
  scale_color_manual(values = colors) +
  labs(title = "연령대 별 이용시간과 운동량 비교", x = "이용시간(분)", y = "운동량")