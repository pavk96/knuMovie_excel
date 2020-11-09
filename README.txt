# 제작환경
  - DB using psql(PostgreSQL) 12.4  
  - JDBC 42.2.18
  - JDK 11.0.9

VScode for Java
  - extension Java Extension Pack
  - extension Maven for Java
  - Ret Hat
  - Java Test Runner
  - Project Manager for Java
  - Debugger for Java
  - pom.xml dependencies->dependency <systemPath>경로 바꾸기

# 실행 및 사용법
※1.이 아닌 1을 입력해야한다
1. initial Menu
 1) 계정이 있을 시 로그인
    - DB에서 Email과 Password 입력
	Email과 Password가 일치 할 경우 
	:로그인 메뉴로 이동
	Email과 Password가 불일치 할 경우
	:에러 메세지
 2) 계정이 없을 시 회원가입
    - DB에서 NOT NULL 속성만 기입
	Email Address(Email_add)
	: "@"의 포함 여부 확인
	First Name(Fname)
	Last Name(Lname)
	Password(Password)
	SID(sid)
※중복 입력 시 전부 다시 입력해야 합니다
 3) Application 종료
    - Application을 종료한다
2. mainMenu( menu after login)
 1) 영화 검색
     - 조건에 따라 영화들을 검색할 수 있는 기능이다
       ※조건 중 평가는 최소점수 및 최대점수로 입력
     

 2) 회원 정보 수정
     - 로그인 한 회원의 정보 수정이 가능하도록 한다
     ※ 100자 이상이거나 형식에 맞지 않을 시 다시 입력
 3) 로그아웃
     - initialMenu로 돌아가는 기능이다

 4) Application 종료
     - initialMenu의 3)과 같다.

 5) 관리자 모드
     - 영상물을 수정 및 등록할 수 있는 기능이며 권한이 있는 자만 사용이 가능하다
     - adminMenu에 있다
 6) 평가 내역 확인
     -  
3.changeAccountInfo
 1)이름

 2)생년월일

 3)성별

 4)비밀번호

 5)전화번호
    ※정규식 사용 '000-0000-0000'
 6)주소

 7)직업

 8)멤버쉽

 9)뒤로가기

 0)회원 탈퇴

4. adminMenu(관리자 메뉴)

 1) 영상물 등록
 - addMovie
 2) 영상물 수정
 - updateMovie
 3) 평가 확인

 4) 뒤로가기

5. updateMovie(영상물 수정)


6. afterSelectMovie


# 유의 사항
   - "※"로 표시 



initial - main - 