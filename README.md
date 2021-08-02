# Sensor Based Posture Correction



오랜 시간 작업에 무의식중에 자세가 망가진 적이 있나요??
안좋은 자세를 취하면 실시간으로 사용자에게 알려주는 자세 교정 보조 앱!!
현재 취하고 있는 자세가 좋은 자세인지 안 좋은 자세인지 파악하고, 안 좋은 자세를 5가지 자세로 분류할 수 있다!
취하고 있는 자세가 어떤 자세인지, 평소 어떤 자세를 많이 취하는지 경향성을 파악할 수 있다!

``` bash 
1. 9축 센서와 라즈베리 파이가 설치된 장비를 입고 모바일과 블루투스 연결합니다. 
2. 연결된 모바일에서 앱을 통해 측정을 시작하면 기존에 학습된 모델에 의해 현재 사용자의 자세를 측정하기 시작합니다.
3. 현재 취하고 있는 자세는 앱 화면을 통해 모니터링 할 수 있고, 바른자세가 아니라면 알림을 줍니다.
4. 취하고 있는 자세와 앱에서 측정된 자세가 다르게 나온다면 잘못된 자세라는 피드백을 줄 수 있고, 그 때 9축 센서 값은 학습에 재사용 합니다.(미구현) 확인할 
5. Daily Report 를 통해 사용자가 취한 자세의 비중을 확인 할 수 있도록 합니다.
```

## 자세 식별 알고리즘

![image](https://user-images.githubusercontent.com/49424965/127861646-ac7af054-599d-4745-8c6e-486cc84b6708.png)

먼저 바른자세와 바르지 않은 자세를 식별하기 위해 SVM을 이용하여 이진분류 하고
안좋은 자세로 분류된 데이터를 다시 5가지 타입의 안좋은 자세로 분류한다.

[수집한 데이터의 샘플]

![image](https://user-images.githubusercontent.com/49424965/127861822-b42b162a-279c-463b-9daf-ebddad24205c.png)

시간의 흐름에 따른 데이터로써,
가속도, 각속도, 지자기 값이 각각 x, y, z축으로 구성되어 있고, 올바른 자세인지 를 확인하는 값과 나쁜자세의 타입 값, 그리고 UserID 가 있다.

## 시스템 구조도

### 학습 단계 구조도

![image](https://user-images.githubusercontent.com/49424965/127862079-ea1fb068-33bd-401d-bbeb-c8fa6cab631f.png)

Sensor를 통해 입력받은 데이터를 노이즈 필터와 전처리를 각각 거친 후 학습할 데이터 셋을 얻는다.
학습을 진행 할 PC와 통신하여 데이터를 전달하고 최적의 성능을 보이는 파라미터 조건을 찾아 모델을 라즈베리파이로 이식한다.


### 배포 단계 구조도

![image](https://user-images.githubusercontent.com/49424965/127862152-81d3a993-e303-430c-b41b-eb05174635a0.png)



아래 사항들로 현 프로젝트에 관한 모듈들을 설치할 수 있다.

```
예시
```

## Running the tests / 테스트의 실행

어떻게 테스트가 이 시스템에서 돌아가는지에 대한 설명을 합니다

### 테스트는 이런 식으로 동작합니다

왜 이렇게 동작하는지, 설명합니다

```
예시
```

### 테스트는 이런 식으로 작성하시면 됩니다

```
예시
```

## Deployment / 배포

Add additional notes about how to deploy this on a live system / 라이브 시스템을 배포하는 방법

## Built With / 누구랑 만들었나요?

* [이름](링크) - 무엇 무엇을 했어요
* [Name](Link) - Create README.md

## Contributiong / 기여

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us. / [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) 를 읽고 이에 맞추어 pull request 를 해주세요.

## License / 라이센스

This project is licensed under the MIT License - see the [LICENSE.md](https://gist.github.com/PurpleBooth/LICENSE.md) file for details / 이 프로젝트는 MIT 라이센스로 라이센스가 부여되어 있습니다. 자세한 내용은 LICENSE.md 파일을 참고하세요.

## Acknowledgments / 감사의 말

* Hat tip to anyone whose code was used / 코드를 사용한 모든 사용자들에게 팁
* Inspiration / 영감
* etc / 기타
