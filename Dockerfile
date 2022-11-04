FROM bcgovimages/von-image:node-1.12-6

ENV LOG_LEVEL ${LOG_LEVEL:-info}
ENV RUST_LOG ${RUST_LOG:-warning}

ADD config ./config
ADD server/requirements.txt server/
#RUN pip install --upgrade pip
RUN pip install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple -r server/requirements.txt
COPY generate_indy_pool_transactions /home/indy/.pyenv/versions/3.6.13/bin/generate_indy_pool_transactions

ADD --chown=indy:indy indy_config.py /etc/indy/
ADD --chown=indy:indy . $HOME

RUN mkdir -p \
    $HOME/cli-scripts \
    && chmod -R ug+rw $HOME/cli-scripts
