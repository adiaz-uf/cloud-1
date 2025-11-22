# cloud-1
Automated deployment of a web app on a AWS server.

```bash
docker build -t ansible-test .
docker run -d --name ansible-test-container -p 2222:22 ansible-test
```
