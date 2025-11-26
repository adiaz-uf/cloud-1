# cloud-1
Automated deployment of a web app on a AWS server.

```bash
docker build -t ansible-target .
docker run -d -p 2222:22 --name my-target ansible-target
```
