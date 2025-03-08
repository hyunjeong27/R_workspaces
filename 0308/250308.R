ID = c(1, 2, 3),
Name = c('Brain', 'Bob', 'Jose')

# 출력
df

print(df$Name) # 특정 열을 가져와서 값을 더한 후
df$ID2 = df$ID + 1
# 새로운 열에 추가함
df$ID2

# 결측치 'NA'로 표기
# 예제 데이터 생성
data = c(1, 2, NA, 4, NA, 6)

# 결측치 확인
is.na(data)
# na가 있으면 true, 없으면 false

# 결측치 확인 - ! > 반대로 출력
!is.na(data)
# # na가 없으면 true, 있으면 false