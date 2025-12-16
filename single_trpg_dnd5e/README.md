# 🎲 Session-SOT: AI DM Operation Guide

![System](https://img.shields.io/badge/System-D%26D_5e-red) ![License](https://img.shields.io/badge/License-CC_BY--NC_4.0-lightgrey) ![Status](https://img.shields.io/badge/Status-Personal_Fan_Content-blue)

## 📖 프로젝트 소개 (About This Project)

**Session-SOT**는 개인적인 TRPG(특히 D&D 5e) 플레이를 위해 설계된 **"AI DM 운영 가이드, 프로토콜 및 데이터 스키마"** 문서입니다.

LLM(Large Language Model)을 던전 마스터(DM)로 활용할 때 가장 큰 문제점인 '기억 상실'과 '일관성 부족'을 해결하기 위해 만들어졌습니다. 이 가이드의 핵심 목표는 **"세션을 진행하면서 상태(State)를 일관되게 기록하고, 턴(Turn) 단위의 진행을 시스템적으로 안정화하는 것"**입니다.

> **Note:** 이 프로젝트는 상업적 목적이 없는 개인의 취미 생활 및 공유를 위한 **팬 콘텐츠(Fan Content)**입니다.

---

## 📂 파일 구성 (Files)

이 저장소는 다음과 같은 핵심 파일들로 구성되어 있습니다.

- **`prompt.md`**
  - 핵심 파일입니다. AI DM이 따라야 할 운영 프로토콜, 데이터 스키마(YAML), 충돌 해결 규칙 등을 정의한 **시스템 프롬프트 명세서**입니다.
- **`ATTRIBUTION.md`**
  - 본 프로젝트에 포함되거나 참조된 제3자 저작물(SRD 등)에 대한 출처 및 라이선스 표기 문서입니다.
- **`NOTICE.md`**
  - Wizards of the Coast의 팬 콘텐츠 정책(Fan Content Policy) 준수 고지 및 상표권 관련 고지사항입니다.

---

## 🛠 사용 방법 (Usage)

1. **가이드 탑재:** `prompt.md`의 내용을 복사하여 LLM(ChatGPT, Claude, Gemini 등)의 시스템 프롬프트 또는 첫 번째 메시지로 입력합니다.
2. **커스터마이징:** 본인의 캠페인 스타일이나 하우스 룰에 맞춰 내용을 자유롭게 수정해서 사용하세요.
3. **데이터 분리 권장:**
   - 이 가이드는 '엔진'에 해당합니다.
   - 실제 플레이 세션 로그, 세계관 고유명사, 캠페인 설정 등의 '데이터'는 **별도의 비공개 저장소(Private Repo)나 로
