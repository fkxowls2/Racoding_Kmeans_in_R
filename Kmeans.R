#kmeans 함수 직접 만들기
#"코딩은 글쓰기이다"

#데이터 로드
fruits <- data.frame( '재료'=c('사과','베이컨','배','당근','참외','치즈','햄','계란'),
                      '단맛'  = c(10,1,10,7,8,1,2,3),
                      '아삭한맛'=c(9,3,8,10,7,1,1,2),
                      '음식종류'=c('과일','단백질','과일','과일','과일','단백질','단백질','단백질')
)
#군집에 필요한 컬럼만 선택
data <- fruits[,c(2,3)]

#1.데이터중 2개를 랜덤으로 선택한다.
my_kmeans <- function(test, k){
  cluster <- test[sample(nrow(test), k), ]
  print(cluster)
}
set.seed(7)
my_kmeans(data, 2)

#2.선택된 2개의 군집 중앙점의 라벨을 1과 2로 각각 지정하기위해
#kind라는 파생변수를 만든다.
my_kmeans <- function(test, k){
  cluster <- test[sample(nrow(test), k), ]
  cluster$kind <- sample(nrow(cluster))
  print(cluster)
}
set.seed(7)
my_kmeans(data, 2)

#3.거리와 종류(정답)을 저장할 테이블 a를 생성한다.
my_kmeans <- function(test, k){
  cluster <- test[sample(nrow(test), k), ]
  cluster$kind <- sample(nrow(cluster))
  a <- data.frame(test, kind=0, d=9999999)
  print(a)
}
set.seed(7)
my_kmeans(data, 2)

#4.선택한 데이터 2개와 거리를 각각 구한다.
my_kmeans <- function(test, k){
  cluster <- test[sample(nrow(test), k), ]
  cluster$kind <- sample(nrow(cluster))
  a <- data.frame(test, kind=0, d=9999999)
  for (i in 1:nrow(cluster)){
    temp <- t(t(test)-c(t(cluster[i, -ncol(cluster)])))^2
    #cluster[i,-ncol(cluster)]:거리 계산을 위해 kind의 데이터는 제외
    temp <- sqrt(rowSums(temp))
    print(temp)
  }
}
set.seed(7)
my_kmeans(data, 2)

#5.4번에서 구한 거리와 기존 거리와 비교해서 구한 거리가 기존거리보다
#작으면 테이블 a의 거리를 갱신한다.
my_kmeans <- function(test, k){
  cluster <- test[sample(nrow(test), k), ]
  cluster$kind <- sample(nrow(cluster))
  a <- data.frame(test, kind=0, d=9999999)
  for (i in 1:nrow(cluster)){
    #행렬연산을 활용한 거리계산
    temp <- t(t(test)-c(t(cluster[i, -ncol(cluster)])))^2
    #cluster[i,-ncol(cluster)]:거리 계산을 위해 kind의 데이터는 제외
    temp <- sqrt(rowSums(temp))
    a$kind <- ifelse(a$d > temp, cluster$kind[i], a$kind)
    a$d <- ifelse(a$d > temp, temp, a$d)
    print(a)
  }
}
set.seed(7)
my_kmeans(data, 2)

#6.2개로 클러스터링된 컬럼들의 평균값을 각각 구해서 평균점을 찾는다.
my_kmeans <- function(test, k){
  cluster <- test[sample(nrow(test), k), ]
  cluster$kind <- sample(nrow(cluster))
  a <- data.frame(test, kind=0, d=9999999)
  for (i in 1:nrow(cluster)){
    #행렬연산을 활용한 거리계산
    temp <- t(t(test)-c(t(cluster[i, -ncol(cluster)])))^2
    #cluster[i,-ncol(cluster)]:거리 계산을 위해 kind의 데이터는 제외
    temp <- sqrt(rowSums(temp))
    a$kind <- ifelse(a$d > temp, cluster$kind[i], a$kind)
    a$d <- ifelse(a$d > temp, temp, a$d)
  }
  for (i in 1:nrow(cluster)){
    cluster[cluster$kind==i, -ncol(cluster)] <- colMeans(a[a$kind==i, 1:(ncol(a)-2)])
  }
  print(cluster)
}
set.seed(7)
my_kmeans(data, 2)

#7.중심점을 이동후 다시 거리계산을 무한반복하는데 더 이상 중심점이
#변화가 없을때 중단한다.
my_kmeans <- function(test, k){
  cluster <- test[sample(nrow(test), k), ]
  cluster$kind <- sample(nrow(cluster))
  a <- data.frame(test, kind=0, d=9999999)
  while(TRUE){
    t_cluster <- cluster
    for (i in 1:nrow(cluster)){
      #행렬연산을 활용한 거리계산
      temp <- t(t(test)-c(t(cluster[i, -ncol(cluster)])))^2
      #cluster[i,-ncol(cluster)]:거리 계산을 위해 kind의 데이터는 제외
      temp <- sqrt(rowSums(temp))
      a$kind <- ifelse(a$d > temp, cluster$kind[i], a$kind)
      a$d <- ifelse(a$d > temp, temp, a$d)
    }
    #클러스터에 중심점 변경
    for (i in 1:nrow(cluster)){
      cluster[cluster$kind==i, -ncol(cluster)] <- colMeans(a[a$kind==i, 1:(ncol(a)-2)])
    }
    #클러스터에 중심점 변경이 없을시 반복문 종료
    if (sum(t_cluster-cluster)==0){
      return(a$kind)
      break
    }
  }
}
set.seed(7)
km <- my_kmeans(data, 2)

#8.분류 결과 확인
cbind(fruits, km)
library(gmodels)
CrossTable(km, fruits$음식종류, dnn=c('predicted','actual'))
##################################################
#유방암 데이터로 성능 확인
#1.데이터를 로드
wisc <- read.csv("wisc_bc_data.csv")
#2.필요한 컬럼만 선택
wisc2 <- wisc[   , 3:32 ] #환자id와 정답을 제외한 나머지 컬럼들
#3.정규화를 진행
normalize <- function(x) {
  return   ((x-min(x)) /  ( max(x) - min(x) ) ) 
}
wisc_n <-  as.data.frame( lapply( wisc2, normalize )   )
#4.모델을 생성
set.seed(7)
km <- my_kmeans(wisc_n, 2)
#5.정확도를 확인 
CrossTable(km, wisc$diagnosis, dnn=c('predicted','actual'))
#정확도 (351+179)/569 = 0.93
#6.stats 패키지의 kmeans와 성능 비교
set.seed(7)
km2 <- kmeans(wisc_n, 2)
CrossTable(km2$cluster, wisc$diagnosis, dnn=c('predicted','actual'))
#정확도 (348+180)/569 = 0.927