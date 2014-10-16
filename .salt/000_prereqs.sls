{% set cfg = opts.ms_project %}
{% set data = cfg.data %}
include:
  - makina-states.services.db.mongodb

sed -re "s/bind_ip=127.0.0.1/bind_ip=0.0.0.0/g" -i /etc/mongod.conf:
  cmd.run:
    - onlyif: test "x$(grep -q -- "bind_ip=127.0.0.1" /etc/mongod.conf;echo $?)" = "x0"
    - watch:
      - mc_proxy: mongodb-post-conf
    - watch_in:
      - mc_proxy: mongodb-pre-restart
  
