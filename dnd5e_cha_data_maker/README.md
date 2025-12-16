# 🐉 D&D 5e Character YAML Generator (System Prompt)

![Version](https://img.shields.io/badge/Version-9.1-blue) ![System](https://img.shields.io/badge/System-D%26D_5e-red) ![Format](https://img.shields.io/badge/Format-YAML-orange)

**LLM을 위한 TRPG 캐릭터 데이터 생성/변환 시스템 프롬프트입니다.**

자연어(Natural Language)로 묘사된 캐릭터 설정을 분석하여, VTT(Virtual Tabletop)나 AI DM 시스템에서 즉시 처리 가능한 **엄격한 구조(Strict Schema)의 YAML 데이터**로 변환합니다.

---

## 🚀 Features (주요 기능)

이 프롬프트는 단순한 텍스트 생성이 아니라, **데이터 무결성**을 보장하는 로직을 포함합니다.

1. **추상적 표현의 정량화 (Quantification Logic)**
   - "세계관 최강" → `STR 20`
   - "평범함" → `10-12`
   - 사용자의 모호한 설명을 D&D 5e 규칙에 맞는 구체적인 수치로 자동 변환합니다.

2. **자동 연산 (Auto-Calculation)**
   - Ability Modifiers, Proficiency Bonus, Spell Save DC 등을 룰북 공식에 따라 자동 계산합니다.

3. **충돌 해결 및 홈브루 처리 (Conflict Resolution)**
   - 공식 룰(PHB, DMG)에 없는 능력이 입력될 경우, 에러를 내지 않고 `Homebrew` 소스로 분류하여 주석(`Comment`)과 함께 처리합니다.

4. **하이브리드 언어 처리 (Hybrid Language Structure)**
   - **Key (구조):** 기계 처리를 위해 `English` 사용
   - **Value (데이터):** 사용자 가독성을 위해 `Korean` 사용 (고유명사는 영문 병기)

---

## 🛠 Usage (사용 방법)

1. `prompt.yaml` 파일의 내용을 복사합니다.
2. ChatGPT (GPT-4), Claude 3.5 Sonnet 등의 LLM에 **System Prompt** 혹은 첫 번째 메시지로 입력합니다.
3. LLM이 `개발자 모드` 혹은 `준비 완료` 상태가 되면, 원하는 캐릭터의 설정을 입력합니다.

### 📝 Input Example (입력 예시)

> "엘든 링의 주인공 '빛바랜 자(The Tarnished)'를 만들어줘.
> 방랑 기사(Vagabond) 출신이고, 레벨은 5야. 롱소드와 방패를 잘 다루고, '붉은 물방울의 성배병'을 가지고 있어.
> 말은 없지만 영마 토렌트를 소환할 수 있는 능력이 있어."

---

## 📊 Output Example (출력 예시)

**User Input:** "빛바랜 자(Tarnished), 5레벨 파이터, 방랑기사 태생. 영마 토렌트 소환 가능."

```yaml
character:
  - id: 'ER-PC-001'
    identity:
      type: 'PC'
      name: '빛바랜 자 (The Tarnished)'
      race: 
        name: '인간 (Human)'
        source: { type: 'Official', book: 'PHB' }
      class: 
        name: '파이터 (Fighter)'
        source: { type: 'Official', book: 'PHB' }
      subclass: 
        name: '챔피언 (Champion)'
        source: { type: 'Official', book: 'PHB' }
      level: 5
      background: 
        name: '방랑 기사 (Vagabond)'
        source: { type: 'Homebrew', book: 'Elden Ring Origin' }
      alignment: '진정한 중립 (True Neutral)'

    attributes:
      strength: { score: 16, modifier: 3 } # 방랑 기사 태생 보너스 반영
      dexterity: { score: 14, modifier: 2 }
      constitution: { score: 14, modifier: 2 } # 튼튼한 체력
      intelligence: { score: 10, modifier: 0 }
      wisdom: { score: 12, modifier: 1 }
      charisma: { score: 10, modifier: 0 }

    combat:
      hit_points: { current: 44, max: 44, temp: 0 } # 10 + (6*4) + (2*5)
      armor_class: { total: 18, base: 16, buff_source: 'Chain Mail + Shield' }
      speed: { base: 30, current: 30 }
      proficiency_bonus: 3
    
    features_and_traits:
      list:
        - name: '영마의 반지 (Spectral Steed Whistle)'
          description: '영마 토렌트를 소환하여 탑승할 수 있습니다.'
          source: { type: 'Homebrew', book: 'Elden Ring Item' }
          type: 'bonus_action'
          cost: { name: '-', amount: '-' }
          recharge: '-'
          effects:
            - type: 'utility'
              target: 'self'
              condition: 'mounted'
              duration: 'until dismissed'

    inventory:
      equipped:
        - name: '롱소드 (Longsword)'
          effect: '1d8 Slashing, Versatile (1d10)'
        - name: '히터 실드 (Heater Shield)'
          effect: '+2 AC'
      items:
        - name: '붉은 물방울의 성배병 (Flask of Crimson Tears)'
          count: 3
          effect: 'Restores HP (Homebrew Potion)'
```

---

## 📜 License
This project is licensed under the MIT License - see the LICENSE file for details.