# Racoding_Kmeans_in_R
### K-means clustering algorithm
### K-means(k개의 평균들) 군집화 이론이란?
> * 주어진 데이터를 k개의 클러스터로 묶는 알고리즘으로 각 클러스터와 거리차이의 분산을 최소화하는 방식으로 작동
> * 비지도학습의 일종으로 레이블(정답)이 없는 입력 데이터에 레이블(정답)을 달아주는 역할로도 활용
> #### 사용사례
> * 통신사 기지국의 위치를 선정
> * 병원에서 암판별 모델의 정확도를 올리는데 참고
> * 마케팅에서 세그멘테이션으로 고객들을 특성에 맞는 사람들끼리 군집화
> * 보험회사에서 세그멘테이션으로 맞춤형 보험상품 개발 및 광고에 활용
> * 미국의 경찰의 순찰 지역을 정하는데 활용해서 범죄율을 줄이는데 사용
### 직접 만든 K-means 함수와 R의 kmeans 함수와 성능 비교
|my_kmeans|R의 kmeans|
|:--:|:--:|
|![image](https://user-images.githubusercontent.com/72850237/126924786-da3a8b32-4e61-416b-9fda-4b6737c3a3af.png)|![image](https://user-images.githubusercontent.com/72850237/126924837-24b9cb2b-94ba-45d1-8b4d-e47878088817.png)|
|정확도 0.93|정확도 0.927|
