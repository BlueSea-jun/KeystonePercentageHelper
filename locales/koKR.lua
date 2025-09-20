local AddonName, Engine = ...;

local LibStub = LibStub;
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale(AddonName, "koKR", false, false);
if not L then return end

-- TRANSLATION REQUIRED

-- Dungeons Group
L["DUNGEONS"] = "현재 시즌"
L["CURRENT_SEASON"] = "현재 시즌"
L["NEXT_SEASON"] = "다음 시즌"
L["EXPANSION_DF"] = "용군단"
L["EXPANSION_CATA"] = "대격변"
L["EXPANSION_WW"] = "내부전쟁"
L["EXPANSION_SL"] = "어둠땅"
L["EXPANSION_BFA"] = "격전의 아제로스"
L["EXPANSION_LEGION"] = "군단"

-- The War Within
-- Ara-Kara, City of Echoes
L["AKCE_BOSS1"] = "아바녹스"
L["AKCE_BOSS2"] = "아눕젝트"
L["AKCE_BOSS3"] = "수확자 키카탈"

-- City of Threads
L["CoT_BOSS1"] = "웅변가 크릭스비즈크"
L["CoT_BOSS2"] = "여왕의 송곳니"
L["CoT_BOSS3"] = "응집체"
L["CoT_BOSS4"] = "대접합사 이조"

-- Cinderbrew Meadery
L["CBM_BOSS1"] = "양조장인 알드리르"
L["CBM_BOSS2"] = "이파"
L["CBM_BOSS3"] = "벤크 버즈비"
L["CBM_BOSS4"] = "골디 바론바텀"

-- Darkflame Cleft
L["DFC_BOSS1"] = "밀랍수염 영감"
L["DFC_BOSS2"] = "블레지콘"
L["DFC_BOSS3"] = "양초왕"
L["DFC_BOSS4"] = "어둠의 존재"

-- Eco-Dome Al'Dani
L["EDAD_BOSS1"] = "아즈히카르"
L["EDAD_BOSS2"] = "타바트와 아와즈지"
L["EDAD_BOSS3"] = "영혼필경사사"

-- Operation: Floodgate
L["OFG_BOSS1"] = "큰.대.모"
L["OFG_BOSS2"] = "박살 2인조"
L["OFG_BOSS3"] = "늪지면상"
L["OFG_BOSS4"] = "기즐 기가잽"

-- Priory of the Sacred Flames
L["PotSF_BOSS1"] = "대장 데일크라이"
L["PotSF_BOSS2"] = "남작 브라운파이크"
L["PotSF_BOSS3"] = "수도원장 머프레이"

-- The Dawnbreaker
L["TDB_BOSS1"] = "대변자 섀도크라운"
L["TDB_BOSS2"] = "아눕이카즈"
L["TDB_BOSS3"] = "라샤난 "

-- The Rookery
L["TR_BOSS1"] = "키리오스"
L["TR_BOSS2"] = "폭풍수호병 고렌"
L["TR_BOSS3"] = "공허석 괴수"

-- The Stonevault
L["TSV_BOSS1"] = "토.보.무.전."
L["TSV_BOSS2"] = "스카모락"
L["TSV_BOSS3"] = "상급 기계공"
L["TSV_BOSS4"] = "공허 대변자 에리히"

-- Shadowlands
-- Mists of Tirna Scithe
L["MoTS_BOSS1"] = "잉그라 말로크"
L["MoTS_BOSS2"] = "미스트콜러"
L["MoTS_BOSS3"] = "트레도바"

--Theater of Pain
L["ToP_BOSS1"] = "오만불손한 도전자"
L["ToP_BOSS2"] = "선혈토막"
L["ToP_BOSS3"] = "몰락하지 않은 자 자브"
L["ToP_BOSS4"] = "쿨타로크"
L["ToP_BOSS5"] = "무한의 여제 모르드레타"

-- The Necrotic Wake
L["NW_BOSS1"] = "역병뼈닥이"
L["NW_BOSS2"] = "수확자 아마스"
L["NW_BOSS3"] = "의사 스티치플레"
L["NW_BOSS4"] = "냉기결속사 날토르"

-- TO TRANSLATE
-- Halls of Atonement 속죄의 전당
L["HoA_BOSS1"] = "죄악에 물든 거수 할키아스"
L["HoA_BOSS2"] = "에첼론"
L["HoA_BOSS3"] = "대신판관 알리즈"
L["HoA_BOSS4"] = "시종장"

-- Tazavesh: Streets of Wonder
L["TSoW_BOSS1"] = "파수꾼 조펙스"
L["TSoW_BOSS2"] = "대사육장"
L["TSoW_BOSS3"] = "우편물실 대소동"
L["TSoW_BOSS4"] = "마이자의 오아시스"
L["TSoW_BOSS5"] = "소아즈미"

-- Tazavesh: So'leah's Gambit
L["TSLG_BOSS1"] = "힐브란데"
L["TSLG_BOSS2"] = "시간선장 후크테일"
L["TSLG_BOSS3"] = "소레아"
-- END TO TRANSLATE

-- Battle for Azeroth
-- Operation: Mechagon - Workshop
L["OMGW_BOSS1"] = "통통 격투"
L["OMGW_BOSS2"] = "쿠.조."
L["OMGW_BOSS3"] = "기계공의 정원"
L["OMGW_BOSS4"] = "왕 메카곤"

-- Siege of Boralus
L["SoB_BOSS1"] = "난도질꾼 레드후크"
L["SoB_BOSS2"] = "공포의 선장 록우드"
L["SoB_BOSS3"] = "하달 다크패덤"
L["SoB_BOSS4"] = "비크고스"

-- The MOTHERLODE!!
L["TML_BOSS1"] = "동전 투입식 군중 난타기"
L["TML_BOSS2"] = "아제로크"
L["TML_BOSS3"] = "릭사 플럭스플레임"
L["TML_BOSS4"] = "모굴 라즈덩크"

-- Legion

-- Cataclysm
-- Grim Batol
L["GB_BOSS1"] = "장군 움브리스"
L["GB_BOSS2"] = "제련장인 트롱구스"
L["GB_BOSS3"] = "드라가 섀도버너"
L["GB_BOSS4"] = "지하 군주, 에루닥스"

-- UI Strings
L["MODULES"] = "모듈"
L["FINISHED"] = "던전 퍼센트 완료"
L["SECTION_DONE"] = "구역 완료"
L["DONE"] = "구역 퍼센트 완료"
L["DUNGEON_DONE"] = "던전 완료"
L["OPTIONS"] = "옵션"
L["GENERAL_SETTINGS"] = "일반 옵션"
L["Changelog"] = "로그 변경"
L["Version"] = "버전"
L["Important"] = "중요"
L["New"] = "새로운"
L["Bugfixes"] = "오류 수정"
L["Improvment"] = "개선 사항"
L["%month%-%day%-%year%"] = "%year%-%month%-%day%"
L["DEFAULT_PERCENTAGES"] = "기본 퍼센트"
L["DEFAULT_PERCENTAGES_DESC"] = "이 보기는 애드온의 기본 제공 기본값을 표시하며 커스텀 루트 구성을 반영하지 않습니다."
L["ROUTES_DISCLAIMER"] = "기본적으로 Keystone Percentage Helper는 Raider.IO 주간 경로(초보자용)를 사용합니다. 커스텀 루트를 사용하면 나만의 경로를 정의할 수 있습니다. 이러한 경로를 활성화하려면 애드온의 일반 설정에서 '커스텀 루트'를 활성화해야 합니다."
L["ADVANCED_SETTINGS"] = "커스텀 루트"
L["TANK_GROUP_HEADER"] = "보스 퍼센트"
L["ROLES_ENABLED"] = "조건 설정"
L["ROLES_ENABLED_DESC"] = "퍼센트 표시와 알림을 활성화 할 조건 설정"
L["LEADER"] = "파장"
L["TANK"] = "탱커"
L["HEALER"] = "힐러"
L["DPS"] = "딜러"
L["ENABLE_ADVANCED_OPTIONS"] = "커스텀 루트 활성화"
L["ADVANCED_OPTIONS_DESC"] = "이를 통해 각 보스가 도달하기 전에 사용자 정의 백분율을 설정하고 누락된 백분율을 그룹에 알릴지 여부를 선택할 수 있습니다."
L["INFORM_GROUP"] = "그룹 알림"
L["INFORM_GROUP_DESC"] = "진행도가 모자랄 경우 채팅으로 메시지 보내기"
L["MESSAGE_CHANNEL"] = "채팅 채널"
L["MESSAGE_CHANNEL_DESC"] = "알림에 사용할 채팅 채널을 선택하세요."
L["PARTY"] = "파티"
L["SAY"] = "일반"
L["YELL"] = "외침"
L["PERCENTAGE"] = "퍼센트"
L["PERCENTAGE_DESC"] = "텍스트 크기를 조정하세요"
L["FONT"] = "글꼴"
L["FONT_SIZE"] = "글꼴 크기"
L["FONT_SIZE_DESC"] = "텍스트 크기를 조정하세요"
L["POSITIONING"] = "위치"
L["COLORS"] = "색상"
L["IN_PROGRESS"] = "진행중"
L["MISSING"] = "모자람"
L["VALIDATE"] = "확인"
L["CANCEL"] = "취소"
L["POSITION"] = "정렬"
L["TOP"] = "위"
L["CENTER"] = "중앙"
L["BOTTOM"] = "아래"
L["X_OFFSET"] = "X 오프셋"
L["Y_OFFSET"] = "Y 오프셋"
L["SHOW_ANCHOR"] = "표시 위치 확인"
L["ANCHOR_TEXT"] = "< KPH 표시 >"
L["RESET_DUNGEON"] = "기본값으로 재설정"
L["RESET_DUNGEON_DESC"] = "이 던전의 모든 보스 진행도를 기본값으로 재설정 합니다"
L["RESET_DUNGEON_CONFIRM"] = "이 던전의 모든 보스 진행도를 기본값으로 재설정 하시겠습니까?"
L["RESET_ALL_DUNGEONS"] = "모든 던전 재설정"
L["RESET_ALL_DUNGEONS_DESC"] = "모든 던전을 기본값으로 재설정"
L["RESET_ALL_DUNGEONS_CONFIRM"] = "모든 던전을 기본값으로 재설정 하시겠습니까?"
L["NEW_SEASON_RESET_PROMPT"] = "새로운 Mythic+ 시즌이 시작되었습니다. 모든 던전 값을 기본값으로 재설정 하시겠습니까?"
L["YES"] = "예"
L["NO"] = "아니요"
L["WE_STILL_NEED"] = "더 잡아야 됨"
L["NEW_ROUTES_RESET_PROMPT"] = "이 버전에서는 기본 던전 경로가 업데이트되었습니다. 현재 던전 경로를 새로운 기본값으로 재설정 하시겠습니까?"
L["RESET_ALL"] = "모든 던전 초기화"
L["RESET_CHANGED_ONLY"] = "변경 사항만 초기화"
L["CHANGED_ROUTES_DUNGEONS_LIST"] = "다음 던전의 경로가 업데이트 되었습니다.:"

-- Main Display
L["MAIN_DISPLAY"] = "Main Display"
L["SHOW_REQUIRED_PREFIX"] = "Show required text prefix"
L["SHOW_REQUIRED_PREFIX_DESC"] = "When the base value is numeric (e.g., 12.34%), prefix it with a label (e.g., 'Required:'). No prefix is added for DONE/SECTION/DUNGEON states."
L["LABEL"] = "Prefix"
L["REQUIRED_LABEL_DESC"] = "Label displayed before the numeric required percentage (e.g., 'Required: 12.34%').\n\nClear the field to reset to the default value."
L["SHOW_CURRENT_PERCENT"] = "Show current %"
L["SHOW_CURRENT_PERCENT_DESC"] = "Display the current overall enemy forces percent (from the scenario tracker)."
L["CURRENT_LABEL_DESC"] = "Label displayed before the current percentage value.\n\nClear the field to reset to the default value."
L["SHOW_CURRENT_PULL_PERCENT"] = "Show current pull % (MDT)"
L["SHOW_CURRENT_PULL_PERCENT_DESC"] = "Display the real current pull percent based on engaged mobs using MDT data."
L["PULL_LABEL_DESC"] = "Label displayed before the current pull percentage value.\n\nClear the field to reset to the default value."
L["USE_MULTI_LINE_LAYOUT"] = "Use multi-line layout"
L["USE_MULTI_LINE_LAYOUT_DESC"] = "Show each selected value on a new line."
L["SINGLE_LINE_SEPARATOR"] = "Single-line separator"
L["SINGLE_LINE_SEPARATOR_DESC"] = "Separator used between items when not using multi-line layout."
L["FONT_ALIGN"] = "Font align"
L["FONT_ALIGN_DESC"] = "Horizontal alignment for the display text."
L["PREFIX_COLOR"] = "Prefixes color"
L["PREFIX_COLOR_DESC"] = "Color applied to labels/prefixes (Required, Current, Pull)."
L["MAX_WIDTH"] = "Max width (single-line)"
L["MAX_WIDTH_DESC"] = "Maximum width in pixels for single-line layout. 0 = automatic (no wrapping)."
L["REQUIRED_DEFAULT"] = "Required :"
L["CURRENT_DEFAULT"] = "Current :"
L["PULL_DEFAULT"] = "Pull :"

L["FORMAT_MODE"] = "Text format"
L["FORMAT_MODE_DESC"] = "Select how to display the progress."
L["COUNT"] = "Count"

-- Export/Import
L["EXPORT_DUNGEON"] = "던전 내보내기"
L["EXPORT_DUNGEON_DESC"] = "이 던전의 사용자 지정 진행도 내보내기"
L["IMPORT_DUNGEON"] = "던전 가져오기"
L["IMPORT_DUNGEON_DESC"] = "이 던전의 사용자 지정 진행도 가져오기"
L["EXPORT_ALL_DUNGEONS"] = "모든 던전 내보내기"
L["EXPORT_ALL_DUNGEONS_DESC"] = "모든 던전에 대한 설정 내보내기"
L["EXPORT_ALL_DIALOG_TEXT"] = "아래 문자열을 복사하여 모든 던전에 대한 사용자 지정 진행도를 공유하세요:"
L["IMPORT_ALL_DUNGEONS"] = "모든 던전 가져오기"
L["IMPORT_ALL_DUNGEONS_DESC"] = "모든 던전에 대한 설정 가져오기"
L["IMPORT_ALL_DIALOG_TEXT"] = "아래 문자열을 붙여넣어 모든 던전에 대한 사용자 지정 진행도를 가져옵니다:"
L["EXPORT_SECTION"] = "구역 내보내기"
L["EXPORT_SECTION_DESC"] = "모든 던전 설정을 %s로 내보내기."
L["EXPORT_SECTION_DIALOG_TEXT"] = "아래 문자열을 복사하여 %s에 대한 사용자 지정 진행도를 공유합니다:"
L["IMPORT_SECTION"] = "구역 가져오기"
L["IMPORT_SECTION_DESC"] = "%s에 대한 모든 던전 설정 가져오기."
L["IMPORT_SECTION_DIALOG_TEXT"] = "아래 문자열을 붙여넣어 %에 대한 사용자 지정 진행도를 가져옵니다:"
L["EXPORT_DIALOG_TEXT"] = "아래 문자열을 복사하여 사용자 지정 진행도를 공유하세요:"
L["IMPORT_DIALOG_TEXT"] = "내보낸 문자열을 아래에 붙여넣습니다:"
L["IMPORT_SUCCESS"] = "%s에 대한 사용자 지정 진행도 가져오기."
L["IMPORT_ALL_SUCCESS"] = "모든 던전을 위한 사용자 지정 진행도 가져오기."
L["IMPORT_ERROR"] = "문자열이 잘못되었습니다."
L["IMPORT_DIFFERENT_DUNGEON"] = "%s에 대한 설정을 가져왔습니다. 해당 던전에 대한 옵션을 엽니다."

-- MDT Integration
L["MDT_INTEGRATION_FEATURES"] = "Mythic Dungeon Tools 통합 기능"
L["MOB_PERCENTAGES_INFO"] = "• |cff00ff00몹 퍼센트|r: M+ 던전의 네임플레이트에 몹의 퍼센트를 표시합니다."
L["MOB_INDICATOR_INFO"] = "• |cff00ff00몹 표시|r: 현재 MDT 경로에 포함된 몹을 표시하기 위해 네임플레이트를 표시합니다."

-- Mob Percentages
L["MOB_PERCENTAGES"] = "몹 퍼센트"
L["ENABLE_MOB_PERCENTAGES"] = "몹 퍼센트 활성화"
L["ENABLE_MOB_PERCENTAGES_DESC"] = "신화+ 던전에서 각 몹의 퍼센트 표시"
L["MOB_PERCENTAGE_FONT_SIZE"] = "글꼴 크기"
L["MOB_PERCENTAGE_FONT_SIZE_DESC"] = "몹 퍼센트 표시의 글꼴 크기를 설정합니다."
L["MOB_PERCENTAGE_POSITION"] = "위치"
L["MOB_PERCENTAGE_POSITION_DESC"] = "네임플레이트를 기준으로 퍼센트 표시 위치를 ​​설정합니다."
L["RIGHT"] = "오른쪽"
L["LEFT"] = "왼쪽"
L["TOP"] = "위"
L["BOTTOM"] = "아래"
L["MDT_WARNING"] = "이 기능을 사용하려면 Mythic Dungeon Tools(MDT) 애드온을 설치해야 합니다."
L["MDT_FOUND"] = "Mythic Dungeon Tools(MDT)를 찾았습니다. 몹 퍼센트는 MDT 데이터를 사용합니다."
L["MDT_LOADED"] = "Mythic Dungeon Tools(MDT)가 성공적으로 로드되었습니다."
L["MDT_NOT_FOUND"] = "Mythic Dungeon Tools를 찾을 수 없습니다. 몹 퍼센트가 표시되지 않습니다. 이 기능을 사용하려면 MDT를 설치하세요."
L["MDT_INTEGRATION"] = "MDT 통합"
L["MDT_SECTION_WARNING"] = "이 섹션을 사용하려면 Mythic Dungeon Tools(MDT) 애드온을 설치해야 합니다."
L["DISPLAY_OPTIONS"] = "디스플레이 옵션"
L["APPEARANCE_OPTIONS"] = "외형 옵션"
L["SHOW_PERCENTAGE"] = "퍼센트 보기"
L["SHOW_PERCENTAGE_DESC"] = "각 몹의 퍼센트를 표시합니다."
L["SHOW_COUNT"] = "카운트 보기"
L["SHOW_COUNT_DESC"] = "각 몹의 카운트를 표시합니다."
L["SHOW_TOTAL"] = "전부 보기"
L["SHOW_TOTAL_DESC"] = "100%에 필요한 총 카운트를 표시합니다."
L["TEXT_COLOR"] = "글자 색"
L["TEXT_COLOR_DESC"] = "네임플레이트에 표시될 글자 색을 지정합니다."
L["CUSTOM_FORMAT"] = "표시 형식"
L["CUSTOM_FORMAT_DESC"] = "사용자 지정 형식을 입력하세요. 퍼센트는 %s, 카운트는 %c, 합계는 %t를 사용하세요. 예: (%s), %s | %c/%t, %c 등."
L["RESET_TO_DEFAULT"] = "초기화"
L["RESET_FORMAT_DESC"] = "표시 형식을 기본값(괄호)으로 재설정합니다."

-- Mob Indicators
L["MOB_INDICATOR"] = "Mob Indicators"
L["ENABLE_MOB_INDICATORS"] = "Enable Mob Indicators"
L["ENABLE_MOB_INDICATORS_DESC"] = "Show an indicator for each mob included in the MDT route"
L["MOB_INDICATOR_TEXTURE_HEADER"] = "Indicator icon"
L["MOB_INDICATOR_TEXTURE"] = "Indicator icon (ID or Path)"
L["MOB_INDICATOR_TEXTURE_SIZE"] = "Size"
L["MOB_INDICATOR_TEXTURE_SIZE_DESC"] = "Set the texture size for the indicator icon"
L["MOB_INDICATOR_COLORING_HEADER"] = "Coloring"
L["MOB_INDICATOR_BEHAVIOR"] = "Behavior"
L["MOB_INDICATOR_AUTO_ADVANCE"] = "Auto-advance pull"
L["MOB_INDICATOR_AUTO_ADVANCE_DESC"] = "Auto-advance pull when no current-pull mobs are visible."
L["MOB_INDICATOR_TINT"] = "Tint the indicator"
L["MOB_INDICATOR_TINT_DESC"] = "Tint the indicator icon"
L["MOB_INDICATOR_TINT_COLOR"] = "Color"
L["MOB_INDICATOR_POSITION_HEADER"] = "Positioning"

