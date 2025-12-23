# Nexus Feeder (Maven Build Log Analyzer)

이 프롬프트는 Maven 빌드 로그를 분석하여 Nexus에 업로드해야 할 **누락된 의존성(Artifacts)**을 식별하고, 지정된 형식의 코드 블록으로 변환합니다.

## 🎯 목적
- 빌드 실패의 원인이 되는 누락된 JAR, POM, Parent POM 식별
- 수동 Nexus 업로드 작업을 위한 데이터 추출 자동화
- 의존성 전파(Chain-reaction)에 따른 누락 항목 추적

## 🔍 분석 로직
1. **Type A (Explicit):** 로그 내 `missing`, `Could not find`, `Failure to find` 키워드 감지.
2. **Type B (Implicit):** `Downloading` 시도는 있으나 로그 끝까지 `Downloaded` 성공 메시지가 없는 항목 추적.
3. **Artifact 식별:** URL 또는 Maven 좌표(`G:A:P:V`)에서 GroupId, ArtifactId, Version 추출.

## 🛠 사용 방법
프롬프트에 Maven 빌드 로그(원문)를 복사하여 붙여넣으십시오. 도구는 별도의 설명 없이 즉시 아래 형식의 결과를 출력합니다.

**출력 형식:**
`@("{{GroupId}}", "{{ArtifactId}}", "{{Version}}"),`

## ⚖️ 정제 규칙
- **중복 제거:** 동일한 의존성이 여러 번 나타나도 한 번만 출력.
- **정렬:** GroupId 기준 오름차순 정렬로 가독성 확보.
- **최소 출력:** 대화나 설명 없이 오직 코드 블록만 제공.