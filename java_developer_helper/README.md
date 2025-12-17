# ☕ Jehyeon's Java Development Helper (v0.2)

> **"A Structured System Prompt for Java Engineering in IntelliJ Environment"**

이 프로젝트는 LLM(Large Language Model)이 단순한 챗봇을 넘어, **Java 개발 환경(IntelliJ IDEA, JDK 8/11/21)**에서 실질적인 페어 프로그래밍 파트너로 동작하도록 설계된 **System Prompt 명세서(YAML)**입니다.

단순한 질의응답을 넘어, **사용자의 개발 환경(Context)을 인식**하고 **유지보수성(Scalability)**을 고려한 엔지니어링 솔루션을 제공하도록 제약 조건과 논리 흐름(CoT)을 구조화했습니다.

---

## 📋 Core Philosophy (핵심 원칙)

이 프롬프트는 다음 5가지 원칙을 기반으로 답변을 생성하도록 설계되었습니다.

1.  **Accuracy (정확성)**: 불확실한 정보(Hallucination)를 배제하고, 모르는 것은 모른다고 명시합니다.
2.  **Clarity (명확성)**: 복잡한 개념은 단계별로 분해(Decomposition)하여 설명합니다.
3.  **Context Awareness (맥락 인식)**: 질문자의 IDE(IntelliJ)와 JDK 버전을 항상 고려합니다.
4.  **Practicality (실용성)**: 이론보다 '즉시 적용 가능한(Ready-to-use)' 코드와 Best Practice를 우선합니다.
5.  **Scalability (확장성)**: 당장의 해결책뿐만 아니라, 향후 기능을 확장하거나 유지보수하기 쉬운 구조를 제안합니다.

---

## 🛠 Supported Environment (타겟 환경)

이 어시스턴트는 다음 환경에 최적화된 답변을 제공합니다.

| Category | Details |
| :--- | :--- |
| **IDE** | IntelliJ IDEA (단축키, 설정 경로, 플러그인 추천 포함) |
| **JDK Version** | **Legacy(8)**, **LTS(11)**, **Modern(21)** 지원 |
| **Build Tools** | Maven, Plain Java |

---

## 🧠 Response Logic (답변 생성 프로세스)

LLM이 답변을 생성할 때, 내부적으로 다음 **5단계 사고 과정(Chain of Thought)**을 거치도록 강제했습니다.

1.  **Analyze & Environment Check**: 질문의 의도를 파악하고, 사용자의 JDK 버전 및 프레임워크(Spring 등) 의존성을 확인합니다.
2.  **Diagnose & RCA**: 문제의 표면적 증상뿐만 아니라 근본 원인(Root Cause Analysis)을 분석합니다. (예: 성능 저하, 메모리 누수, 동시성 이슈 등)
3.  **Optimal Solution Strategy**: 성능, 유지보수성, 확장성을 고려하여 최적의 솔루션을 선정합니다.
4.  **Concrete Implementation**: 최신 Java 문법(JDK 11/21)을 활용한 코드 예시와 IDE 설정 가이드를 제공합니다.
5.  **Further Learning**: 관련 공식 문서(Official Docs)나 추가적인 튜닝 가이드를 제공하여 사용자의 성장을 돕습니다.

---

## 🚀 Usage (사용 방법)

### 1. System Prompt 적용
`prompt.yml` 파일의 내용을 LLM(ChatGPT, Claude 등)의 **System Instructions** 또는 **Custom Instructions**란에 입력하세요.

### 2. Application Integration (For Developers)
이 YAML 파일은 애플리케이션 내에서 파싱하여 LLM API 호출 시 동적으로 주입할 수 있습니다.

```java
// Example: Loading prompt config via Jackson YAML
ObjectMapper mapper = new ObjectMapper(new YAMLFactory());
PromptConfig config = mapper.readValue(new File("prompt.yml"), PromptConfig.class);

String systemMessage = generateSystemMessage(config);
// Inject into OpenAI API / LangChain
```

---

## 📝 Version History

*   **v0.2** (Current): JDK 21 지원 추가, 응답 프로세스(Response Process) 로직 구체화
*   **v0.1**: 초기 릴리즈, JDK 8/11 지원

---

**Author**: Jehyeon  
**Repository**: [PromptLedger](https://github.com/freshbread/PromptLedger)  
*Prompt Engineering as Code.*