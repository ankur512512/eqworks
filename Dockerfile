FROM python:3.8.12

COPY application ws-product-python
WORKDIR ws-product-python
RUN python -m pip install pipenv
RUN pipenv install

CMD ["pipenv", "run", "start", "--host", "0.0.0.0"]
