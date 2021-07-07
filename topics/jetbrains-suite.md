# JetBrains Suite #

## Properties ##
You can use environment variables to specify idea.properties file to be used
Intellij: ``IDEA_PROPERTIES``
PyCharm: ``PYCHARM_PROPERTIES``

copy from install_dir/bin and edit new file
```
idea.config.path=d:/data/pycharm_config
idea.system.path=d:/data/pycharm_system
idea.plugins.path=${idea.config.path}/plugins
idea.log.path=${idea.system.path}/log
```
