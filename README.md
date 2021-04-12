# 1. wifi-traffic-analysis-model
 ## 1. overview
 본 프로그램은 와이파이를 이용한 네트워크 통신에서, 사용하는 어플리케이션을 분류하는 모델을 구성한다.
 와이파이에 연결되어 사용자가 특정 어플을 사용할 때, packet을 캡처하여 해당 packet이 어떤 어플리케이션의 packet인지 분류할 수 있다. 
 
 
 **전처리를 위한 모든 파일은 preprocess 폴더 내에 존재함.   
   또한 pcap 파일 이름은 어플리케이션이름_구분순서.pcap 형태로 작성되어야함. *(ex. kakaotalk_1.pcap)*  
   따라서 전처리를 위해서는 해당 폴더 내에서 작업을 수행해야 함.   
   각 폴더를 설명하자면, 0_Tool은 SplitCap과 fdupes exe 파일이 존재하고, 1_Pcap에는 .pcap 형태의 packet 파일이 존재해야함.
   두 조건을 만족하고, 아래의 Installation을 잘 따라왔다면 이후 pwsh 명령을 통해 power shell script 수행 시 2_Session과 3_ProcessedSession에 정상적으로 분리된 packet이 들어가는 것을 확인할 수 있음**
   
---
# 2. Installation  
본 설치 과정은 ubuntu linux 18.04 LTS 기준으로 작성되었으며, 다른 version을 사용중이라면 맨 아래 링크된 사이트를 참조하면 된다. 
 ##  Preprocessing을 위한 packet split 프로그램 설치 및 환경 구축
 
 * Install Mono
   1. Add the Mono repository to your system
      ``` 
      sudo apt install apt-transport-https dirmngr 
      sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF 
      echo "deb https://download.mono-project.com/repo/ubuntu vs-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-vs.list 
      sudo apt update 
      ```
   2. Install Mono
      ```
      sudo apt install mono-devel
      ```
  * PowerShell - Installation via Package Repository
       ```
       sudo apt-get update
       sudo apt-get install -y wget apt-transport-https software-properties-common
       wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
       sudo dpkg -i packages-microsoft-prod.deb
       sudo apt-get update
       sudo add-apt-repository universe
       sudo apt-get install -y powershell
       ```
  * Install fdupes
    ```
    sudo apt-get install fdupes
    ```
  * Install the required packages
    1. pip3이 설치된 경우 (anaconda3의 환경 세팅 후 해당 환경에 설치)
       ```
       pip3 install numpy
       pip3 install Pillow
       ```
    2. pip3이 설치되지 않은 경우
       ```
       sudo apt install python3-pip
       pip3 install numpy
       pip3 install Pillow
       ```
---
# 3. Excution for preprocessing 
   * 1_Pcap 폴더에 존재하는 packet을 Session 기준으로 분할
     **1_Pcap 폴더의 상위 폴더에서 수행**
     ```
     pwsh 1_Pcap2Session.ps1
     ```
     해당 작업이 성공적으로 수행된다면, 2_Session 하위 폴더로 AllLayers 폴더가 생성되고, AllLayers 하위에는 각 application 별 폴더가 생성됨  
     
   * 2_Session 하위 폴더의 packet을 784 byte 단위로 분할하여 저장 
     ```
     # -u 옵션: unsorting, -s 옵션: sorting, 옵션 미작성 시 경고문 출력됨
     pwsh 2_ProcessSession.ps1 [-u|-s] 
     ```
     해당 작업이 성공적으로 수행되면, 3_ProcessedSession 하위 폴더로 FilteredSession과 TrimedSession 폴더가 생성됨. 
