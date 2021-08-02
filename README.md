# Sensor Based Posture Correction



오랜 시간 작업에 무의식중에 자세가 망가진 적이 있나요??
안좋은 자세를 취하면 실시간으로 사용자에게 알려주는 자세 교정 보조 앱!!
현재 취하고 있는 자세가 좋은 자세인지 안 좋은 자세인지 파악하고, 안 좋은 자세를 5가지 자세로 분류하여 어떤 자세를 많이 취하는지 경향성을 파악할 수 있습니다!

``` bash 
1. 9축 센서와 라즈베리 파이가 설치된 장비를 입고 모바일과 블루투스 연결합니다. 
2. 연결된 모바일에서 앱을 통해 측정을 시작하면 기존에 학습된 모델에 의해 현재 사용자의 자세를 측정하기 시작합니다.
3. 현재 취하고 있는 자세는 앱 화면을 통해 모니터링 할 수 있고, 바른자세가 아니라면 알림을 줍니다.
4. 현재 취하고 있는 자세와 앱에서 측정된 자세가 다르게 나온다면 사용자가 잘못된 자세라는 피드백을 줄 수 있고, 그 자세 데이터(9축 센서 값)는 학습에 재사용 되어야합니다.(미구현)
5. 판단한 후, 위험하다면 아두이노로 보내어 LED센서와 진동센서를 작동시킵니다. 
6. 또한, 파이썬 통신모듈을 통해 NODE.JS 서버로 이름, 나이, 센서 등의 값을 보냅니다. 
7. 이를 바탕으로 Client와 소켓연결, 데이타를 클라이언트로 전송하여 실시간 모니터링을 구현합니다.
```

## Getting Started / 어떻게 시작하나요?

이 곳에서 설치에 관련된 이야기를 해주시면 좋습니다.

### Prerequisites / 선행 조건

아래 사항들이 설치가 되어있어야합니다.

```
예시
```

### Installing / 설치

아래 사항들로 현 프로젝트에 관한 모듈들을 설치할 수 있습니다.

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
