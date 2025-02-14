# Basic_CV

This project provides a Docker-based solution for converting LaTeX-formatted resumes (`resume.tex`) into DOCX format using Pandoc.

## Prerequisites

- [Docker](https://www.docker.com/get-started) installed on your system.

## Getting Started

Follow the steps below to set up and run the conversion process:

### 1. Clone the Repository

```bash
git clone https://github.com/codex-devlab/Basic_CV.git
cd Basic_CV
```

### 2. Start the Docker Container

#### Option A: Using docker run

```shell
docker run -itd \
  --volume "$(git rev-parse --show-toplevel)":/data:rw \
  --user $(id -u):$(id -g) \
  --name pandoc_convert \
  --entrypoint /bin/sh \
  pandoc/latex:3.6.3-alpine
```
#### Option B: Using Docker Compose


```shell
cd Basic_CV
echo "UID=$(id -u)" > container/.env
echo "GID=$(id -g)" >> container/.env
echo "PROJECT_PATH=$(git rev-parse --show-toplevel)" >> container/.env
docker compose -f container/docker-compose.yaml up -d
```

#### 3. Convert the LaTeX Resume to DOCX

Access the running container and execute the conversion command:

```shell
docker exec -it pandoc_convert /bin/sh
```

Inside the container:

```shell
cd data
(pandoc_convert)$ pandoc example/LaTeXTemplates_awesome-resume-cv_v1.3/resume.tex --trace=false --filter tools/pandoc-crossref --reference-doc=reference-doc/ResumsumeViking-Word-Resume-Simple.docx  -o conv_resume.docx --verbose --lua-filter=tools/Conv_modern_to_standard.lua
```

The converted conv_resume.docx file will be available in your project directory.



## Reference
* [Example_LaTeXTemplates_awesome-resume-cv_v1.3](https://www.latextemplates.com/template/awesome-resume-cv)
* [CTAN](https://ctan.org/)
  * [lshort – A short introduction to LaTeX 2e](https://ctan.org/pkg/lshort)
    * [LaTeX-ko-Ishort Manual PDF](http://mirrors.ctan.org/info/lshort/korean/lshort-ko.pdf)
    * [LaTeX-en-Ishort Manual PDF](http://mirrors.ctan.org/info/lshort/english/lshort.pdf)
      * [Github-LaTeX-en](https://github.com/oetiker/lshort)

* [Pandoc Crossref](https://github.com/lierdakil/pandoc-crossref)  
  pandoc filter for numbering figures, equations, tables and cross-references to them.