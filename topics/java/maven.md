# Maven # 

## Parent Pom ##
Parent dependencies can't be left out. 

## Profiles ##
specify profile to use with ``-P`` argument e.g. ``-Pcoverage``

## MAVEN_OPTS ##
The [MAVEN_OPTS](https://maven.apache.org/configure.html#maven_opts-environment-variable) environment variable contains parameters used to start up the JVM running Maven and can be used to supply additional options. 
This includes JVM memory pool parameters.

## settings.xml ##
set localRepository and proxy 
```xml
<localRepository>d:\data\m2\repository</localRepository>
    
<proxies>
  <proxy>
    <active>true</active>
    <protocol>http</protocol>
    <host>PROXY_SERVER</host>
    <port>PROXY_PORT</port>
    <nonProxyHosts>SERVER1|SERVER2|*.HOST.ADDRESS|localhost</nonProxyHosts>
  </proxy>
</proxies>
```
