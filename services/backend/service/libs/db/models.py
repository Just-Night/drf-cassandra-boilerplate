import uuid
from django.utils import timezone

from django_cassandra_engine.models import DjangoCassandraModel
from django.db import models
from cassandra.cqlengine import columns


# Short "null=True, blank=True" snippet
NB = {
    'null': True,
    'blank': True,
}


class BaseModel(models.Model):
    uuid = models.UUIDField(
        primary_key=True,
        default=uuid.uuid4,
        editable=False,
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(null=True, blank=True)

    class Meta:
        abstract = True

    def save(self, *args, **kwargs):
        self.updated_at = timezone.now()
        return super().save(*args, **kwargs)


class BaseDiscordModel(models.Model):
    id = models.CharField(max_length=20, unique=True, primary_key=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True


class CassBaseModel(DjangoCassandraModel):
    __abstract__ = True

    uuid = columns.UUID(
        primary_key=True,
        default=uuid.uuid4
        )
