import os

from celery import Celery

celery = Celery(__name__)
celery.conf.broker_url = os.getenv("CELERY_BROKER_URL")
