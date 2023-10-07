# Clash Subcribe

## Start container

```bash
nu create.nu
```

## Access Web Service

1. Open web browser, access `https://hutaosubconverter.com/`
2. Fill the backend address with `http://127.0.0.1:25500/sub?`
3. Copy the subcribe address from the web

## Download the policy and use it

```bash
curl -sSL "<URL>" -o config.yaml
sudo install -o nobody -g nobody -Dm644 config.yaml /etc/clash/config.yaml
sudo systemctl restart clash@nobody
```
