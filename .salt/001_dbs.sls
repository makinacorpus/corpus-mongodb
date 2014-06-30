{% set cfg = opts.ms_project %}
{% set data = cfg.data %}
include:
  - makina-states.services.db.mongodb.hooks

{% import "makina-states/services/db/mongodb/init.sls" as macros with context %}
{% for dbext in data.databases %}
{% for db, dbdata in dbext.items() %}
{{ macros.mongodb_db(db, user=dbdata.user, password=dbdata.password) }}
{%endfor %}
{%endfor%}

{% for userdict in data.get('users', {}) %}
{% for user, data  in userdict.items() %}
{% set data = data.copy() %}
{% set pw = data.pop('password', '') %}
{{macros.mongodb_user(user, pw, **data) }}
{% endfor %}
{% endfor %}
