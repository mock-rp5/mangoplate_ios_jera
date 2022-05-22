## 📖 개발일지
</br>
<details>
<summary>1일차_2022.05.21 (토) (5%)</summary>
<div markdown="1">
1. 기획서 작성

2. 회원가입, 로그인 UI 구현
	- 로그인 홈 화면
	- 로그인 입력 화면 (이메일, 비밀번호 입력하지 않으면 버튼 비활성화)
	- 회원가입 이메일, 비밀번호 입력 화면 (이메일 인증, 비밀번호 2번 입력하지 않으면 버튼 비활성화, 비밀번호 같은지 체크)
  	- 프로필, 닉네임 입력 화면 (닉네임 글자 수 체크)

<img width="200" src="./image/1-1.png"> <img width="200" src="./image/1-2.png"> <img width="200" src="./image/1-3.png"> <img width="200" src="./image/1-4.png">
</div>
</details>

</br>
<details>
<summary>2일차_2022.05.22 (일) (15%)</summary>
<div markdown="1">

1. 구현한 기능
	- 카카오 로그인 구현
	- TabBar 구현
	- NavigationItem Custom 구현
	- 맛집찾기: 자동 스크롤 배너 CollectionView로 구현
	- 맛집찾기: 식당 리스트 CollectionView로 구현
</br>
2. 발생한 이슈
	- NavigationItem의 label을 줄바꿈하고, 폰트크기 다르게 구현해야함</br>
		-> AttributedString을 사용하여 해결 ([참고](https://zeddios.tistory.com/300))

	- 맛집찾기탭에서 자동배너 뷰, 정렬,필터 뷰, 식당리스트 뷰 모두 한 스크롤안에 넣게 구현해야함 </br>
		->  CollectionView의 섹션을 3개로 잡고 각각 섹션으로 셀을 넣어줌</br>
			자동배너뷰 셀안에는 CollectionView를 넣어 CollectionView안에 CollectionView로 구현 ([참고](https://youbidan-project.tistory.com/104))

<img width="200" src="./image/2-1.png"> <img width="200" src="./image/2-2.png"> 


</div>
</details>