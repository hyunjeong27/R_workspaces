library(ggplot2) # 그래프 도구
library(dplyr) # 전처리 도구
library(sf) # 지도 시각화
library(ggiraph) # 지도 시각화 이벤트
#install.packages("sf")
#install.packages("ggiraph")

# 1. 지도 시각화를 구현하기 위해서는 '지도 데이터'
# 지도 데이터? shapefile(shp)이 필요함
# shp 파일은 지리정보시스템에서 사용되는 벡터 데이터 형식으로, 공간 데이터를 저장하고 표현하는데 사용됨\

setwd('D:/r-data')
korea_map = st_read('sig.shp')

# 2. 지도 시각화
p = ggplot(data = korea_map) + geom_sf(fill = "white", color = "black") + # 흰색 채우고, 경계선은 검정색으로
  theme_minimal() + # 뒤 회색 배경 제거
  labs(title = "대한민국 지도",
       x = "경도", y = "위도") +
  coord_sf() # 지도 비율 유지

print(p)