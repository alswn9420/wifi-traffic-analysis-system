# 1. wifi-traffic-analysis-model
 ## 1. overview
 본 프로그램은 와이파이를 이용한 네트워크 통신에서, 사용하는 어플리케이션을 분류하는 모델을 구성한다.
 와이파이에 연결되어 사용자가 특정 어플을 사용할 때, packet을 캡처하여 해당 packet이 어떤 어플리케이션의 packet인지 분류할 수 있다. 
 
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
    
    
