# jenkins-study
젠킨스 공부를 위한 공간입니다.
근데 너무 어려움..

!!진행상황!!
22/08/31
Github Push -> Project-1/freestyle(webhook을 통해 배포서버에 git clone) -> Project-2/pipeline(Project-1이 실행되고 난 다음 실행되게끔 구성 - 실제배포) -> Slack과 연동

22/09/21
Github Push -> Master Node -> Web Node(httpd+Proxy+Sleep) -> Was Node(tomcat+Input) -> Slack 알림 
이슈사항 : Proxy 설정 및 Tomcat 설정 파일을 스크립트로 돌릴 때, cat >> 경로 <<의 형태로 넣다보니 수정 시 멱등성이 없음......... 
