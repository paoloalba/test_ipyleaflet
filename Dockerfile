FROM jupyter/scipy-notebook:python-3.10.8 as base

RUN pip install ipywidgets
RUN pip install nb_black

RUN pip install plotly
RUN pip install geopandas
RUN pip install ipyleaflet

RUN jupyter nbextension enable --py --sys-prefix ipyleaflet
# RUN jupyter labextension install jupyter-leaflet

FROM base as debug
RUN pip install debugpy

CMD ["python", "-m", "debugpy", "--listen", "0.0.0.0:8889", "--wait-for-client", "main.py"]

FROM base as prod

CMD ["jupyter", "lab", "--ip", "0.0.0.0"]
# CMD ["jupyter", "notebook", "--ip", "0.0.0.0"]
