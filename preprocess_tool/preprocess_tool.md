빈 폴더를 github에 올리기 위해 내부에 gitkeep 이라는 파일 크기가 0인 파일을 생성하여 올렸다. 

## 전처리를 수행하기 위한 powershell 코드는 라이센스의 요구사항을 다 파악하지 못해 추후 확인 후 올릴 예정이다. 

## 각 폴더의 의미 설명    
* 0_Tool - SplitCap.exe와 fdupes.exe 존재
* 1_Pcap - .pcap 파일이 위치하는 폴더로, .pcap 파일의 네이밍 규칙은 어플리케이션이름_중복방지를 위한 추가 문자이다.     
  '_'를 기준으로 자르기 때문에, 중복되지 않는 packet이어도 _를 추가하는 것을 추천한다. ***(ex. kakaotalk_1.pcap)***
* 2_Session - Pcap2Session.ps1을 실행하고 나면 SplitCap을 통해 분리된 파일이 저장되는 폴더이다. 
