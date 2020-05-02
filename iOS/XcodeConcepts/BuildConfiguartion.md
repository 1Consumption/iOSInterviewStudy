# Build Configuration

## Edit Scheme
![](https://i.imgur.com/ESFhUZz.png)


현재 기본 설정은 Debug 모드로 되어있음.
기본적으로 Debug, Release 모드 2개가 있는데, 이제 확장 시켜주고 싶을때는 어떤 방식으로 하는가를 살펴 볼 것.

예를 들어 개발 버전, 배포 버전, 테스트 버전 등등..

<br>

## Project > Info
![](https://i.imgur.com/mkJ7UKB.png)


'+' 버튼을 클릭해서 Debug Configuration을 복제해서 Configuration 명 변경

![](https://i.imgur.com/NNP92RP.png)

<br>

## Product > Scheme > Manage Scheme
![](https://i.imgur.com/xMjKsuM.png)

'+' 버튼 클릭해서 Scheme명을 지어줍니다.

아직 빌드해도 앱은 하나로 나옴.


<br>

## Targets

![](https://i.imgur.com/MSMfkdn.png)

Add User-Defined Setting 추가


![](https://i.imgur.com/7APT0Fm.png)

처음에는 NEW SETTING 이라고 되어있는데 변경가능. description도 변경 가능하다.

<br>

## Info.plist

![](https://i.imgur.com/R8z26Ph.png)

이쪽에가서 Bundle identifiler를 User-Defined에서 변경한 이름으로 설정해준다.
$(LIN_CUSTOM_SETTING) 이렇게 설정해주면 됨.

<br>

## 다시 Scheme 설정..

![](https://i.imgur.com/SU26vb0.jpg)

1. Product > Scheme > 아까 만들었던 Scheme 선택
2. 선택한 후 Edit Scheme로 들어감.
3. Build Configuration을 아까 만들었던 Test로 변경

<br>

## 다시 Targets 가서 Bundle name 커스텀

![](https://i.imgur.com/tjUxs2R.png)

여기서 보여지는게 앱 이름이 된다.

<br>

## Info.plist 설정

![](https://i.imgur.com/BCLDuMC.png)

Bundle identifier 처럼 변경해주면 된다.

<br>

## 이제 빌드를 해보자!!

![](https://i.imgur.com/1eBnkHR.png)

? ? ? ? ?

![](https://i.imgur.com/W37orrV.png)

오류엔딩 (Pod도 설정해야하는것 같으나.. 정확히 원인을 모르겠음)

참고 : https://zeddios.tistory.com/705
