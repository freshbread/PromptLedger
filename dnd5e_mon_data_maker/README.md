# 🐉 D&D 5e Creature Codex Architect (System Prompt)

![Version](https://img.shields.io/badge/Version-1.0-blue) ![System](https://img.shields.io/badge/System-D%26D_5e-red) ![Format](https://img.shields.io/badge/Format-YAML-orange)

**LLM을 위한 D&D 5e 몬스터 데이터(Stat Block) 생성/변환 시스템 프롬프트입니다.**

사용자의 추상적인 몬스터 묘사나 홈브루 아이디어를 분석하여, VTT(Virtual Tabletop)나 AI DM 시스템에서 즉시 연산 가능한 **표준 YAML 구조의 몬스터 시트**로 변환합니다.

---

## 🚀 Features (주요 기능)

1. **공식 데이터 연동 (Official Data Retrieval)**
   - "고블린", "레드 드래곤" 등 공식 몬스터 이름을 입력하면, SRD/MM 데이터를 기반으로 정확한 스탯을 출력합니다.

2. **홈브루 추론 및 밸런싱 (Homebrew Inference & Balancing)**
   - "1호선 지하철을 떠도는 황금 갑옷의 기사" 같은 묘사만으로 능력치(Stats), AC, HP를 추론합니다.
   - 몬스터의 공격력과 특성을 분석하여 **CR(Challenge Rating)을 자동으로 추정**하여 할당합니다.

3. **기계 가독성 최적화 (Machine-Readable Structure)**
   - **Key:** 기계 처리를 위한 `English`
   - **Value:** 사용자 가독성을 위한 `Korean (English)` 하이브리드 포맷
   - `actions`, `reactions`, `legendary_actions` 등을 명확히 분리하여 턴제 시뮬레이션에 적합합니다.

---

## 🛠 Usage (사용 방법)

1. `prompt.yaml` 파일의 내용을 복사합니다.
2. LLM(ChatGPT, Claude 등)의 **System Prompt** 혹은 첫 번째 메시지로 입력합니다.
3. 몬스터의 이름, 컨셉, 혹은 모티브가 되는 대상을 입력합니다.

### 📝 Input Example (입력 예시)

> "이름은 '1호선 자르반'이야. 한국의 지하철 1호선을 배회하는 전설적인 기사지.
> 번쩍이는 황금색(사실은 누런색) 갑옷을 입고 있고, 거대한 깃대(Polearm)를 무기로 사용해.
> 사람들에게 소리를 지르거나, 깃대로 바닥을 찍어서 충격파를 일으키기도 해.
> 성향은 혼돈 중립(Chaotic Neutral)이고, 지하철 안에서는 더 강해져."

---

## 📊 Output Example (출력 예시)

**User Input:** "1호선 자르반(Jarvan of Line 1), CR 5 정도의 전사형 몬스터. 지하철 영역 보너스 있음."

```yaml
monster:
  - id: 'SEOUL-L1-004'
    name: '1호선 자르반 (Jarvan of Line 1)'
    source: { type: 'Homebrew', book: 'Seoul Urban Legends' }
    description:
      - appearance: '조잡하지만 위압적인 황금색 판금 갑옷을 두르고, 거대한 깃발이 달린 폴암을 든 노장.'
      - lore: '1호선의 수호자이자 지배자. 그의 목소리는 지하철의 소음을 뚫고 울려 퍼지며, 그가 깃대를 내려찍으면 열차조차 멈춘다고 전해진다.'
    identity:
      size: 'Medium'
      type: 'Humanoid'
      subtype: 'Human'
      alignment: 'Chaotic Neutral'
    
    attributes:
      strength: { score: 18, modifier: 4 }
      dexterity: { score: 10, modifier: 0 }
      constitution: { score: 16, modifier: 3 }
      intelligence: { score: 10, modifier: 0 }
      wisdom: { score: 12, modifier: 1 }
      charisma: { score: 14, modifier: 2 }
    
    combat:
      armor_class: { value: 18, source: 'Makeshift Plate Armor' }
      hit_points: { average: 85, dice_formula: '10d8 + 40' } # Fighter-like durability
      speed: { walk: '30 ft.' }
      challenge_rating: '5'
      xp: 1800
    
    proficiencies:
      saving_throws: { Strength: 7, Constitution: 6 }
      skills: { Athletics: 7, Intimidation: 5 }
    
    senses:
      list: ['passive Perception 11']
      passive_perception: 11
    
    immunities_resistances_vulnerabilities:
      damage_resistances: []
      damage_vulnerabilities: []
      damage_immunities: []
      condition_immunities: ['frightened'] # 역전의 용사

    languages: ['Korean', 'Subway Dialect']
    
    special_traits:
      - name: '지하철의 지배자 (Subway Dominance)'
        description: '지하철 내부나 인공적인 터널 환경에서 싸울 때, 자르반은 이동 속도가 10ft 증가하고 넘어짐(Prone) 상태에 면역이 됩니다.'
      - name: '깃대 숙련 (Polearm Master)'
        description: '자르반이 깃대(Halberd)로 공격할 때, 사거리가 10ft가 됩니다.'

    actions:
      - name: '다중 공격 (Multiattack)'
        description: '자르반은 깃대(Flag Spear)로 두 번 공격합니다.'
      - name: '깃대 강타 (Flag Spear)'
        type: 'melee_weapon_attack'
        attack_bonus: 7
        reach: '10 ft.'
        target: 'one target'
        effects:
          - type: 'damage'
            damage_dice: '1d10 + 4'
            damage_type: 'slashing'
      - name: '대격변 (Cataclysm)'
        description: '자르반이 높이 도약하여 지정한 지점을 강하게 내려찍습니다. 20ft 반경 내의 모든 생명체는 DC 15 힘(Strength) 내성 굴림을 해야 하며, 실패 시 4d6의 충격(Bludgeoning) 피해를 입고 넘어짐(Prone) 상태가 됩니다. (Recharge 5-6)'

    reactions:
      - name: '경로 방해 (Interruption)'
        description: '자르반의 사거리(10ft) 내로 적이 진입하면, 기회 공격(Opportunity Attack)을 수행할 수 있습니다.'
```

---

## 📜 License
This project is licensed under the MIT License.