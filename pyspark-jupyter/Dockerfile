ARG base

FROM $base

ARG spark_uid=185

USER 0

ENV PYTHONPATH $PYTHONPATH:/opt/spark/python:/opt/spark/python/lib/py4j-0.10.9-src.zip
ENV PYSPARK_PYTHON $PYENV_ROOT/shims/python3
ENV PYSPARK_DRIVER_PYTHON $PYENV_ROOT/shims/python3

ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_MASTER_LOG /spark/logs

# setup Node.js v15.x for Jupyter Lab extensions
RUN curl -sL https://deb.nodesource.com/setup_15.x | bash -

RUN set -eux; \
  apt update && \
  apt install -y --no-install-recommends \
    nodejs && \
  rm -rf /var/cache/apt/* && \
  rm -rf /var/lib/apt/lists/*

COPY requirements.txt /opt/requirements.txt
RUN set -eux; \
  pip install --no-cache-dir -r /opt/requirements.txt && \
  rm /opt/requirements.txt

RUN mkdir -p $SPARK_MASTER_LOG && \
  ln -sf /dev/stdout $SPARK_MASTER_LOG/spark-master.out

# Install Jupyter lab extentions
# Enable server extension as spark_uid must specify full path to jupyter, because sudo does not inherit PATH
RUN jupyter labextension install @lckr/jupyterlab_variableinspector --no-build && \
  jupyter labextension install @jupyterlab/toc --no-build && \
  jupyter labextension install @ryantam626/jupyterlab_code_formatter --no-build && \
  jupyter lab build && \
  sudo -u#${spark_uid} $PYENV_ROOT/shims/jupyter serverextension enable --py jupyterlab_code_formatter

COPY jupyter-entrypoint.sh /opt/
COPY jupyter_notebook_config.py /etc/jupyter/jupyter_notebook_config.py
RUN chmod +x /opt/jupyter-entrypoint.sh
RUN chmod 666 /etc/jupyter/jupyter_notebook_config.py

USER ${spark_uid}

ENTRYPOINT ["/opt/jupyter-entrypoint.sh"]
