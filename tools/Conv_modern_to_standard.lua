function RawBlock(el)
  if el.format == "latex" then
    local replacements = {
      -- 개인 정보 변환
      {"\\name{(.-)}{(.-)}", "\\textbf{%1 %2}"},
      {"\\position{(.-)}", "\\textit{%1}"},
      {"\\mobile{(.-)}", "\\textbf{Mobile:} %1"},
      {"\\email{(.-)}", "\\textbf{Email:} \\href{mailto:%1}{%1}"},
      {"\\homepage{(.-)}", "\\textbf{Website:} \\url{%1}"},
      {"\\github{(.-)}", "\\textbf{GitHub:} \\url{https://github.com/%1}"},
      {"\\linkedin{(.-)}", "\\textbf{LinkedIn:} \\url{https://linkedin.com/in/%1}"},
      {"\\quote{(.-)}", "\\textit{%1}"},

      -- 섹션 및 서브섹션 변환
      {"\\cvsection{(.-)}", "\\section*{%1}"},
      {"\\cvsubsection{(.-)}", "\\subsection*{%1}"},

      -- 경력 및 수상 항목 변환
      {"\\cventry{(.-)}{(.-)}{(.-)}{(.-)}{(.-)}{(.-)}", "\\textbf{%2} (%3) \\\\ \\textit{%1} \\\\ %4 - %5 \\\\ %6"},
      {"\\cvhonor{(.-)}{(.-)}{(.-)}{(.-)}", "\\textbf{%1}: %2 (%3, %4)"},

      -- 리스트 변환
      {"\\begin{cvitems}", "\\begin{itemize}"},
      {"\\end{cvitems}", "\\end{itemize}"},
      {"\\item (.-)", "\\item %1"},

      -- 불필요한 명령 제거
      {"\\geometry{.-}", ""},
      {"\\colorlet{.-}", ""},
      {"\\setbool{.-}", ""},
      {"\\makecvheader.-", ""},
      {"\\makecvfooter.-", ""},
      {"\\thepage", ""}
    }

    -- 변환 적용
    local content = el.text
    for _, rule in ipairs(replacements) do
      content = content:gsub(rule[1], rule[2])
    end
    return pandoc.RawBlock("latex", content)
  end
end

