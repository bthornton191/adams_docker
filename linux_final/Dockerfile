# syntax=docker/dockerfile:1
FROM bthornton191/adams_build1:2022_1-rl8.4
LABEL maintainer=ben.thornton@hexagon.com

RUN rm -rf /installers
RUN rm -rf help/
RUN rm -rf */examples/
RUN rm -rf */*.cdb/

ENV LIB_ARCH LX64

RUN mkdir workdir
WORKDIR /workdir
ENTRYPOINT [ "/Adams/2022_1/mdi" ]
