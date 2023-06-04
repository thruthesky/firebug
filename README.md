# Firebug

반딧불 프로젝트

## 참여하기

- 본 repo 를 clone 해서 소스 코드를 확인하시고 실행하시면 됩니다.
  - 물론 참여하지 않고, 본 자료를 보시기만 해도 됩니다.

- 코드(기능) 추가, 변경을 하신 후 PR 하시면 됩니다.
  - 참고로 main 브랜치는 protected 되어져 있어, Repository 에 collaborator 로 등록을 해도 PR 해야 합니다.

- 본인이 코딩을 해 보고 싶은 부분이 있으면 clone 아무 말 없이 코딩을 하셔도 됩니다.
  - 하지만, 미리 말씀해 주시면, 본 문서의 `참여` 부분에 이름을 적어드립니다. 그래서 얼마나 많은 분들이 참여하고 있고, 누구와 소통해야하는지 알 수 있습니다.


## 세미나

- 세미나 시간에 각자 공부한 것을 발표하셤ㄴ서 서로 배우고 질문하는 시간을 가질 수 있습니다.
- 세미나는 단톡방의 공지를 참고해주세요.
- [플러터+파이어베이스 단톡방](https://open.kakao.com/o/gaScS0nf)



## 기능

- 본 프로젝트는 플러터와 파이이베이스를 공부하기 위한 것으로 다음과 같은 기능을 작성할 예정입니다.
  - 회원 기능
    - 이메일/비밀번호 로그인, 비밀번호 찾기
    - 전화번호 로그인
    - 소셜 로그인
      - 구글 로그인
      - 애플 로그인
      - 페이스북 로그인
      - 소셜 로그인과 이메일 인증, 전화번호 인증하기
    - 회원 정보 수정
    - 회원 사진 업로드
  - 게시판 기능
    - 게시판 기능 전체 (카테고리 관리, 코멘트 들여쓰기, 사진/동영상/파일 업로드, 기타 좋아요 등 모든 기능)
    - 게시판 풀텍스트 검색 기능 (풀텍스트 검색은 Firebase 에 해당하는 것은 아니지만, 필수 이므로 사용. Typesense 를 사용.)
    - 참여: `영자`
  - 채팅 기능
    - 1:1 채팅
    - 그룹 채팅
    - 각종 방장 기능
    - 사진/동영상/파일 전송 기능
  - 팔로잉
  - 피드
    - 내가 좋아요/팔로우 하는 사람의 새글 목록
  - 앱체크
  - 호스팅
  - Storage 업로드
    - 이미지 썸네일
  - Functions
  - Remote Config
  - Extensions 사용법
  - CI/CD
  - Crashlytics
  - Messaging - Push noitification
  - AdMob
  - Dynanic Link ( 파이어베이스에서 앞으로 Dynamic Link 를 지원하지 않음. 대체 기능 찾을 것.)


## 코딩가이드

### Flutter 기본

- 항상 Flutter 와 Dart 최신 SDK 사용
- Material 3 를 사용


### 코드는 무조건 짧게

- 코드를 길게 쓰는 것은 오직, 에러와 버그를 많이 추가하는 것.
- 소스 코드를 전혀 작성하지 않는 것이 가장 좋고, 그렇지 않다면, 최대한 짧게(물론 충분한 가독성과 함께) 코드 작성해야 합니다.

### Realtime Database

- Firestore 가 필요하지 않는 상황에서는 Realtime Database 를 쓰는 것이 원칙.
- 꼭 필요한 경우에만 Firestore 를 쓸 것.
- 회원 관리, 게시판, 채팅 기능 등에서는 반드시 Realtime Database 를 쓸 것.



### 플랫폼

- Android, iOS, Web 이렇게 3가지를 지원하는 코드를 작성합니다.


## 설치

- 각자의 Firebase 프로젝트를 연결하시면 됩니다.
  - 이러한 이유로 아래의 아래의 파일들은 .gitignore 에 등록이 되었습니다.
    - `firebase_options.dart`
    - `google-services.json`
    - `GoogleService-Info.plist`
    - `firebase_app_id_file.json`



