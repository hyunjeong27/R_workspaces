library(dplyr)

netflixs = read.csv('netflix.csv')
netflixs

## 데이터프레임 출력하기
# 문제 1: 데이터프레임의 앞부분 출력 단, 2행만
head(netflixs, 2)

# 문제 2: 데이터프레임의 뒷부분 출력 단, 5행만
tail(netflixs, 5)

# 문제 3: 데이터프레임의 구조 확인
str(netflixs)

# 문제 4: 특정 열 title 선택하기
netflixs %>%
  select(title)

## select
# 문제 3: 데이터셋에서 title, type, release_year 열만 선택하세요.
netflixs %>%
  select(title, type, release_year)

# 문제 4: 데이터셋에서 title, country, rating 열만 선택하세요.
netflixs %>%
  select(title, country, rating)

## filter
# 문제 5: 2021년에 출시된 영화만 필터링하세요.
netflixs %>%
  filter(release_year == 2021)

# 문제 6: TV-MA 등급의 TV 프로그램만 필터링하세요.
netflixs %>%
  filter(rating == 'TV-MA')

## Select& Filter
# 문제 7: director가 "Mike Flanagan"인 영화의 title, director, country 열을 선택하세요.
netflixs %>%
  filter(director == "Mike Flanagan") %>%
  select(title, director, country)

## mutate
# 문제 8: duration 열에서 영화의 길이가 분 단위로 제공됩니다. 영화(type == "Movie")의 경우, duration 값을 숫자형 데이터로 변환하고 새로운 열 duration_minutes를 추가하세요.
netflixs %>%
  filter(type == "Movie") %>%
  mutate(duration_minutes = as.numeric(gsub(" min", "", duration)))

## arrange
# 문제 9: 영화(type == "Movie")를 기준으로, release_year(출시 연도)를 내림차순으로 정렬하세요.
netflixs %>%
  filter(type == "Movie") %>%
  arrange(desc(release_year))

# 문제 10: TV 프로그램(type == "TV Show") 중 시즌 수(duration)를 기준으로 오름차순으로 정렬하세요.
netflixs %>%
  filter(type == "TV Show") %>%
  mutate(duration = as.numeric(gsub(" Season", "", duration))) %>%
  arrange(duration)

## group_by& summarise
# 문제 11: type 열을 기준으로 데이터를 그룹화하고, 각 그룹에 대해 콘텐츠의 총 개수와 평균 release_year를 계산하세요. 결과 데이터프레임은 type, total_count, average_release_year 열을 포함해야 합니다.
netflixs %>%
  group_by(type) %>%
  summarise(
    total_count = n(),  # 각 그룹의 콘텐츠 개수
    average_release_year = mean(release_year, na.rm = TRUE)
  )
