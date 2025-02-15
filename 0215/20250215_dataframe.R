##### 데이터프레임
# 데이터를 '행'과 '열'로 구성한 2차원 구조
# 다양한 데이터 유형을 한 테이블에 저장할 수 있는 자료 구조
# 통계 분석, 데이터 처리, 그래프 시각화에 이용

# 데이터프레임 구조
# 행 : 관측치, 열 : 속성

# 벡터 생성
id = c(1,2,3)
name = c("Alice", "Bob", "CHarlie")
age = c(25, 30, 35)
salary = c(50000, 60000, 70000)
# 데이터프레임 생성
# data.frame()
df = data.frame(id, name, age, salary)
df

## 데이터프레임 조회하는 여러가지 방법
# head(데이터명, 행)
head(df, 1) # 1행 출력
head(df, 2) # 1~2행 출력
head(df) # 뒤에 숫자가 없으면, 1~6행 출력

# 행/열의 개수 : dim()
dim(df)

# 전체 컬럼 조회 : colnames()
colnames(df)

# 마지막 1행 출력 : tail()
tail(df, 1)
# 첫번째 행 출력 : head()
head(df, 1)

View(df) # 다른 화면으로 출력 : view()

## 특정 열 선택
# $ 기호를 사용하면 결과는 벡터 형태로 반환됨
names = df$name # 데이터프레임에서 'name' 열 가져오기
cat('name : ', names, '\n')
ages = df$age
cat('age : ', age, '\n')

## 다수 열 선택
# 이름, 나이만 출력
result = df[,c('name', 'age')]
result
# 아이디, 급여만 출력
result2 = df[,c('id', 'salary')]
result2

## 특정 열값 수정, 추가
# salary 기존 값에 100 더한 후 출력
df$salary = df$salary + 100
df
# age 열값 수정, 추가
df$age = df$age + 1
df

# 데이터프레임에 새로운 열 추가
df$penalty = c('예', '아니오', '예')
df