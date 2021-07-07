# proxy settings #

## environment variables ##
maybe you need to set these
```bash
export http_proxy="http://company.proxy:1234"
export https_proxy="https://company.proxy:1234" #could be same as http_proxy
```
if you dont want to use proxy for specific hosts:
```bash
export no_proxy="server1,server2,server3 "
```
