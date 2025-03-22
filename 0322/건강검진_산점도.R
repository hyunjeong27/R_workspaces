# 퀴즈

# 건강검진 csv 파일을 사용해서 신장 - 몸무게 관계를 산점도 그래프로 표현하기
# x축 : 신장, y축 : 체중
# 회귀선 추가

library(dplyr)
health = read.csv('health.csv', fileEncoding = "CP949", encoding = "UTF-8", check.names = FALSE)
health

ggplot(data = health, aes(x = 신장.5cm단위., y = 체중.5kg단위.)) +
  geom_point() +
  geom_smooth(method = "lm", color = "red") + # 회귀선 추가
  labs(title = "신장 - 체중 관계",
       x = "신장(cm)",
       y = "체중(kg)")

# 혈색소 vs BMI 관계 파악하기
# 혈색소가 높으면 세모, 그 외는 동그라미 표시 (*높으면 심장마비, 뇌졸증 발생할 가능성 높음)
# 남자 / 여자 구분
# BMI 구하기 (체중 / (신장/100)^2)
# 디플리알 이용해서 전처리 작업 하기

# mutate로 BMI 구하기
library(dplyr)

# 전처리 작업: BMI 계산 및 혈색소와 성별 기준으로 분류
health_data2 = health %>%
  mutate(BMI = `체중.5kg단위.` / (`신장.5cm단위.` / 100) ^ 2,  # BMI 계산 (kg/m^2)
         Grade = ifelse(혈색소 >= 16, "High", "Normal"),  # 혈색소 16 이상은 High로 구분
         Gender = ifelse(성별 == 1, "Male", "Female"))  # 성별 1이면 남성, 그 외는 여성
health_data2

# 전처리 끝났으면 그래프로 표현하기
p = ggplot(data = health_data2, aes(x = 혈색소, y = BMI)) +
  geom_point(aes(color = Gender, shape = Grade), size = 1.5) +
  scale_color_manual(values = c("Male" = "blue", "Female" = "red")) +
  scale_shape_manual(values = c("High" = 17, "Normal" = 16)) +
  geom_smooth(method = "lm", color = "orange") +
  labs(title = "BMI와 혈색소 관계",
       x = "혈색소",
       y = "BMI",
       color = "Gender",
       shape = "Grade") +
  theme_minimal() # 뒤에 회색 배경 제거
p

# 퀴즈
# 연령코드가 5~8번이고, 지역코드가 41번인 사람의 허리 둘레와 식전혈당(공복혈당) 관계를 그래프 표현하기
# 식전혈당(공복혈당) x축, 허리둘레 y축
# 단, 남성은 파란색, 여성은 빨간색 표기
# 식전혈당(공복혈당) 100 이상은 별 모양(11번)으로 표기하고, 그 외 동그라미로 표기
# pdf로 변환 후 저장까지

# 데이터 전처리
health_filtered <- health %>%
  filter(`연령대코드.5세단위.` >= 5 & `연령대코드.5세단위.` <= 8, 
         `시도코드` == 41)

# 그래프 생성
p <- ggplot(health_filtered, aes(x = `식전혈당.공복혈당.`, y = `허리둘레`, color = factor(성별))) +
  geom_point(aes(shape = factor(ifelse(`식전혈당.공복혈당.` >= 100, 11, 16))), size = 3) +  # shape에 범주형 데이터로 변환
  scale_shape_manual(values = c(16, 11)) +  # 동그라미(16)과 별(11) 모양 지정
  scale_color_manual(values = c("blue", "red")) +  # 남성은 파란색, 여성은 빨간색
  labs(title = "허리둘레와 식전혈당(공복혈당) 관계",
       x = "식전혈당(공복혈당)",  # 축 레이블
       y = "허리둘레",
       color = "성별",
       shape = "식전혈당(공복혈당) 100 이상") +
  theme_minimal()

p

# 그래프를 PDF로 저장
pdf.options(family = "Korea1deb")
ggsave("허리둘레_식전혈당 관계.pdf")
