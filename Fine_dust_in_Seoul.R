# Comparative Analysis of Differences in Fine Dust Concentration by Region in Seoul
# 데이터 가공1 - 데이터 전처리는 엑셀을 통해 진행하였습니다. 

# 데이터 가공2 - 필요한 데이터 추출
library(readxl)
dustdata <- read_excel("C:/R_data/dustdata202312.xlsx")

View(dustdata)
str(dustdata)

# 성북구와 중구 데이터만 추출
library(dplyr)
dustdata_anal <- dustdata[, c("날짜", "성북구", "중구")]
View(dustdata_anal)

# 결측치 확인
is.na(dustdata_anal)
sum(is.na(dustdata_anal)) # 결측치 0개인 것을 확인했습니다.

# 데이터 분석 - 데이터 탐색 및 시각화
library(psych) # 다양한 기술 통계량이 확인 가능한 psych 패키지를 로드 했습니다.

describe(dustdata_anal$성북구)
describe(dustdata_anal$중구)

# boxplot 시각화
boxplot(dustdata_anal$성북구, dustdata_anal$중구, 
        main='finedust_compare', xlab='AREA', names=c('성북구', '중구'),
        ylab='FINEDUST_PM', col=c('blue', 'green'))

# 데이터 분석 - 가설 검정
# 귀무 가설과 대립 가설을 전제하였습니다.
# 가설을 입증하기 위해 두 집단 간 평균 차이가 있는지 검정합니다. (f검정, t검정 활용)

# f 검정 - 지역별 미세먼지 농도의 분산 차이 검정
var.test(dustdata_anal$성북구, dustdata_anal$중구)
# p-value 값이 0.9091로 0.05보다 크므로 귀무 가설을 기각할 수 없다. (등분산 가정을 만족)

# t검정 - 지역별 미세먼지 농도의 평균 차이 검정
t.test(dustdata_anal$중구, dustdata_anal$성북구, val.equal=T) # 등분산 가정을 만족하니 val.equal은 T로 설정
# p-value 값이 0.8014로 0.05보다 크기 떄문에 통계적으로 유의하지 않다. 
# 즉, 귀무 가설을 기각할 수 없다. 

# 결론 - 성북구와 중구의 2023년 12월 미세먼지 농도의 평균 차이가 없다는 것을 확인하였다.
