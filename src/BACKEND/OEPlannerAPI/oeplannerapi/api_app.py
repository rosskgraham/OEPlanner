import os

from celery import Celery

celery = Celery(__name__)
celery.conf.broker_url = os.getenv("CELERY_BROKER_URL")
celery.conf.result_backend = backend=os.getenv('CELERY_RESULTS_BACKEND_URL')
