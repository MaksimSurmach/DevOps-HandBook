# How to unveil secret from file.

* goto https://jenkins_url/script
* write script ```println(hudson.util.Secret.fromString("{XXX=}").getPlainText())```
* replace ```XXX=``` to secret from file
* PROFIT
