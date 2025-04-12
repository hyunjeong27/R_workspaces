# Yahoo Finance API를 사용하여 애플의 주가 데이터를 가져옵니다.
import yfinance as yf

# 애플 주가 데이터 다운로드
data = yf.download('AAPL', start='2024-01-01', end='2025-04-10')
print(data.head())
# 종가(Close), 고가(High), 저가(Low), 시가(Open), 거래량(Volume)



