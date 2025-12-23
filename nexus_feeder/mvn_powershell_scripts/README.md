# Nexus Batch Deployer

로컬 Maven 저장소(.m2)의 아티팩트를 Nexus 3 'thirdparty' 저장소로 일괄 업로드하는 PowerShell 스크립트입니다.

## 주요 특징
- JAR 파일이 있는 라이브러리와 POM만 있는 Parent/BOM 자동 식별 배포
- 임시 폴더를 활용한 깔끔한 배포 프로세스
- `-Dpackaging` 강제 지정으로 배포 정합성 확보

## 사용 방법
1. 스크립트 상단의 '환경 설정' 섹션에서 본인의 Nexus URL과 로컬 경로를 수정합니다.
2. `$gavList` 배열에 업로드할 라이브러리 정보를 추가합니다.
3. PowerShell에서 스크립트를 실행합니다.