import uuid
from cassandra.cqlengine import columns
from django_cassandra_engine.models import DjangoCassandraModel


class ExampleModel(DjangoCassandraModel):
    example_id = columns.UUID(primary_key=True, default=uuid.uuid4)
    example_type = columns.Boolean(default=False)
    created_at = columns.DateTime()
    description = columns.Text(required=False)
