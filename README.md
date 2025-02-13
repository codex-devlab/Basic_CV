# Basic_CV


## Run With Docker

* Start Container
  * Using Docker run
    ```shell
    $ docker run -itd --volume "`git rev-parse --show-toplevel`:/data:rw" --user `id -u`:`id -g` --name pandoc_convert --entrypoint /bin/sh pandoc/latex:3.6.3-alpine
    ```
  * Using Docker compose
    ```shell
    $ cd Basic_CV
    $ echo "UID=$(id -u)" > container/.env
    $ echo "GID=$(id -g)" >> container/.env
    $ echo "PROJECT_PATH=$(git rev-parse --show-toplevel)" >> container/.env
    $ docker compose -f container/docker-compose.yaml up -d
    ```

* Running Convert to Docx Command inside container
    ```shell
    $ docker exec -it pandoc_convert /bin/sh
    (pandoc_convert)$ pandoc resume.tex --trace=false --filter tools/pandoc-crossref --reference-doc=reference-doc/ResumsumeViking-Word-Resume-Simple.docx  -o conv_resume.docx --verbose --lua-filter=tools/Conv_modern_to_standard.lua
    ```


## Reference
* [Example_LaTeXTemplates_awesome-resume-cv_v1.3](https://www.latextemplates.com/template/awesome-resume-cv)
* [CTAN](https://ctan.org/)
  * [lshort – A short introduction to LaTeX 2e](https://ctan.org/pkg/lshort)
    * [LaTeX-ko-Ishort Manual PDF](http://mirrors.ctan.org/info/lshort/korean/lshort-ko.pdf)
    * [LaTeX-en-Ishort Manual PDF](http://mirrors.ctan.org/info/lshort/english/lshort.pdf)
      * [Github-LaTeX-en](https://github.com/oetiker/lshort)
  * []
* [Pandoc Crossref](https://github.com/lierdakil/pandoc-crossref)  
  pandoc filter for numbering figures, equations, tables and cross-references to them.