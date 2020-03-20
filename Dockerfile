FROM lambci/lambda:build-python3.7

ENV VIRTUAL_ENV=venv
ENV SITE_PACKAGES=/var/task/venv/lib/python3.7/site-packages
ENV PATH $VIRTUAL_ENV/bin:$PATH

RUN python3 -m venv $VIRTUAL_ENV
RUN . $VIRTUAL_ENV/bin/activate

RUN pip install --upgrade pip
RUN pip install s3fs==0.4.0 pystan==2.18 pandas==1.0.3 numpy==1.18.2 fbprophet==0.6 --no-cache

RUN pip uninstall -y matplolib

RUN echo "site-packages size $(du -sh ${SITE_PACKAGES}  | cut -f1)"

RUN rm -rf ${SITE_PACKAGES}/pystan/stan/src/*
RUN rm -rf ${SITE_PACKAGES}/pystan/stan/lib/stan_math/lib/*
RUN rm -rf ${SITE_PACKAGES}/*/test/*
RUN rm -rf ${SITE_PACKAGES}/*/tests/*
RUN echo "site-packages size after reduce $(du -sh ${SITE_PACKAGES} | cut -f1)"