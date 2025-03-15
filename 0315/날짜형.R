Sys.setlocale("LC_TIME", "C") # 장소 임시 변경

date_str = 'September 24, 2021'
# R은 해당 문자를 바로 날짜형으로 변환할 수 없음.
date_str = as.Date(date_str, format = '%B %d, %Y') # 형식 맞추기
formatted_date = format(date_str, '%Y') # 연도만 출력
date_str_1 = '2025-03-15'
date = as.Date(date_str_1)
formatted_date