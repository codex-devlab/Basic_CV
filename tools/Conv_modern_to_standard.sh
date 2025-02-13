#!/bin/sh

INPUT_DIR="resume"
OUTPUT_DIR="resume_fixed"
MAIN_INPUT_FILE="resume.tex"
MAIN_OUTPUT_FILE="resume_fixed.tex"

# 출력 디렉토리 생성
mkdir -p "$OUTPUT_DIR"

fix_all() {
  perl -0777 -pe '
  # 색상 설정 추가 (중복되지 않도록 맨 앞에 추가)
  BEGIN { print "\\providecommand{\\awesomecolor}{red}\n"; }

  # 기존 색상 설정 제거 및 변환
  s/\\colorlet\{awesome\}\{[^}]+\}//g;
  s/\\textcolor\{awesome\}/\\textcolor{red}/g;

  # 패키지 관련 수정
  s/\\geometry\{[^}]+\}/\\usepackage{geometry}\n\\geometry{margin=1in}/g;

  # 제목 변환
  s/\\cvsection\{([^}]+)\}/\\section{\1}/g;
  s/\\cvsubsection\{([^}]+)\}/\\subsection{\1}/g;

  # 인적 사항 제거
  s/\\name\{([^}]+)\}\{([^}]+)\}/\\author{\1 \2}/g;
  s/\\position\{([^}]+)\}/\\title{\1}/g;
  s/\\mobile\{[^}]+\}//g;
  s/\\email\{[^}]+\}//g;
  s/\\homepage\{[^}]+\}//g;
  s/\\github\{[^}]+\}//g;
  s/\\linkedin\{[^}]+\}//g;

  # 명언 처리
  s/\\quote\{([^}]+)\}/\\begin{quote}\1\\end{quote}/g;

  # 헤더/푸터 제거
  s/\\makecvheader\[C\]//g;
  s/\\makecvfooter//g;
  s/\\thepage//g;

  # \cvhonor 변환 (description 환경 사용)
  s/\\begin\{cvhonors\}/\\begin{description}/g;
  s/\\end\{cvhonors\}/\\end{description}/g;
  s/\\cvhonor\s*\{\s*([^}]+)\s*\}\s*\{\s*([^}]+)\s*\}\s*\{\s*([^}]*)\s*\}\s*\{\s*([^}]+)\s*\}/  \\item[\1] \2 (\4)/gs;

  # \cventry 변환 (description 환경 사용)
  s/\\begin\{cventries\}/\\begin{description}/g;
  s/\\end\{cventries\}/\\end{description}/g;
  s/\\cventry\s*\{\s*([^}]+)\s*\}\s*\{\s*([^}]+)\s*\}\s*\{\s*([^}]+)\s*\}\s*\{\s*([^}]+)\s*\}\s*\{\s*([^}]*)\s*\}/  \\item[\1] \2, \3 (\4)\n    \5/gs;

  # \input 경로 수정
  s#\\input\{resume/#\\input\{resume_fixed/#g;
  ' "$1" > "$2"
}

# 메인 파일 변환
fix_all "$MAIN_INPUT_FILE" "$MAIN_OUTPUT_FILE"
echo "변환 완료: $MAIN_OUTPUT_FILE"

# resume 디렉토리 내부의 모든 .tex 파일 변환
for file in "$INPUT_DIR"/*.tex; do
  filename=$(basename "$file")
  fix_all "$file" "$OUTPUT_DIR/$filename"
  echo "변환 완료: $OUTPUT_DIR/$filename"
done
