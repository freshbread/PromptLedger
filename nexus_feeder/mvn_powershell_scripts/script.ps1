# ==============================================================================
# 1. 환경 설정 (사용자 환경에 맞게 수정 필요)
# ==============================================================================

# Nexus 저장소 정보 (내부 IP 대신 도메인 또는 예시 URL 사용 권장)
$nexusUrl = "http://your-nexus-domain:8081/repository/thirdparty/"
$repoId = "thirdparty" # Maven settings.xml에 정의된 server id와 일치해야 함

# 경로 설정 ($env:USERPROFILE을 사용하여 사용자 계정명 노출 방지)
$mavenRepoRoot = Join-Path $env:USERPROFILE ".m2\repository"
$tempDeployDir = Join-Path $PSScriptRoot "temp_deploy" # 스크립트 실행 경로 하위의 임시 폴더

# ==============================================================================
# 2. 배포 대상 GAV 목록
# ==============================================================================
$gavList = @(
    @("org.eclipse.aether", "aether", "1.0.0.v20140518"),
    @("commons-codec", "commons-codec", "1.11")
    # 추가 항목은 여기에 배치
)

# 임시 폴더 생성
if (-not (Test-Path $tempDeployDir)) {
    New-Item -Path $tempDeployDir -Type Directory | Out-Null
}

Write-Host "Starting Unified Deployment to Nexus repository: ${repoId}" -ForegroundColor Cyan

$successCount = 0
$failCount = 0

foreach ($gav in $gavList) {
    $groupId    = $gav[0]
    $artifactId = $gav[1]
    $version    = $gav[2]

    $gPath = $groupId.Replace('.', '\')
    $versionPath = Join-Path $mavenRepoRoot "${gPath}\${artifactId}\${version}"

    $pomFileName = "$artifactId-$version.pom"
    $jarFileName = "$artifactId-$version.jar"

    $originalPomPath = Join-Path $versionPath $pomFileName
    $originalJarPath = Join-Path $versionPath $jarFileName

    $tempTargetPomPath = Join-Path $tempDeployDir $pomFileName
    $tempTargetJarPath = Join-Path $tempDeployDir $jarFileName

    Write-Host "`r`n--------------------------------------------------" -ForegroundColor Gray
    Write-Host "Processing: ${groupId}:${artifactId}:${version}" -ForegroundColor White

    # 1. POM 파일 존재 확인
    if (-not (Test-Path $originalPomPath)) {
        Write-Error "Required POM file not found at: $originalPomPath"
        $failCount++
        continue
    }
    Copy-Item -Path $originalPomPath -Destination $tempTargetPomPath -Force

    # 2. Maven 명령 기본 인자 설정
    $arguments = @(
        "deploy:deploy-file",
        "-Durl=$nexusUrl",
        "-DrepositoryId=$repoId",
        "-DgroupId=$groupId",
        "-DartifactId=$artifactId",
        "-Dversion=$version"
    )

    # 3. JAR 존재 여부에 따른 파라미터 분기
    $hasJar = Test-Path $originalJarPath
    if ($hasJar) {
        Copy-Item -Path $originalJarPath -Destination $tempTargetJarPath -Force
        $arguments += @(
            "-Dfile=`"$tempTargetJarPath`"",
            "-DpomFile=`"$tempTargetPomPath`"",
            "-Dpackaging=jar"
        )
        $typeDesc = "JAR + POM (Library)"
    } else {
        $arguments += @(
            "-Dfile=`"$tempTargetPomPath`"",
            "-DpomFile=`"$tempTargetPomPath`"",
            "-Dpackaging=pom"
        )
        $typeDesc = "POM Only (BOM/Parent)"
    }

    Write-Host "Type: $typeDesc"

    # 4. 배포 실행 및 결과 확인
    try {
        & mvn $arguments
        if ($LASTEXITCODE -eq 0) {
            Write-Host "Successfully deployed: $artifactId" -ForegroundColor Green
            $successCount++
        } else {
            Write-Host "Failed to deploy: $artifactId (Exit code: $LASTEXITCODE)" -ForegroundColor Red
            $failCount++
        }
    } catch {
        Write-Host "An error occurred during mvn execution: $($_.Exception.Message)" -ForegroundColor Red
        $failCount++
    }

    # 5. 임시 파일 정리
    Remove-Item $tempTargetPomPath -ErrorAction SilentlyContinue
    if ($hasJar) {
        Remove-Item $tempTargetJarPath -ErrorAction SilentlyContinue
    }
}

Write-Host "`r`n==================================================" -ForegroundColor Cyan
Write-Host "Deployment Finished!"
Write-Host "Success: $successCount" -ForegroundColor Green
Write-Host "Failed: $failCount" -ForegroundColor Red
Write-Host "=================================================="