

# apk를 사용하여 Pandoc과 LaTeX 관련 패키지 설치
apk add --no-cache texlive-full \
                   ttf-freefont \
                   font-noto \
                   ghostscript \
                   texlive-fonts-recommended \
                   texlive-fonts-extra;

xelatex --version