# oci-free-arm  

## APPENDIX
  
OCI 에서 평생 무료로 제공 중인 ARM CPU 4 Core, RAM 24GB 성능의 OS 생성 중  
```Out of capacity for shape VM.Standard.A1.Flex in availability domain AD-1. Create the instance in a different availability domain or try again later. If you specified a fault domain, try creating the instance without specifying a fault domain. If that doesn’t work, please try again later. Learn more about host capacity.```  
위와 같은 메시지가 발생함  
  
  
해당 가용영역에 ARM CPU Host 가 부족해서 발생하는 에러메시지이고, 언제 추가될지 모르기 때문에  
30초마다 생성을 시도하는 스크립트를 개발하게 됨.
  
## How To Running  
1. API Key 다운로드
    1. 로그인 후 우측 상단 Profile 클릭
    2. 좌측 Resource 하단 API Keys 탭 클릭
    3. Add API Key 클릭 후 private key, public key 다운로드
    4. Add 버튼 클릭 및 Configuration File 복사 해두기
    
2. OCI CLI 다운로드 ([link](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm#InstallingCLI__linux_and_unix))
    - 명령어
        
        ```bash
        bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
        
        cp oci /usr/local/bin/
        #oci 실행파일 이동
        
        oci --version
        ```
        
    
3. OCI CLI Config 설정
    - 명령어
        
        ```bash
        vi ${HOME}/.oci/config
        
        아래 내용 작성
        
        [DEFAULT]
        user=ocid1.user..
        fingerprint=da:9c..
        tenancy=ocid1.tenancy..
        region=ap-chuncheon-1
        key_file=/${HOME}/.oci/oci_public_key.pem
        ```
        
4.  1 에서 다운로드한 pem 들을 ${HOME}/.oci/ 하위에 복사

- 파일 이름을 변경
    
    ```bash
    API Private key 파일: oci_api_key.pem
    API Public key 파일: oci_api_key_public.pem
    ```
    
5. Chrome / Edge 개발자도구 (F12) 로 DATA 뽑기
    1. OCI 에서 생성할 서버 생성을 진행  
    2. 생성 버튼 클릭 전 F12 클릭 -> Network 탭으로 이동  
    3. "instances/" 부분에 오른쪽 마우스 클릭 -> Curl (bash) 복사  
    4. Text Editor 에 붙혀넣기  
    5. curl 명령 중 URL이 "/instances/" 로 끝나는 부분 확인  
    6. "--data-raw" 의 ```'``` 이후 ```{```부터  맨끝 ```'``` 전 ```}``` 까지 복사  
    7. config.json 에 붙혀넣기  
     
6. 스크립트 실행 후 30초마다 정상적으로 로그가 쌓이는 확인
